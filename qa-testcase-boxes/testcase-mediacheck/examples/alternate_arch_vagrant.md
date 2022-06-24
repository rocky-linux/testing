# Alternate Architecture Vagrant Example

In this case the Vagrant box is/was already provisioned for standard arch testing and was not destroyed. The box can be reused for alternate arch testing by placing a modified `vagrant-settings.yml` file.

## create / modify vagrant-setting.yml

```
[rocky@localhost testing]$ cat vagrant-settings.yaml
---
box_image: "rockylinux/8"
arch: "aarch64"
```


## start the Vagrant box

```
[rocky@localhost testing]$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Clearing any previously set forwarded ports...
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
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
==> default: Mounting shared folders...
    default: /home/rocky => /home/rocky/testing/qa-testcase-boxes/testcase-mediacheck
==> default: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> default: flag to force provisioning. Provisioners marked to run always will still run.
```


## re-provision the Vagrant box to run the test

```
[rocky@localhost testing]$ vagrant provision
==> default: Running provisioner: Start Timestamp (shell)...
    default: Running: script: Start Timestamp
    default: Starting QA:Testcase-Mediacheck on Sun May 22 20:45:22 UTC 2022
==> default: Running provisioner: Install requirements (shell)...
    default: Running: script: Install requirements
    default: Last metadata expiration check: 1:15:57 ago on Sun 22 May 2022 07:29:28 PM UTC.
    default: Dependencies resolved.
    default: Nothing to do.
    default: Complete!
    default: Last metadata expiration check: 1:15:57 ago on Sun 22 May 2022 07:29:28 PM UTC.
    default: Package coreutils-8.30-12.el8.x86_64 is already installed.
    default: Package curl-7.61.1-22.el8.x86_64 is already installed.
    default: Package dnf-4.7.0-8.el8.noarch is already installed.
    default: Package isomd5sum-1:1.2.3-3.el8.x86_64 is already installed.
    default: Package python36-3.6.8-38.module+el8.5.0+671+195e4563.x86_64 is already installed.
    default: Package rpm-4.14.3-23.el8.x86_64 is already installed.
    default: Package util-linux-2.32.1-35.el8.x86_64 is already installed.
    default: Dependencies resolved.
    default: Nothing to do.
    default: Complete!
==> default: Running provisioner: Prepare testing directories (shell)...
    default: Running: script: Prepare testing directories
==> default: Running provisioner: Rocky 8.6 aarch64 boot ISO (shell)...
    default: Running: script: Rocky 8.6 aarch64 boot ISO
    default:
    default: ================================================================================
    default: Derived URLs...
    default:
    default: iso_url:              http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/Rocky-8.6-aarch64-boot.iso
    default: iso_checksum_url:     http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/CHECKSUM
    default: iso_checksum_sig_url: http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/CHECKSUM.sig
    default: iso_key_url:          https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-rockyofficial
    default:
    default: ================================================================================
    default: Verifying: http://dl.rockylinux.org/pub/rocky/8/isos exists...
    default:
    default:
    default: ================================================================================
    default: Verifying: http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/Rocky-8.6-aarch64-boot.iso exists...
    default:
    default:
    default: ================================================================================
    default: Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/CHECKSUM ...
    default:
    default: *   Trying 146.75.94.132...
    default: * TCP_NODELAY set
    default: * Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
    default: > GET /pub/rocky/8/isos/aarch64/CHECKSUM?v=2d5f8427d657041086564939488a0682 HTTP/1.1
    default: > Host: dl.rockylinux.org
    default: > User-Agent: curl/7.61.1
    default: > Accept: */*
    default: >
    default: < HTTP/1.1 200 OK
    default: < Content-Type: application/octet-stream
    default: < Server: nginx
    default: < Last-Modified: Sun, 15 May 2022 22:31:58 GMT
    default: < ETag: "62817f5e-1c7"
    default: < Accept-Ranges: bytes
    default: < Via: 1.1 varnish, 1.1 varnish
    default: < Content-Length: 455
    default: < Date: Sun, 22 May 2022 20:45:27 GMT
    default: < Connection: keep-alive
    default: < X-Served-By: cache-mdw17330-MDW, cache-bur-kbur8200145-BUR
    default: < X-Cache: MISS, MISS
    default: < X-Cache-Hits: 0, 0
    default: < X-Timer: S1653252327.989329,VS0,VE79
    default: <
    default: { [455 bytes data]
    default: * Connection #0 to host dl.rockylinux.org left intact
    default:
    default: ================================================================================
    default: Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/CHECKSUM.sig ...
    default:
    default: *   Trying 146.75.94.132...
    default: * TCP_NODELAY set
    default: * Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
    default: > GET /pub/rocky/8/isos/aarch64/CHECKSUM.sig?v=2d5f8427d657041086564939488a0682 HTTP/1.1
    default: > Host: dl.rockylinux.org
    default: > User-Agent: curl/7.61.1
    default: > Accept: */*
    default: >
    default: < HTTP/1.1 200 OK
    default: < Content-Type: application/octet-stream
    default: < Server: nginx
    default: < Last-Modified: Mon, 16 May 2022 02:41:36 GMT
    default: < ETag: "6281b9e0-236"
    default: < Accept-Ranges: bytes
    default: < Via: 1.1 varnish, 1.1 varnish
    default: < Content-Length: 566
    default: < Date: Sun, 22 May 2022 20:45:27 GMT
    default: < Connection: keep-alive
    default: < X-Served-By: cache-mdw17335-MDW, cache-bur-kbur8200092-BUR
    default: < X-Cache: MISS, MISS
    default: < X-Cache-Hits: 0, 0
    default: < X-Timer: S1653252327.131733,VS0,VE78
    default: <
    default: { [566 bytes data]
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
    default: Verifying gpg signature: /home/rocky/CHECKSUM.sig ...
    default:
    default: gpg: assuming signed data in '/home/rocky/CHECKSUM'
    default: gpg: Signature made Mon 16 May 2022 02:41:36 AM UTC
    default: gpg:                using RSA key 7051C470A929F454CEBE37B715AF5DAC6D745A60
    default: gpg: Good signature from "Release Engineering <infrastructure@rockylinux.org>" [unknown]
    default: gpg: WARNING: This key is not certified with a trusted signature!
    default: gpg:          There is no indication that the signature belongs to the owner.
    default: Primary key fingerprint: 7051 C470 A929 F454 CEBE  37B7 15AF 5DAC 6D74 5A60
    default:
    default: ================================================================================
    default: Verifying sha256sum: /home/rocky/Rocky-8.6-aarch64-boot.iso ...
    default:
    default: Rocky-8.6-aarch64-boot.iso: OK
    default:
    default: ================================================================================
    default: Verifying internal ISO md5: /home/rocky/Rocky-8.6-aarch64-boot.iso ...
    default:
    default:
    default: The media check is complete, the result is: PASS.
    default:
    default: It is OK to use this media.
    default: Press [Esc] to abort check.
==> default: Running provisioner: Rocky 8.6 aarch64 minimal ISO (shell)...
    default: Running: script: Rocky 8.6 aarch64 minimal ISO
    default:
    default: ================================================================================
    default: Derived URLs...
    default:
    default: iso_url:              http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/Rocky-8.6-aarch64-minimal.iso
    default: iso_checksum_url:     http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/CHECKSUM
    default: iso_checksum_sig_url: http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/CHECKSUM.sig
    default: iso_key_url:          https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-rockyofficial
    default:
    default: ================================================================================
    default: Verifying: http://dl.rockylinux.org/pub/rocky/8/isos exists...
    default:
    default:
    default: ================================================================================
    default: Verifying: http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/Rocky-8.6-aarch64-minimal.iso exists...
    default:
    default:
    default: ================================================================================
    default: Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/CHECKSUM ...
    default:
    default: *   Trying 146.75.94.132...
    default: * TCP_NODELAY set
    default: * Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
    default: > GET /pub/rocky/8/isos/aarch64/CHECKSUM?v=591fde74c65dddb245b973daa641ba50 HTTP/1.1
    default: > Host: dl.rockylinux.org
    default: > User-Agent: curl/7.61.1
    default: > Accept: */*
    default: >
    default: < HTTP/1.1 200 OK
    default: < Content-Type: application/octet-stream
    default: < Server: nginx
    default: < Last-Modified: Sun, 15 May 2022 22:31:58 GMT
    default: < ETag: "62817f5e-1c7"
    default: < Accept-Ranges: bytes
    default: < Via: 1.1 varnish, 1.1 varnish
    default: < Content-Length: 455
    default: < Date: Sun, 22 May 2022 20:45:32 GMT
    default: < Connection: keep-alive
    default: < X-Served-By: cache-mdw17364-MDW, cache-bur-kbur8200088-BUR
    default: < X-Cache: MISS, MISS
    default: < X-Cache-Hits: 0, 0
    default: < X-Timer: S1653252333.812829,VS0,VE76
    default: <
    default: { [455 bytes data]
    default: * Connection #0 to host dl.rockylinux.org left intact
    default:
    default: ================================================================================
    default: Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/CHECKSUM.sig ...
    default:
    default: *   Trying 146.75.94.132...
    default: * TCP_NODELAY set
    default: * Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
    default: > GET /pub/rocky/8/isos/aarch64/CHECKSUM.sig?v=591fde74c65dddb245b973daa641ba50 HTTP/1.1
    default: > Host: dl.rockylinux.org
    default: > User-Agent: curl/7.61.1
    default: > Accept: */*
    default: >
    default: < HTTP/1.1 200 OK
    default: < Content-Type: application/octet-stream
    default: < Server: nginx
    default: < Last-Modified: Mon, 16 May 2022 02:41:36 GMT
    default: < ETag: "6281b9e0-236"
    default: < Accept-Ranges: bytes
    default: < Via: 1.1 varnish, 1.1 varnish
    default: < Content-Length: 566
    default: < Date: Sun, 22 May 2022 20:45:33 GMT
    default: < Connection: keep-alive
    default: < X-Served-By: cache-mdw17367-MDW, cache-bur-kbur8200138-BUR
    default: < X-Cache: MISS, MISS
    default: < X-Cache-Hits: 0, 0
    default: < X-Timer: S1653252333.946655,VS0,VE82
    default: <
    default: { [566 bytes data]
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
    default: Verifying gpg signature: /home/rocky/CHECKSUM.sig ...
    default:
    default: gpg: assuming signed data in '/home/rocky/CHECKSUM'
    default: gpg: Signature made Mon 16 May 2022 02:41:36 AM UTC
    default: gpg:                using RSA key 7051C470A929F454CEBE37B715AF5DAC6D745A60
    default: gpg: Good signature from "Release Engineering <infrastructure@rockylinux.org>" [unknown]
    default: gpg: WARNING: This key is not certified with a trusted signature!
    default: gpg:          There is no indication that the signature belongs to the owner.
    default: Primary key fingerprint: 7051 C470 A929 F454 CEBE  37B7 15AF 5DAC 6D74 5A60
    default:
    default: ================================================================================
    default: Verifying sha256sum: /home/rocky/Rocky-8.6-aarch64-minimal.iso ...
    default:
    default: Rocky-8.6-aarch64-minimal.iso: OK
    default:
    default: ================================================================================
    default: Verifying internal ISO md5: /home/rocky/Rocky-8.6-aarch64-minimal.iso ...
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
    default: repo: using cache for: BaseOS
    default: BaseOS: using metadata from Sun 15 May 2022 08:59:01 PM UTC.
    default: repo: using cache for: Minimal
    default: Minimal: using metadata from Sun 15 May 2022 08:59:06 PM UTC.
    default: Last metadata expiration check: 1:35:23 ago on Sun 22 May 2022 07:10:25 PM UTC.
    default:
    default: ================================================================================
    default: Running:
    default: 	python3 /home/rocky/scripts/potential_conflict.py --repofrompath BaseOS,/media/BaseOS --repoid BaseOS --repofrompath Minimal,/media/Minimal --repoid Minimal ...
    default:
    default: Added BaseOS repo from /media/BaseOS
    default: Added Minimal repo from /media/Minimal
    default: Getting complete filelist for:
    default: file:///media/BaseOS
    default: file:///media/Minimal
    default: 168952 files found.
    default:
    default: Looking for duplicated filenames:
    default: 525 duplicates found.
    default:
    default: Doing more advanced checks to see if these are real conflicts:
    default:  35% complete (   182/   525,   350/sec),    0 found - eta 0:00:00
    default:  40% complete (   208/   525,  1765/sec),    0 found - eta 0:00:00
    default:  45% complete (   234/   525, 583165/sec),    0 found - eta 0:00:00
    default:  50% complete (   260/   525, 746930/sec),    0 found - eta 0:00:00
    default:  54% complete (   286/   525, 762600/sec),    0 found - eta 0:00:00
    default:  84% complete (   442/   525,   119/sec),    0 found - eta 0:00:00
    default:  89% complete (   468/   525,   118/sec),    0 found - eta 0:00:00
    default:  94% complete (   494/   525,   805/sec),    0 found - eta 0:00:00
    default:  99% complete (   520/   525,   475/sec),    0 found - eta 0:00:00
    default:
    default: 0 file conflicts found.
    default: 0 package conflicts found.
    default:
    default: == Package conflicts ==
    default:
    default: == File conflicts, listed by conflicting packages ==
==> default: Running provisioner: Rocky 8.6 aarch64 dvd1 ISO (shell)...
    default: Running: script: Rocky 8.6 aarch64 dvd1 ISO
    default:
    default: ================================================================================
    default: Derived URLs...
    default:
    default: iso_url:              http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/Rocky-8.6-aarch64-dvd1.iso
    default: iso_checksum_url:     http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/CHECKSUM
    default: iso_checksum_sig_url: http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/CHECKSUM.sig
    default: iso_key_url:          https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-rockyofficial
    default:
    default: ================================================================================
    default: Verifying: http://dl.rockylinux.org/pub/rocky/8/isos exists...
    default:
    default:
    default: ================================================================================
    default: Verifying: http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/Rocky-8.6-aarch64-dvd1.iso exists...
    default:
    default:
    default: ================================================================================
    default: Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/CHECKSUM ...
    default:
    default: *   Trying 146.75.94.132...
    default: * TCP_NODELAY set
    default: * Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
    default: > GET /pub/rocky/8/isos/aarch64/CHECKSUM?v=9ca868fa4cc38e6f7487d00fb6a4074b HTTP/1.1
    default: > Host: dl.rockylinux.org
    default: > User-Agent: curl/7.61.1
    default: > Accept: */*
    default: >
    default: < HTTP/1.1 200 OK
    default: < Content-Type: application/octet-stream
    default: < Server: nginx
    default: < Last-Modified: Sun, 15 May 2022 22:31:58 GMT
    default: < ETag: "62817f5e-1c7"
    default: < Accept-Ranges: bytes
    default: < Via: 1.1 varnish, 1.1 varnish
    default: < Content-Length: 455
    default: < Date: Sun, 22 May 2022 20:45:50 GMT
    default: < Connection: keep-alive
    default: < X-Served-By: cache-mdw17374-MDW, cache-bur-kbur8200092-BUR
    default: < X-Cache: MISS, MISS
    default: < X-Cache-Hits: 0, 0
    default: < X-Timer: S1653252351.915547,VS0,VE75
    default: <
    default: { [455 bytes data]
    default: * Connection #0 to host dl.rockylinux.org left intact
    default:
    default: ================================================================================
    default: Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/aarch64/CHECKSUM.sig ...
    default:
    default: *   Trying 146.75.94.132...
    default: * TCP_NODELAY set
    default: * Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
    default: > GET /pub/rocky/8/isos/aarch64/CHECKSUM.sig?v=9ca868fa4cc38e6f7487d00fb6a4074b HTTP/1.1
    default: > Host: dl.rockylinux.org
    default: > User-Agent: curl/7.61.1
    default: > Accept: */*
    default: >
    default: < HTTP/1.1 200 OK
    default: < Content-Type: application/octet-stream
    default: < Server: nginx
    default: < Last-Modified: Mon, 16 May 2022 02:41:36 GMT
    default: < ETag: "6281b9e0-236"
    default: < Accept-Ranges: bytes
    default: < Via: 1.1 varnish, 1.1 varnish
    default: < Content-Length: 566
    default: < Date: Sun, 22 May 2022 20:45:51 GMT
    default: < Connection: keep-alive
    default: < X-Served-By: cache-mdw17351-MDW, cache-bur-kbur8200071-BUR
    default: < X-Cache: MISS, MISS
    default: < X-Cache-Hits: 0, 0
    default: < X-Timer: S1653252351.044222,VS0,VE73
    default: <
    default: { [566 bytes data]
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
    default: Verifying gpg signature: /home/rocky/CHECKSUM.sig ...
    default:
    default: gpg: assuming signed data in '/home/rocky/CHECKSUM'
    default: gpg: Signature made Mon 16 May 2022 02:41:36 AM UTC
    default: gpg:                using RSA key 7051C470A929F454CEBE37B715AF5DAC6D745A60
    default: gpg: Good signature from "Release Engineering <infrastructure@rockylinux.org>" [unknown]
    default: gpg: WARNING: This key is not certified with a trusted signature!
    default: gpg:          There is no indication that the signature belongs to the owner.
    default: Primary key fingerprint: 7051 C470 A929 F454 CEBE  37B7 15AF 5DAC 6D74 5A60
    default:
    default: ================================================================================
    default: Verifying sha256sum: /home/rocky/Rocky-8.6-aarch64-dvd1.iso ...
    default:
    default: Rocky-8.6-aarch64-dvd1.iso: OK
    default:
    default: ================================================================================
    default: Verifying internal ISO md5: /home/rocky/Rocky-8.6-aarch64-dvd1.iso ...
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
    default: repo: using cache for: AppStream
    default: AppStream: using metadata from Sun 15 May 2022 09:01:50 PM UTC.
    default: repo: using cache for: BaseOS
    default: BaseOS: using metadata from Sun 15 May 2022 08:59:01 PM UTC.
    default: Last metadata expiration check: 1:08:06 ago on Sun 22 May 2022 07:39:31 PM UTC.
    default:
    default: ================================================================================
    default: Running:
    default: 	python3 /home/rocky/scripts/potential_conflict.py --repofrompath AppStream,/media/AppStream --repoid AppStream --repofrompath BaseOS,/media/BaseOS --repoid BaseOS ...
    default:
    default: Modular dependency problems:
    default:
    default:  Problem 1: nothing provides requested module(ant:1.10:8030020210429121623)
    default:  Problem 2: nothing provides requested module(container-tools:rhel8:8060020220510152704)
    default:  Problem 3: nothing provides requested module(freeradius:3.0:8060020220510152642)
    default:  Problem 4: nothing provides requested module(gimp:2.8:8030020210427153901)
    default:  Problem 5: nothing provides requested module(go-toolset:rhel8:8060020220510152643)
    default:  Problem 6: nothing provides requested module(httpd:2.4:8060020220510175152)
    default:  Problem 7: nothing provides requested module(idm:client:8060020220510152717)
    default:  Problem 8: nothing provides requested module(inkscape:0.92.3:8060020220510152652)
    default:  Problem 9: nothing provides requested module(javapackages-runtime:201801:8030020210427015850)
    default:  Problem 10: nothing provides requested module(jmc:rhel8:8050020211109115703)
    default:  Problem 11: nothing provides requested module(llvm-toolset:rhel8:8060020220510152650)
    default:  Problem 12: nothing provides requested module(log4j:2:8060020220513010955)
    default:  Problem 13: nothing provides requested module(mailman:2.1:8050020211202160117)
    default:  Problem 14: nothing provides requested module(mariadb:10.3:8050020220426183223)
    default:  Problem 15: nothing provides requested module(maven:3.5:8060020220510152744)
    default:  Problem 16: nothing provides requested module(mercurial:4.8:8030020210428123809)
    default:  Problem 17: nothing provides requested module(mysql:8.0:8040020210921213001)
    default:  Problem 18: nothing provides requested module(nginx:1.14:8040020210610090123)
    default:  Problem 19: nothing provides requested module(nodejs:10:8030020210426100849)
    default:  Problem 20: nothing provides requested module(perl:5.26:8050020211109115414)
    default:  Problem 21: nothing provides requested module(perl-App-cpanminus:1.7044:8060020220513152155)
    default:  Problem 22: nothing provides requested module(perl-DBD-MySQL:4.046:8060020220513012802)
    default:  Problem 23: nothing provides requested module(perl-DBD-Pg:3.7:8060020220513012759)
    default:  Problem 24: nothing provides requested module(perl-DBD-SQLite:1.58:8060020220513012746)
    default:  Problem 25: nothing provides requested module(perl-DBI:1.641:8060020220513010556)
    default:  Problem 26: nothing provides requested module(perl-FCGI:0.78:8060020220513014001)
    default:  Problem 27: nothing provides requested module(perl-IO-Socket-SSL:2.066:8060020220513050719)
    default:  Problem 28: nothing provides requested module(perl-YAML:1.24:8060020220513063607)
    default:  Problem 29: nothing provides requested module(perl-libwww-perl:6.34:8060020220513153220)
    default:  Problem 30: nothing provides requested module(php:7.2:8040020210530192442)
    default:  Problem 31: nothing provides requested module(postgresql:10:8060020220510152838)
    default:  Problem 32: nothing provides requested module(python27:2.7:8060020220510152758)
    default:  Problem 33: nothing provides requested module(python36:3.6:8050020211109130820)
    default:  Problem 34: nothing provides requested module(python38:3.8:8060020220510152755)
    default:  Problem 35: nothing provides requested module(python39:3.9:8060020220510152857)
    default:  Problem 36: nothing provides requested module(redis:5:8050020211020202418)
    default:  Problem 37: nothing provides requested module(rhn-tools:1.0:8030020210429021554)
    default:  Problem 38: nothing provides requested module(ruby:2.5:8050020220224171137)
    default:  Problem 39: nothing provides requested module(rust-toolset:rhel8:8060020220510152804)
    default:  Problem 40: nothing provides requested module(satellite-5-client:1.0:8030020210428035500)
    default:  Problem 41: nothing provides requested module(scala:2.10:8030020210428133748)
    default:  Problem 42: nothing provides requested module(squid:4:8060020220510152801)
    default:  Problem 43: nothing provides requested module(subversion:1.10:8040020210530192448)
    default:  Problem 44: nothing provides requested module(swig:3.0:8040020210530171044)
    default:  Problem 45: nothing provides requested module(varnish:6:8050020220203164257)
    default:  Problem 46: nothing provides requested module(virt:rhel:8060020220510231111)
    default: Added AppStream repo from /media/AppStream
    default: Added BaseOS repo from /media/BaseOS
    default: Getting complete filelist for:
    default: file:///media/AppStream
    default: file:///media/BaseOS
    default: 576198 files found.
    default:
    default: Looking for duplicated filenames:
    default: 5269 duplicates found.
    default:
    default: Doing more advanced checks to see if these are real conflicts:
    default:   5% complete (   263/  5269,  2291/sec),    0 found - eta 0:00:02
    default:  10% complete (   526/  5269,  2308/sec),    3 found - eta 0:00:02
    default:  15% complete (   789/  5269, 614541/sec),    3 found - eta 0:00:01
    default:  20% complete (  1052/  5269, 727639/sec),    3 found - eta 0:00:00
    default:  25% complete (  1315/  5269, 98844/sec),    3 found - eta 0:00:00
    default:  30% complete (  1578/  5269, 689869/sec),    3 found - eta 0:00:00
    default:  35% complete (  1841/  5269, 24197/sec),    3 found - eta 0:00:00
    default:  40% complete (  2104/  5269, 519106/sec),    3 found - eta 0:00:00
    default:  45% complete (  2367/  5269, 738354/sec),    3 found - eta 0:00:00
    default:  50% complete (  2630/  5269,   234/sec),    3 found - eta 0:00:01
    default:  55% complete (  2893/  5269,  4872/sec),    3 found - eta 0:00:01
    default:  60% complete (  3156/  5269, 287490/sec),    3 found - eta 0:00:00
    default:  65% complete (  3419/  5269, 286222/sec),    3 found - eta 0:00:00
    default:  70% complete (  3682/  5269,  1526/sec),    3 found - eta 0:00:00
    default:  75% complete (  3945/  5269,  9796/sec),    3 found - eta 0:00:00
    default:  80% complete (  4208/  5269, 422968/sec),    3 found - eta 0:00:00
    default:  85% complete (  4471/  5269, 126357/sec),    3 found - eta 0:00:00
    default:  90% complete (  4734/  5269, 686435/sec),    3 found - eta 0:00:00
    default:  95% complete (  4997/  5269, 18157/sec),    3 found - eta 0:00:00
    default: 100% complete (  5260/  5269,   519/sec),    3 found - eta 0:00:00
    default:
    default: 3 file conflicts found.
    default: 4 package conflicts found.
    default:
    default: == Package conflicts ==
    default: libcmpiCppImpl0-2.0.3-15.el8.aarch64
    default: tog-pegasus-libs-2:2.14.1-46.el8.aarch64
    default:
    default: bind-utils-32:9.11.36-3.el8.aarch64
    default: bind9.16-utils-32:9.16.23-0.7.el8.aarch64
    default:
    default: libev-libevent-devel-4.24-6.el8.aarch64
    default: libevent-devel-2.1.8-5.el8.aarch64
    default:
    default: bind-32:9.11.36-3.el8.aarch64
    default: bind9.16-32:9.16.23-0.7.el8.aarch64
    default:
    default:
    default: == File conflicts, listed by conflicting packages ==
    default: composer-cli-28.14.68-1.el8.aarch64
    default: weldr-client-35.5-1.el8.aarch64
    default:   /etc/bash_completion.d/composer-cli
    default:   /usr/bin/composer-cli
    default:   /usr/share/man/man1/composer-cli.1.gz
    default:
==> default: Running provisioner: End Timestamp (shell)...
    default: Running: script: End Timestamp
    default: Finished QA:Testcase-Mediacheck on Sun May 22 20:47:42 UTC 2022
```
