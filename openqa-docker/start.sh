#!/bin/bash
set -eu

arch="${1:-"$(uname -m)"}"
postgres_dir="$(pwd)/data-postgres"
openqa_dir="$(pwd)/data"
openqa_web_port=80
openqa_vnc_port=5991

mkdir -p "$openqa_dir"/factory/{iso,hdd,other,tmp} "$openqa_dir"/{testresults,tests,conf} "$postgres_dir"

cat << EOF > "$openqa_dir"/conf/client.conf
[openqa_webui]
key = 1234567890ABCDEF
secret = 1234567890ABCDEF

[localhost]
key = 1234567890ABCDEF
secret = 1234567890ABCDEF

EOF

cat << EOF > "$openqa_dir"/conf/openqa.ini
[global]
branding=plain
download_domains = rockylinux.org fedoraproject.org opensuse.org

[auth]
method = Fake

EOF

cat << EOF > "$openqa_dir"/conf/database.ini

[production]
dsn = DBI:Pg:dbname=openqa;host=db;user=openqa;password=openqa

[development]
dsn = DBI:Pg:dbname=openqa;host=db;user=openqa;password=openqa

EOF

cat << EOF > "$openqa_dir"/conf/workers.ini
[global]
BACKEND = qemu
HOST = http://openqa_webui

EOF

if [[ ! -d "$openqa_dir"/tests/rocky ]]; then
    git clone https://github.com/rocky-linux/os-autoinst-distri-rocky.git "$openqa_dir"/tests/rocky
    # Workaround - Replace the 'text' parameter of python subprocess.run with 'universal_newlines'.
    #              These parameters mean the same thing, but 'text' is only available after 
    #              python 3.7 which is too new for the OpenSUSE container image.
    sed s/text=True/universal_newlines=True/ -i.orig "$openqa_dir"/tests/rocky/fifloader.py
fi

mkdir -p "$openqa_dir"/factory/iso/fixed
if [[ ! -f "$openqa_dir"/factory/iso/fixed/CHECKSUM.valid ]]; then
    (
    cd "$openqa_dir"/factory/iso/fixed
    curl -C - -O download.rockylinux.org/pub/rocky/8/isos/"$arch"/Rocky-8.4-"$arch"-boot.iso
    curl -C - -O download.rockylinux.org/pub/rocky/8/isos/"$arch"/Rocky-8.4-"$arch"-minimal.iso
    curl -C - -O download.rockylinux.org/pub/rocky/8/isos/"$arch"/Rocky-8.4-"$arch"-dvd1.iso
    curl -C - -O download.rockylinux.org/pub/rocky/8/isos/"$arch"/CHECKSUM
    chmod -R 777 "$openqa_dir"
    shasum -a 256 --ignore-missing -c CHECKSUM
    mv CHECKSUM CHECKSUM.valid
    )
fi

if [[ ! -d openQA ]]; then
    git clone https://github.com/os-autoinst/openQA
    # Pin to fedora version for consistency - https://src.fedoraproject.org/rpms/openqa
    git -C openQA checkout 6541adf5ec360cc3a5ad6966d373f1a3b6cc26aa
fi

docker build openQA/container/webui -t openqa_webui
docker build openQA/container/worker -t openqa_worker
docker pull postgres
docker network create openQA || true

docker build webui_rocky -t openqa_webui_rocky
docker build worker_rocky -t openqa_worker_rocky

echo "Starting postgres"
docker run -d --network openQA -v "$postgres_dir":/var/lib/postgresql/data:z -e POSTGRES_PASSWORD=openqa -e POSTGRES_USER=openqa -e POSTGRES_DB=openqa --network-alias=db --name openqa_db postgres
until docker exec openqa_db pg_isready -h db
do sleep 1; done

echo "Strating webui"
docker run -d --network openQA -v "$openqa_dir":/data:z -p "$openqa_web_port":80 --network-alias=openqa_webui --name openqa_webui --privileged openqa_webui_rocky
until docker exec openqa_webui curl --fail -s "http://localhost/login" > /dev/null
do echo "waiting for webui"; sleep 1; done
docker exec openqa_webui curl "http://localhost/login" # Fake login to set things up
echo "webui ready"

echo "Starting workers"
docker run -d --network openQA -v "$openqa_dir":/data:z -p "$openqa_vnc_port":5991 --network-alias=openqa_worker_1 --name openqa_worker_1 --hostname openqa_worker_1 --privileged openqa_worker_rocky

echo "Updating job templates"
docker exec -w /var/lib/openqa/tests/rocky openqa_webui ./fifloader.py -l -c templates.fif.json templates-updates.fif.json

echo "Posting job"
docker exec openqa_webui openqa-cli api -X POST isos \
    ISO=Rocky-8.4-"$arch"-minimal.iso \
    ARCH="$arch" \
    DISTRI=rocky \
    FLAVOR=minimal-iso \
    VERSION=8 \
    BUILD="-$(date '+%Y-%m-%d.%H:%M:%S')"

