# shellcheck disable=SC2034

#set -x
set -e

full_path="$(realpath "$0")"
dir_path="$(dirname "$full_path")"
parent_path="$(dirname "$dir_path")"

source "${dir_path}/common.sh"

function usage {

  cat <<- "EOF"
    $(basename $0) [optional arguments]

    type:                -t  eg; 'boot', 'minimal', 'dvd', 'dvd1', 'repo', 'koji', 'cache'
    arch:                -a  eg: 'x86_64', 'aarch64', 'ppc64-le' or 's390x'
    iso_version:         -v  eg: '10.3' or '10'
    iso_prefix:          -p  eg: 'Rocky' or 'CentOS-Stream'
    iso_checksum_name:   -c  eg: 'CHECKSUM' or 'SHA256SUM'
    iso_checksum_sig:    -s  eg: '.asc' or '.sig'
    iso_mirror_base:     -b  eg: 'http://dl.rockylinux.org'
    iso_content_dir:     -d  eg: 'stg/rocky'
    iso_key_name:        -k  eg: 'RPM-GPG-KEY-Rocky-9'
    log_dir:             -l  eg: $(pwd)/output/$(date +%Y-%m-%d)
    repo_name:           -r  eg: 'pdot-dev-x86_64'
    koji_tag:            -j  eg: 'dist-rocky10-compose'
EOF
}

optstring="ht:a:v:p:c:s:d:b:k:l:r:j:"

while getopts ${optstring} arg; do
  case ${arg} in
    h)
      usage
      exit 0
      ;;
    t)
      iso_type="${OPTARG}"
      ;;
    a)
      iso_arch="${OPTARG}"
      ;;
    v)
      iso_version="${OPTARG}"
      ;;
    p)
      iso_prefix="${OPTARG}"
      ;;
    c)
      iso_checksum_name="${OPTARG}"
      ;;
    s)
      iso_checksum_sig="${OPTARG}"
      ;;
    b)
      iso_mirror_base="${OPTARG}"
      ;;
    d)
      iso_content_dir="${OPTARG}"
      ;;
    k)
      iso_key_name="${OPTARG}"
      iso_key_url="${iso_mirror_base}/pub/rocky/${iso_key_name}"
      ;;
    l)
      log_dir="${OPTARG}"
      ;;
    r)
      repo_name="${OPTARG}"
      ;;
    j)
      koji_tag="${OPTARG}"
      ;;
    :)
      echo "$0: Must supply an argument to -$OPTARG." >&2
      exit 1
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      echo
      exit 1
      ;;
  esac
done
