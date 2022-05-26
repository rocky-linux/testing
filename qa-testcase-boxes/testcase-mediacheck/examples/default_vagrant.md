# Default Vagrant Example

```
[rocky@localhost ~]$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'rockylinux/8'...
==> default: Matching MAC address for NAT networking...
==> default: Setting the name of the VM: testcase-mediacheck_default_1653246056648_618
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default:
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default:
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
==> default: Mounting shared folders...
    default: /vagrant => /home/rocky/testing/qa-testcase-boxes/testcase-mediacheck
==> default: Running provisioner: Start Timestamp (shell)...
    default: Running: script: Start Timestamp
    default: Starting QA:Testcase-Mediacheck on Sun May 22 19:01:16 UTC 2022
==> default: Running provisioner: Install requirements (shell)...
    default: Running: script: Install requirements
    default: Rocky Linux 8 - AppStream                       5.2 MB/s | 7.8 MB     00:01
    default: Rocky Linux 8 - BaseOS                          1.6 MB/s | 2.6 MB     00:01
    default: Rocky Linux 8 - Extras                           11 kB/s |  11 kB     00:01
    default: Rocky Linux 8 - PowerTools                      3.3 MB/s | 2.2 MB     00:00
    default: Extra Packages for Enterprise Linux 8 - x86_64  5.2 MB/s |  11 MB     00:02
    default: Extra Packages for Enterprise Linux Modular 8 - 907 kB/s | 1.0 MB     00:01
    default: Dependencies resolved.
    default: Nothing to do.
    default: Complete!
    default: Last metadata expiration check: 0:00:02 ago on Sun 22 May 2022 07:01:29 PM UTC.
    default: Package coreutils-8.30-12.el8.x86_64 is already installed.
    default: Package curl-7.61.1-22.el8.x86_64 is already installed.
    default: Package dnf-4.7.0-8.el8.noarch is already installed.
    default: Package rpm-4.14.3-23.el8.x86_64 is already installed.
    default: Package util-linux-2.32.1-35.el8.x86_64 is already installed.
    default: Dependencies resolved.
    default: ================================================================================
    default:  Package            Arch   Version                              Repo       Size
    default: ================================================================================
    default: Installing:
    default:  isomd5sum          x86_64 1:1.2.3-3.el8                        appstream  37 k
    default:  python36           x86_64 3.6.8-38.module+el8.5.0+671+195e4563 appstream  18 k
    default: Installing dependencies:
    default:  python3-pip        noarch 9.0.3-22.el8.rocky.0                 appstream  19 k
    default:  python3-setuptools noarch 39.2.0-6.el8                         baseos    162 k
    default: Enabling module streams:
    default:  python36                  3.6
    default:
    default: Transaction Summary
    default: ================================================================================
    default: Install  4 Packages
    default:
    default: Total download size: 236 k
    default: Installed size: 526 k
    default: Downloading Packages:
    default: (1/4): python3-pip-9.0.3-22.el8.rocky.0.noarch. 100 kB/s |  19 kB     00:00
    default: (2/4): python36-3.6.8-38.module+el8.5.0+671+195  71 kB/s |  18 kB     00:00
    default: (3/4): isomd5sum-1.2.3-3.el8.x86_64.rpm         111 kB/s |  37 kB     00:00
    default: (4/4): python3-setuptools-39.2.0-6.el8.noarch.r 270 kB/s | 162 kB     00:00
    default: --------------------------------------------------------------------------------
    default: Total                                           217 kB/s | 236 kB     00:01
    default: Running transaction check
    default: Transaction check succeeded.
    default: Running transaction test
    default: Transaction test succeeded.
    default: Running transaction
    default:   Preparing        :                                                        1/1
    default:   Installing       : python3-setuptools-39.2.0-6.el8.noarch                 1/4
    default:   Installing       : python36-3.6.8-38.module+el8.5.0+671+195e4563.x86_64   2/4
    default:   Running scriptlet: python36-3.6.8-38.module+el8.5.0+671+195e4563.x86_64   2/4
    default:   Installing       : python3-pip-9.0.3-22.el8.rocky.0.noarch                3/4
    default:   Installing       : isomd5sum-1:1.2.3-3.el8.x86_64                         4/4
    default:   Running scriptlet: isomd5sum-1:1.2.3-3.el8.x86_64                         4/4
    default:   Verifying        : isomd5sum-1:1.2.3-3.el8.x86_64                         1/4
    default:   Verifying        : python3-pip-9.0.3-22.el8.rocky.0.noarch                2/4
    default:   Verifying        : python36-3.6.8-38.module+el8.5.0+671+195e4563.x86_64   3/4
    default:   Verifying        : python3-setuptools-39.2.0-6.el8.noarch                 4/4
    default:
    default: Installed:
    default:   isomd5sum-1:1.2.3-3.el8.x86_64
    default:   python3-pip-9.0.3-22.el8.rocky.0.noarch
    default:   python3-setuptools-39.2.0-6.el8.noarch
    default:   python36-3.6.8-38.module+el8.5.0+671+195e4563.x86_64
    default:
    default: Complete!
==> default: Running provisioner: Prepare testing directories (shell)...
    default: Running: script: Prepare testing directories
==> default: Running provisioner: Rocky 8.6 x86_64 boot ISO (shell)...
    default: Running: script: Rocky 8.6 x86_64 boot ISO
    default: mkdir: created directory '/home/rocky/testing/output/2022-05-22'
    default:
    default: ================================================================================
    default: Derived URLs...
    default:
    default: iso_url:              http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-boot.iso
    default: iso_checksum_url:     http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM
    default: iso_checksum_sig_url: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM.sig
    default: iso_key_url:          https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-rockyofficial
    default:
    default: ================================================================================
    default: Verifying: http://dl.rockylinux.org/pub/rocky/8/isos exists...
    default:
    default:
    default: ================================================================================
    default: Verifying: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-boot.iso exists...
    default:
    default:
    default: ================================================================================
    default: Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM ...
    default:
    default: *   Trying 146.75.94.132...
    default: * TCP_NODELAY set
    default: * Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
    default: > GET /pub/rocky/8/isos/x86_64/CHECKSUM?v=d3323595f51c88acb2169579787405e9 HTTP/1.1
    default: > Host: dl.rockylinux.org
    default: > User-Agent: curl/7.61.1
    default: > Accept: */*
    default: >
    default: < HTTP/1.1 200 OK
    default: < Content-Type: application/octet-stream
    default: < Server: nginx
    default: < Last-Modified: Sun, 15 May 2022 22:25:57 GMT
    default: < ETag: "62817df5-1c2"
    default: < Accept-Ranges: bytes
    default: < Via: 1.1 varnish, 1.1 varnish
    default: < Content-Length: 450
    default: < Date: Sun, 22 May 2022 19:01:34 GMT
    default: < Connection: keep-alive
    default: < X-Served-By: cache-mdw17366-MDW, cache-bur-kbur8200054-BUR
    default: < X-Cache: MISS, MISS
    default: < X-Cache-Hits: 0, 0
    default: < X-Timer: S1653246094.148927,VS0,VE86
    default: <
    default: { [450 bytes data]
    default: * Connection #0 to host dl.rockylinux.org left intact
    default:
    default: ================================================================================
    default: Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM.sig ...
    default:
    default: *   Trying 146.75.94.132...
    default: * TCP_NODELAY set
    default: * Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
    default: > GET /pub/rocky/8/isos/x86_64/CHECKSUM.sig?v=d3323595f51c88acb2169579787405e9 HTTP/1.1
    default: > Host: dl.rockylinux.org
    default: > User-Agent: curl/7.61.1
    default: > Accept: */*
    default: >
    default: < HTTP/1.1 200 OK
    default: < Content-Type: application/octet-stream
    default: < Server: nginx
    default: < Last-Modified: Mon, 16 May 2022 02:41:30 GMT
    default: < ETag: "6281b9da-236"
    default: < Accept-Ranges: bytes
    default: < Via: 1.1 varnish, 1.1 varnish
    default: < Content-Length: 566
    default: < Date: Sun, 22 May 2022 19:01:34 GMT
    default: < Connection: keep-alive
    default: < X-Served-By: cache-mdw17375-MDW, cache-bur-kbur8200094-BUR
    default: < X-Cache: MISS, MISS
    default: < X-Cache-Hits: 0, 0
    default: < X-Timer: S1653246094.298924,VS0,VE155
    default: <
    default: { [566 bytes data]
    default: * Connection #0 to host dl.rockylinux.org left intact
    default:
    default: ================================================================================
    default: Downloading: Rocky-8.6-x86_64-boot.iso ...
    default:
    default: *   Trying 146.75.94.132...
    default: * TCP_NODELAY set
    default: * Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
    default: > GET /pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-boot.iso?v=d3323595f51c88acb2169579787405e9 HTTP/1.1
    default: > Host: dl.rockylinux.org
    default: > User-Agent: curl/7.61.1
    default: > Accept: */*
    default: >
    default: < HTTP/1.1 200 OK
    default: < Content-Type: application/octet-stream
    default: < Server: nginx
    default: < Last-Modified: Sun, 15 May 2022 22:18:32 GMT
    default: < ETag: "62817c38-35800000"
    default: < Via: 1.1 varnish, 1.1 varnish
    default: < Cache-Control: max-age=11059200, public, stale-while-revalidate=86400, stale-if-error=259200
    default: < Accept-Ranges: bytes
    default: < Date: Sun, 22 May 2022 19:01:34 GMT
    default: < Age: 0
    default: < Connection: keep-alive
    default: < X-Served-By: cache-mdw17325-MDW, cache-bur-kbur8200029-BUR
    default: < X-Cache: MISS, MISS
    default: < X-Cache-Hits: 0, 0
    default: < X-Timer: S1653246095.510904,VS0,VE84
    default: < Content-Length: 897581056
    default: <
    default: { [4380 bytes data]
    default: * Connection #0 to host dl.rockylinux.org left intact
    default:
    default: ================================================================================
    default: Importing: RPM-GPG-KEY-rockyofficial ...
    default:
    default: gpg: directory '/root/.gnupg' created
    default: gpg: keybox '/root/.gnupg/pubring.kbx' created
    default: gpg: /root/.gnupg/trustdb.gpg: trustdb created
    default: gpg: key 15AF5DAC6D745A60: public key "Release Engineering <infrastructure@rockylinux.org>" imported
    default: gpg: Total number processed: 1
    default: gpg:               imported: 1
    default:
    default: ================================================================================
    default: Verifying gpg signature: /home/rocky/testing/CHECKSUM.sig ...
    default:
    default: gpg: assuming signed data in '/home/rocky/testing/CHECKSUM'
    default: gpg: Signature made Mon 16 May 2022 02:41:30 AM UTC
    default: gpg:                using RSA key 7051C470A929F454CEBE37B715AF5DAC6D745A60
    default: gpg: Good signature from "Release Engineering <infrastructure@rockylinux.org>" [unknown]
    default: gpg: WARNING: This key is not certified with a trusted signature!
    default: gpg:          There is no indication that the signature belongs to the owner.
    default: Primary key fingerprint: 7051 C470 A929 F454 CEBE  37B7 15AF 5DAC 6D74 5A60
    default:
    default: ================================================================================
    default: Verifying sha256sum: /home/rocky/testing/Rocky-8.6-x86_64-boot.iso ...
    default:
    default: Rocky-8.6-x86_64-boot.iso: OK
    default:
    default: ================================================================================
    default: Verifying internal ISO md5: /home/rocky/testing/Rocky-8.6-x86_64-boot.iso ...
    default:
    default:
    default: The media check is complete, the result is: PASS.
    default:
    default: It is OK to use this media.
    default: Press [Esc] to abort check.
==> default: Running provisioner: Rocky 8.6 x86_64 minimal ISO (shell)...
    default: Running: script: Rocky 8.6 x86_64 minimal ISO
    default:
    default: ================================================================================
    default: Derived URLs...
    default:
    default: iso_url:              http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-minimal.iso
    default: iso_checksum_url:     http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM
    default: iso_checksum_sig_url: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM.sig
    default: iso_key_url:          https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-rockyofficial
    default:
    default: ================================================================================
    default: Verifying: http://dl.rockylinux.org/pub/rocky/8/isos exists...
    default:
    default:
    default: ================================================================================
    default: Verifying: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-minimal.iso exists...
    default:
    default:
    default: ================================================================================
    default: Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM ...
    default:
    default: *   Trying 146.75.94.132...
    default: * TCP_NODELAY set
    default: * Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
    default: > GET /pub/rocky/8/isos/x86_64/CHECKSUM?v=4c92e505b3679b427adb43ac36541725 HTTP/1.1
    default: > Host: dl.rockylinux.org
    default: > User-Agent: curl/7.61.1
    default: > Accept: */*
    default: >
    default: < HTTP/1.1 200 OK
    default: < Content-Type: application/octet-stream
    default: < Server: nginx
    default: < Last-Modified: Sun, 15 May 2022 22:25:57 GMT
    default: < ETag: "62817df5-1c2"
    default: < Accept-Ranges: bytes
    default: < Via: 1.1 varnish, 1.1 varnish
    default: < Content-Length: 450
    default: < Date: Sun, 22 May 2022 19:04:17 GMT
    default: < Connection: keep-alive
    default: < X-Served-By: cache-mdw17331-MDW, cache-bur-kbur8200144-BUR
    default: < X-Cache: MISS, MISS
    default: < X-Cache-Hits: 0, 0
    default: < X-Timer: S1653246258.501824,VS0,VE80
    default: <
    default: { [450 bytes data]
    default: * Connection #0 to host dl.rockylinux.org left intact
    default:
    default: ================================================================================
    default: Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM.sig ...
    default:
    default: *   Trying 146.75.94.132...
    default: * TCP_NODELAY set
    default: * Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
    default: > GET /pub/rocky/8/isos/x86_64/CHECKSUM.sig?v=4c92e505b3679b427adb43ac36541725 HTTP/1.1
    default: > Host: dl.rockylinux.org
    default: > User-Agent: curl/7.61.1
    default: > Accept: */*
    default: >
    default: < HTTP/1.1 200 OK
    default: < Content-Type: application/octet-stream
    default: < Server: nginx
    default: < Last-Modified: Mon, 16 May 2022 02:41:30 GMT
    default: < ETag: "6281b9da-236"
    default: < Accept-Ranges: bytes
    default: < Via: 1.1 varnish, 1.1 varnish
    default: < Content-Length: 566
    default: < Date: Sun, 22 May 2022 19:04:17 GMT
    default: < Connection: keep-alive
    default: < X-Served-By: cache-mdw17347-MDW, cache-bur-kbur8200158-BUR
    default: < X-Cache: MISS, MISS
    default: < X-Cache-Hits: 0, 0
    default: < X-Timer: S1653246258.783926,VS0,VE71
    default: <
    default: { [566 bytes data]
    default: * Connection #0 to host dl.rockylinux.org left intact
    default:
    default: ================================================================================
    default: Downloading: Rocky-8.6-x86_64-minimal.iso ...
    default:
    default: *   Trying 146.75.94.132...
    default: * TCP_NODELAY set
    default: * Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
    default: > GET /pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-minimal.iso?v=4c92e505b3679b427adb43ac36541725 HTTP/1.1
    default: > Host: dl.rockylinux.org
    default: > User-Agent: curl/7.61.1
    default: > Accept: */*
    default: >
    default: < HTTP/1.1 200 OK
    default: < Content-Type: application/octet-stream
    default: < Server: nginx
    default: < Last-Modified: Sun, 15 May 2022 22:21:52 GMT
    default: < ETag: "62817d00-87100000"
    default: < Via: 1.1 varnish, 1.1 varnish
    default: < Cache-Control: max-age=11059200, public, stale-while-revalidate=86400, stale-if-error=259200
    default: < Accept-Ranges: bytes
    default: < Date: Sun, 22 May 2022 19:04:17 GMT
    default: < Age: 0
    default: < Connection: keep-alive
    default: < X-Served-By: cache-mdw17328-MDW, cache-bur-kbur8200047-BUR
    default: < X-Cache: MISS, MISS
    default: < X-Cache-Hits: 0, 0
    default: < X-Timer: S1653246258.916143,VS0,VE75
    default: < Content-Length: 2265972736
    default: <
    default: { [4380 bytes data]
    default: * Connection #0 to host dl.rockylinux.org left intact
    default:
    default: ================================================================================
    default: Importing: RPM-GPG-KEY-rockyofficial ...
    default:
    default: gpg: key 15AF5DAC6D745A60: "Release Engineering <infrastructure@rockylinux.org>" not changed
    default: gpg: Total number processed: 1
    default: gpg:              unchanged: 1
    default:
    default: ================================================================================
    default: Verifying gpg signature: /home/rocky/testing/CHECKSUM.sig ...
    default:
    default: gpg: assuming signed data in '/home/rocky/testing/CHECKSUM'
    default: gpg: Signature made Mon 16 May 2022 02:41:30 AM UTC
    default: gpg:                using RSA key 7051C470A929F454CEBE37B715AF5DAC6D745A60
    default: gpg: Good signature from "Release Engineering <infrastructure@rockylinux.org>" [unknown]
    default: gpg: WARNING: This key is not certified with a trusted signature!
    default: gpg:          There is no indication that the signature belongs to the owner.
    default: Primary key fingerprint: 7051 C470 A929 F454 CEBE  37B7 15AF 5DAC 6D74 5A60
    default:
    default: ================================================================================
    default: Verifying sha256sum: /home/rocky/testing/Rocky-8.6-x86_64-minimal.iso ...
    default:
    default: Rocky-8.6-x86_64-minimal.iso: OK
    default:
    default: ================================================================================
    default: Verifying internal ISO md5: /home/rocky/testing/Rocky-8.6-x86_64-minimal.iso ...
    default:
    default:
    default: The media check is complete, the result is: PASS.
    default:
    default: It is OK to use this media.
    default: Press [Esc] to abort check.
    default:
    default: ================================================================================
    default: Running:
    default: 	dnf --verbose repoclosure --repofrompath BaseOS,/media/BaseOS --repo BaseOS --repofrompath Minimal,/media/Minimal --repo Minimal ...
    default:
    default: Loaded plugins: builddep, changelog, config-manager, copr, debug, debuginfo-install, download, generate_completion_cache, groups-manager, needs-restarting, playground, repoclosure, repodiff, repograph, repomanage, reposync
    default: DNF version: 4.7.0
    default: cachedir: /var/cache/dnf
    default: Added BaseOS repo from /media/BaseOS
    default: Added Minimal repo from /media/Minimal
    default: User-Agent: constructed: 'libdnf (Rocky Linux 8.6; generic; Linux.x86_64)'
    default: repo: downloading from remote: BaseOS
    default: BaseOS                                           74 MB/s | 2.6 MB     00:00
    default: BaseOS: using metadata from Sun 15 May 2022 08:59:01 PM UTC.
    default: repo: downloading from remote: Minimal
    default: Minimal                                         128 kB/s | 384  B     00:00
    default: Minimal: using metadata from Sun 15 May 2022 08:59:06 PM UTC.
    default: Completion plugin: Generating completion cache...
    default:
    default: ================================================================================
    default: Running:
    default: 	python3 /home/rocky/testing/scripts/potential_conflict.py --repofrompath BaseOS,/media/BaseOS --repoid BaseOS --repofrompath Minimal,/media/Minimal --repoid Minimal ...
    default:
    default: Added BaseOS repo from /media/BaseOS
    default: Added Minimal repo from /media/Minimal
    default: Getting complete filelist for:
    default: file:///media/BaseOS
    default: file:///media/Minimal
    default: 185139 files found.
    default:
    default: Looking for duplicated filenames:
    default: 17229 duplicates found.
    default:
    default: Doing more advanced checks to see if these are real conflicts:
    default:   5% complete (   861/ 17229, 11429/sec),    0 found - eta 0:00:01
    default:  10% complete (  1722/ 17229,  5409/sec),    0 found - eta 0:00:02
    default:  15% complete (  2583/ 17229, 42762/sec),    0 found - eta 0:00:01
    default:  20% complete (  3444/ 17229, 70417/sec),    0 found - eta 0:00:01
    default:  25% complete (  4305/ 17229,  3308/sec),    0 found - eta 0:00:01
    default:  30% complete (  5166/ 17229, 342140/sec),    0 found - eta 0:00:01
    default:  35% complete (  6027/ 17229, 2050707/sec),    0 found - eta 0:00:00
    default:  40% complete (  6888/ 17229, 148674/sec),    0 found - eta 0:00:00
    default:  45% complete (  7749/ 17229, 264312/sec),    0 found - eta 0:00:00
    default:  50% complete (  8610/ 17229, 103647/sec),    0 found - eta 0:00:00
    default:  55% complete (  9471/ 17229, 2018611/sec),    0 found - eta 0:00:00
    default:  60% complete ( 10332/ 17229, 2220969/sec),    0 found - eta 0:00:00
    default:  65% complete ( 11193/ 17229, 2129301/sec),    0 found - eta 0:00:00
    default:  70% complete ( 12054/ 17229, 2236096/sec),    0 found - eta 0:00:00
    default:  75% complete ( 12915/ 17229, 2248627/sec),    0 found - eta 0:00:00
    default:  80% complete ( 13776/ 17229, 2121795/sec),    0 found - eta 0:00:00
    default:  85% complete ( 14637/ 17229, 41822/sec),    0 found - eta 0:00:00
    default:  90% complete ( 15498/ 17229, 17042/sec),    0 found - eta 0:00:00
    default:  95% complete ( 16359/ 17229, 2154711/sec),    0 found - eta 0:00:00
    default: 100% complete ( 17220/ 17229, 2035679/sec),    0 found - eta 0:00:00
    default:
    default: 0 file conflicts found.
    default: 0 package conflicts found.
    default:
    default: == Package conflicts ==
    default:
    default: == File conflicts, listed by conflicting packages ==
==> default: Running provisioner: Rocky 8.6 x86_64 dvd1 ISO (shell)...
    default: Running: script: Rocky 8.6 x86_64 dvd1 ISO
    default:
    default: ================================================================================
    default: Derived URLs...
    default:
    default: iso_url:              http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-dvd1.iso
    default: iso_checksum_url:     http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM
    default: iso_checksum_sig_url: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM.sig
    default: iso_key_url:          https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-rockyofficial
    default:
    default: ================================================================================
    default: Verifying: http://dl.rockylinux.org/pub/rocky/8/isos exists...
    default:
    default:
    default: ================================================================================
    default: Verifying: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-dvd1.iso exists...
    default:
    default:
    default: ================================================================================
    default: Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM ...
    default:
    default: *   Trying 146.75.94.132...
    default: * TCP_NODELAY set
    default: * Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
    default: > GET /pub/rocky/8/isos/x86_64/CHECKSUM?v=ba36bcab87954bf544db5b18169c117b HTTP/1.1
    default: > Host: dl.rockylinux.org
    default: > User-Agent: curl/7.61.1
    default: > Accept: */*
    default: >
    default: < HTTP/1.1 200 OK
    default: < Content-Type: application/octet-stream
    default: < Server: nginx
    default: < Last-Modified: Sun, 15 May 2022 22:25:57 GMT
    default: < ETag: "62817df5-1c2"
    default: < Accept-Ranges: bytes
    default: < Via: 1.1 varnish, 1.1 varnish
    default: < Content-Length: 450
    default: < Date: Sun, 22 May 2022 19:10:28 GMT
    default: < Connection: keep-alive
    default: < X-Served-By: cache-mdw17368-MDW, cache-bur-kbur8200055-BUR
    default: < X-Cache: MISS, MISS
    default: < X-Cache-Hits: 0, 0
    default: < X-Timer: S1653246628.241977,VS0,VE76
    default: <
    default: { [450 bytes data]
    default: * Connection #0 to host dl.rockylinux.org left intact
    default:
    default: ================================================================================
    default: Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM.sig ...
    default:
    default: *   Trying 146.75.94.132...
    default: * TCP_NODELAY set
    default: * Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
    default: > GET /pub/rocky/8/isos/x86_64/CHECKSUM.sig?v=ba36bcab87954bf544db5b18169c117b HTTP/1.1
    default: > Host: dl.rockylinux.org
    default: > User-Agent: curl/7.61.1
    default: > Accept: */*
    default: >
    default: < HTTP/1.1 200 OK
    default: < Content-Type: application/octet-stream
    default: < Server: nginx
    default: < Last-Modified: Mon, 16 May 2022 02:41:30 GMT
    default: < ETag: "6281b9da-236"
    default: < Accept-Ranges: bytes
    default: < Via: 1.1 varnish, 1.1 varnish
    default: < Content-Length: 566
    default: < Date: Sun, 22 May 2022 19:10:28 GMT
    default: < Connection: keep-alive
    default: < X-Served-By: cache-mdw17360-MDW, cache-bur-kbur8200024-BUR
    default: < X-Cache: MISS, MISS
    default: < X-Cache-Hits: 0, 0
    default: < X-Timer: S1653246628.384982,VS0,VE74
    default: <
    default: { [566 bytes data]
    default: * Connection #0 to host dl.rockylinux.org left intact
    default:
    default: ================================================================================
    default: Downloading: Rocky-8.6-x86_64-dvd1.iso ...
    default:
    default: *   Trying 146.75.94.132...
    default: * TCP_NODELAY set
    default: * Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
    default: > GET /pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-dvd1.iso?v=ba36bcab87954bf544db5b18169c117b HTTP/1.1
    default: > Host: dl.rockylinux.org
    default: > User-Agent: curl/7.61.1
    default: > Accept: */*
    default: >
    default: < HTTP/1.1 200 OK
    default: < Content-Type: application/octet-stream
    default: < Server: nginx
    default: < Last-Modified: Sun, 15 May 2022 22:21:05 GMT
    default: < ETag: "62817cd1-29c600000"
    default: < Via: 1.1 varnish, 1.1 varnish
    default: < Cache-Control: max-age=11059200, public, stale-while-revalidate=86400, stale-if-error=259200
    default: < Accept-Ranges: bytes
    default: < Date: Sun, 22 May 2022 19:10:28 GMT
    default: < Age: 0
    default: < Connection: keep-alive
    default: < X-Served-By: cache-mdw17378-MDW, cache-bur-kbur8200121-BUR
    default: < X-Cache: MISS, MISS
    default: < X-Cache-Hits: 0, 0
    default: < X-Timer: S1653246629.520228,VS0,VE80
    default: < Content-Length: 11213471744
    default: <
    default: { [15884 bytes data]
    default: * Connection #0 to host dl.rockylinux.org left intact
    default:
    default: ================================================================================
    default: Importing: RPM-GPG-KEY-rockyofficial ...
    default:
    default: gpg: key 15AF5DAC6D745A60: "Release Engineering <infrastructure@rockylinux.org>" not changed
    default: gpg: Total number processed: 1
    default: gpg:              unchanged: 1
    default:
    default: ================================================================================
    default: Verifying gpg signature: /home/rocky/testing/CHECKSUM.sig ...
    default:
    default: gpg: assuming signed data in '/home/rocky/testing/CHECKSUM'
    default: gpg: Signature made Mon 16 May 2022 02:41:30 AM UTC
    default: gpg:                using RSA key 7051C470A929F454CEBE37B715AF5DAC6D745A60
    default: gpg: Good signature from "Release Engineering <infrastructure@rockylinux.org>" [unknown]
    default: gpg: WARNING: This key is not certified with a trusted signature!
    default: gpg:          There is no indication that the signature belongs to the owner.
    default: Primary key fingerprint: 7051 C470 A929 F454 CEBE  37B7 15AF 5DAC 6D74 5A60
    default:
    default: ================================================================================
    default: Verifying sha256sum: /home/rocky/testing/Rocky-8.6-x86_64-dvd1.iso ...
    default:
    default: Rocky-8.6-x86_64-dvd1.iso: OK
    default:
    default: ================================================================================
    default: Verifying internal ISO md5: /home/rocky/testing/Rocky-8.6-x86_64-dvd1.iso ...
    default:
    default:
    default: The media check is complete, the result is: PASS.
    default:
    default: It is OK to use this media.
    default: Press [Esc] to abort check.
    default:
    default: ================================================================================
    default: Running:
    default: 	dnf --verbose repoclosure --repofrompath AppStream,/media/AppStream --repo AppStream --repofrompath BaseOS,/media/BaseOS --repo BaseOS ...
    default:
    default: Loaded plugins: builddep, changelog, config-manager, copr, debug, debuginfo-install, download, generate_completion_cache, groups-manager, needs-restarting, playground, repoclosure, repodiff, repograph, repomanage, reposync
    default: DNF version: 4.7.0
    default: cachedir: /var/cache/dnf
    default: Added AppStream repo from /media/AppStream
    default: Added BaseOS repo from /media/BaseOS
    default: User-Agent: constructed: 'libdnf (Rocky Linux 8.6; generic; Linux.x86_64)'
    default: repo: downloading from remote: AppStream
    default: AppStream                                        50 MB/s | 7.8 MB     00:00
    default: AppStream: using metadata from Sun 15 May 2022 09:01:50 PM UTC.
    default: repo: using cache for: BaseOS
    default: BaseOS: using metadata from Sun 15 May 2022 08:59:01 PM UTC.
    default: Last metadata expiration check: 0:00:01 ago on Sun 22 May 2022 07:39:31 PM UTC.
    default: Completion plugin: Generating completion cache...
    default:
    default: ================================================================================
    default: Running:
    default: 	python3 /home/rocky/testing/scripts/potential_conflict.py --repofrompath AppStream,/media/AppStream --repoid AppStream --repofrompath BaseOS,/media/BaseOS --repoid BaseOS ...
    default:
    default: Added AppStream repo from /media/AppStream
    default: Added BaseOS repo from /media/BaseOS
    default: Getting complete filelist for:
    default: file:///media/AppStream
    default: file:///media/BaseOS
    default: 867725 files found.
    default:
    default: Looking for duplicated filenames:
    default: 107287 duplicates found.
    default:
    default: Doing more advanced checks to see if these are real conflicts:
    default:   5% complete (  5364/107287, 11694/sec),    0 found - eta 0:00:08
    default:  10% complete ( 10728/107287, 2261130/sec),    0 found - eta 0:00:04
    default:  15% complete ( 16092/107287, 2292698/sec),    0 found - eta 0:00:02
    default:  20% complete ( 21456/107287, 12240/sec),    3 found - eta 0:00:03
    default:  25% complete ( 26820/107287, 45579/sec),    3 found - eta 0:00:03
    default:  30% complete ( 32184/107287,  3652/sec),    3 found - eta 0:00:05
    default:  35% complete ( 37548/107287, 49061/sec),    3 found - eta 0:00:04
    default:  40% complete ( 42912/107287, 2178795/sec),    3 found - eta 0:00:03
    default:  45% complete ( 48276/107287, 2271632/sec),    3 found - eta 0:00:03
    default:  50% complete ( 53640/107287, 291654/sec),    3 found - eta 0:00:02
    default:  55% complete ( 59004/107287, 1114823/sec),    3 found - eta 0:00:02
    default:  60% complete ( 64368/107287, 69486/sec),    4 found - eta 0:00:01
    default:  65% complete ( 69732/107287, 319418/sec),    4 found - eta 0:00:01
    default:  70% complete ( 75096/107287, 185158/sec),    4 found - eta 0:00:01
    default:  75% complete ( 80460/107287, 33596/sec),    4 found - eta 0:00:00
    default:  80% complete ( 85824/107287, 135688/sec),    4 found - eta 0:00:00
    default:  85% complete ( 91188/107287, 81493/sec),    4 found - eta 0:00:00
    default:  90% complete ( 96552/107287, 13137/sec),    4 found - eta 0:00:00
    default:  95% complete (101916/107287, 493350/sec),    4 found - eta 0:00:00
    default: 100% complete (107280/107287, 203674/sec),    4 found - eta 0:00:00
    default:
    default: 4 file conflicts found.
    default: 13 package conflicts found.
    default:
    default: == Package conflicts ==
    default: mariadb-test-3:10.3.32-2.module+el8.5.0+777+18007c86.x86_64
    default: mysql-test-8.0.26-1.module+el8.4.0+652+6de068a7.x86_64
    default:
    default: mariadb-3:10.3.32-2.module+el8.5.0+777+18007c86.x86_64
    default: mysql-8.0.26-1.module+el8.4.0+652+6de068a7.x86_64
    default:
    default: mariadb-devel-3:10.3.32-2.module+el8.5.0+777+18007c86.x86_64
    default: mysql-devel-8.0.26-1.module+el8.4.0+652+6de068a7.x86_64
    default:
    default: mariadb-server-3:10.3.32-2.module+el8.5.0+777+18007c86.x86_64
    default: mysql-server-8.0.26-1.module+el8.4.0+652+6de068a7.x86_64
    default:
    default: libcmpiCppImpl0-2.0.3-15.el8.i686
    default: tog-pegasus-libs-2:2.14.1-46.el8.i686
    default:
    default: libev-libevent-devel-4.24-6.el8.i686
    default: libev-libevent-devel-4.24-6.el8.x86_64
    default: libevent-devel-2.1.8-5.el8.i686
    default: libevent-devel-2.1.8-5.el8.x86_64
    default:
    default: mariadb-server-utils-3:10.3.32-2.module+el8.5.0+777+18007c86.x86_64
    default: mysql-server-8.0.26-1.module+el8.4.0+652+6de068a7.x86_64
    default:
    default: libcmpiCppImpl0-2.0.3-15.el8.x86_64
    default: tog-pegasus-libs-2:2.14.1-46.el8.x86_64
    default:
    default: mariadb-connector-c-devel-3.1.11-2.el8_3.i686
    default: mariadb-connector-c-devel-3.1.11-2.el8_3.x86_64
    default: mariadb-devel-3:10.3.32-2.module+el8.5.0+777+18007c86.x86_64
    default: mysql-devel-8.0.26-1.module+el8.4.0+652+6de068a7.x86_64
    default:
    default: bind-32:9.11.36-3.el8.x86_64
    default: bind9.16-32:9.16.23-0.7.el8.x86_64
    default:
    default: python3-mod_wsgi-4.6.4-4.el8.x86_64
    default: python38-mod_wsgi-4.6.8-3.module+el8.4.0+570+c2eaf144.x86_64
    default: python39-mod_wsgi-4.7.1-4.module+el8.4.0+574+843c4898.x86_64
    default:
    default: bind-utils-32:9.11.36-3.el8.x86_64
    default: bind9.16-utils-32:9.16.23-0.7.el8.x86_64
    default:
    default: mariadb-connector-c-devel-3.1.11-2.el8_3.i686
    default: mariadb-connector-c-devel-3.1.11-2.el8_3.x86_64
    default: mysql-devel-8.0.26-1.module+el8.4.0+652+6de068a7.x86_64
    default:
    default:
    default: == File conflicts, listed by conflicting packages ==
    default: composer-cli-28.14.68-1.el8.x86_64
    default: weldr-client-35.5-1.el8.x86_64
    default:   /etc/bash_completion.d/composer-cli
    default:   /usr/bin/composer-cli
    default:   /usr/share/man/man1/composer-cli.1.gz
    default:
    default: mariadb-server-3:10.3.32-2.module+el8.5.0+777+18007c86.x86_64
    default: mysql-test-8.0.26-1.module+el8.4.0+652+6de068a7.x86_64
    default:   /usr/bin/mysqld_safe
    default:
==> default: Running provisioner: End Timestamp (shell)...
    default: Running: script: End Timestamp
    default: Finished QA:Testcase-Mediacheck on Sun May 22 19:39:40 UTC 2022
```
