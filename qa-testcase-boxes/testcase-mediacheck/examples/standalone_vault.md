# Standalone System with ISOs from Rocky Linux Vault

## minimal ISO

**_NOTE: This test is with Rocky Linux 8.4 minimal ISO from Vault._**

```
[vagrant@localhost testing]$ ./scripts/test_wrapper.sh minimal x86_64 8.4 http://dl.rockylinux.org/vault/rocky/8.4/isos

================================================================================
Derived URLs...

iso_url:              http://dl.rockylinux.org/vault/rocky/8.4/isos/x86_64/Rocky-8.4-x86_64-minimal.iso
iso_checksum_url:     http://dl.rockylinux.org/vault/rocky/8.4/isos/x86_64/CHECKSUM
iso_checksum_sig_url: http://dl.rockylinux.org/vault/rocky/8.4/isos/x86_64/CHECKSUM.sig
iso_key_url:          https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-rockyofficial

================================================================================
Verifying: http://dl.rockylinux.org/vault/rocky/8.4/isos exists...


================================================================================
Verifying: http://dl.rockylinux.org/vault/rocky/8.4/isos/x86_64/Rocky-8.4-x86_64-minimal.iso exists...


================================================================================
Downloading: http://dl.rockylinux.org/vault/rocky/8.4/isos/x86_64/CHECKSUM ...

*   Trying 146.75.94.132...
* TCP_NODELAY set
* Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
> GET /vault/rocky/8.4/isos/x86_64/CHECKSUM?v=1e17056f479e744d7a00e1174d103324 HTTP/1.1
> Host: dl.rockylinux.org
> User-Agent: curl/7.61.1
> Accept: */*
>
< HTTP/1.1 200 OK
< Content-Type: application/octet-stream
< Server: nginx
< Last-Modified: Sun, 20 Jun 2021 22:45:21 GMT
< ETag: "60cfc501-3a9"
< Accept-Ranges: bytes
< Via: 1.1 varnish, 1.1 varnish
< Content-Length: 937
< Date: Sun, 22 May 2022 20:28:45 GMT
< Connection: keep-alive
< X-Served-By: cache-mdw17333-MDW, cache-bur-kbur8200111-BUR
< X-Cache: MISS, MISS
< X-Cache-Hits: 0, 0
< X-Timer: S1653251325.109018,VS0,VE86
<
{ [937 bytes data]
* Connection #0 to host dl.rockylinux.org left intact

================================================================================
Downloading: http://dl.rockylinux.org/vault/rocky/8.4/isos/x86_64/CHECKSUM.sig ...

*   Trying 146.75.94.132...
* TCP_NODELAY set
* Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
> GET /vault/rocky/8.4/isos/x86_64/CHECKSUM.sig?v=1e17056f479e744d7a00e1174d103324 HTTP/1.1
> Host: dl.rockylinux.org
> User-Agent: curl/7.61.1
> Accept: */*
>
< HTTP/1.1 200 OK
< Content-Type: application/octet-stream
< Server: nginx
< Last-Modified: Sun, 20 Jun 2021 22:49:19 GMT
< ETag: "60cfc5ef-96"
< Accept-Ranges: bytes
< Via: 1.1 varnish, 1.1 varnish
< Content-Length: 150
< Date: Sun, 22 May 2022 20:28:45 GMT
< Connection: keep-alive
< X-Served-By: cache-mdw17360-MDW, cache-bur-kbur8200078-BUR
< X-Cache: MISS, MISS
< X-Cache-Hits: 0, 0
< X-Timer: S1653251325.426206,VS0,VE82
<
{ [150 bytes data]
* Connection #0 to host dl.rockylinux.org left intact

================================================================================
Downloading: Rocky-8.4-x86_64-minimal.iso ...

*   Trying 146.75.94.132...
* TCP_NODELAY set
* Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
> GET /vault/rocky/8.4/isos/x86_64/Rocky-8.4-x86_64-minimal.iso?v=1e17056f479e744d7a00e1174d103324 HTTP/1.1
> Host: dl.rockylinux.org
> User-Agent: curl/7.61.1
> Accept: */*
>
< HTTP/1.1 200 OK
< Content-Type: application/octet-stream
< Server: nginx
< Last-Modified: Sun, 20 Jun 2021 16:16:53 GMT
< ETag: "60cf69f5-76100000"
< Via: 1.1 varnish, 1.1 varnish
< Cache-Control: max-age=11059200, public, stale-while-revalidate=86400, stale-if-error=259200
< Accept-Ranges: bytes
< Date: Sun, 22 May 2022 20:28:45 GMT
< Age: 0
< Connection: keep-alive
< X-Served-By: cache-mdw17366-MDW, cache-bur-kbur8200105-BUR
< X-Cache: MISS, MISS
< X-Cache-Hits: 0, 0
< X-Timer: S1653251326.568900,VS0,VE94
< Content-Length: 1980760064
<
{ [2390 bytes data]
* Connection #0 to host dl.rockylinux.org left intact

================================================================================
Importing: RPM-GPG-KEY-rockyofficial ...

gpg: key 15AF5DAC6D745A60: "Release Engineering <infrastructure@rockylinux.org>" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1

================================================================================
Verifying gpg signature: /home/rocky/testing/CHECKSUM.sig ...

gpg: assuming signed data in '/home/rocky/testing/CHECKSUM'
gpg: Signature made Sun 20 Jun 2021 10:48:06 PM UTC
gpg:                using EDDSA key BFC3D8F20D15F4FD46281D7FAA650F52D6C094FA
gpg:                issuer "infrastructure@rockylinux.org"
gpg: Can't check signature: No public key

================================================================================
Verifying sha256sum: /home/rocky/testing/Rocky-8.4-x86_64-minimal.iso ...

Rocky-8.4-x86_64-minimal.iso: OK

================================================================================
Verifying internal ISO md5: /home/rocky/testing/Rocky-8.4-x86_64-minimal.iso ...


The media check is complete, the result is: PASS.

It is OK to use this media.
Press [Esc] to abort check.

================================================================================
Running:
	dnf --verbose repoclosure --repofrompath BaseOS,/media/BaseOS --repo BaseOS --repofrompath Minimal,/media/Minimal --repo Minimal ...

Loaded plugins: builddep, changelog, config-manager, copr, debug, debuginfo-install, download, generate_completion_cache, groups-manager, needs-restarting, playground, repoclosure, repodiff, repograph, repomanage, reposync
DNF version: 4.7.0
cachedir: /var/tmp/dnf-vagrant-vt5qg_qr
Added BaseOS repo from /media/BaseOS
Added Minimal repo from /media/Minimal
User-Agent: constructed: 'libdnf (Rocky Linux 8.6; generic; Linux.x86_64)'
repo: using cache for: BaseOS
BaseOS: using metadata from Sun 15 May 2022 08:59:01 PM UTC.
repo: using cache for: Minimal
Minimal: using metadata from Sun 15 May 2022 08:59:06 PM UTC.
Last metadata expiration check: 0:09:54 ago on Sun 22 May 2022 08:24:18 PM UTC.

================================================================================
Running:
	python3 /home/rocky/testing/scripts/potential_conflict.py --repofrompath BaseOS,/media/BaseOS --repoid BaseOS --repofrompath Minimal,/media/Minimal --repoid Minimal ...

Added BaseOS repo from /media/BaseOS
Added Minimal repo from /media/Minimal
Getting complete filelist for:
file:///media/BaseOS
file:///media/Minimal
184120 files found.

Looking for duplicated filenames:
16926 duplicates found.

Doing more advanced checks to see if these are real conflicts:
  5% complete (   846/ 16926, 10429/sec),    0 found - eta 0:00:01
 10% complete (  1692/ 16926,  5423/sec),    0 found - eta 0:00:02
 15% complete (  2538/ 16926, 38916/sec),    0 found - eta 0:00:01
 20% complete (  3384/ 16926, 67690/sec),    0 found - eta 0:00:01
 25% complete (  4230/ 16926, 10847/sec),    0 found - eta 0:00:01
 30% complete (  5076/ 16926, 1976814/sec),    0 found - eta 0:00:00
 35% complete (  5922/ 16926, 1909785/sec),    0 found - eta 0:00:00
 40% complete (  6768/ 16926, 174513/sec),    0 found - eta 0:00:00
 45% complete (  7614/ 16926, 238402/sec),    0 found - eta 0:00:00
 50% complete (  8460/ 16926, 2328334/sec),    0 found - eta 0:00:00
 55% complete (  9306/ 16926, 99194/sec),    0 found - eta 0:00:00
 60% complete ( 10152/ 16926, 2278985/sec),    0 found - eta 0:00:00
 65% complete ( 10998/ 16926, 2149231/sec),    0 found - eta 0:00:00
 70% complete ( 11844/ 16926, 2314664/sec),    0 found - eta 0:00:00
 75% complete ( 12690/ 16926, 2332926/sec),    0 found - eta 0:00:00
 80% complete ( 13536/ 16926, 2170263/sec),    0 found - eta 0:00:00
 85% complete ( 14382/ 16926, 39684/sec),    0 found - eta 0:00:00
 90% complete ( 15228/ 16926, 26101/sec),    0 found - eta 0:00:00
 95% complete ( 16074/ 16926, 26741/sec),    0 found - eta 0:00:00
100% complete ( 16920/ 16926, 1987888/sec),    0 found - eta 0:00:00

0 file conflicts found.
0 package conflicts found.

== Package conflicts ==

== File conflicts, listed by conflicting packages ==
```
