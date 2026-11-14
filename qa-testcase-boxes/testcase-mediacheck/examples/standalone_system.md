# Standalone System

## boot ISO

**_NOTE: boot ISO doesn't do repoclosure or package_conflict testing as there are no packages distributed on that ISO._**

```
[rocky@localhost testing]$ ./scripts/test_wrapper.sh
mkdir: created directory '/home/rocky/testing/output'
mkdir: created directory '/home/rocky/testing/output/2022-05-22'

================================================================================
Derived URLs...

iso_url:              http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-boot.iso
iso_checksum_url:     http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM
iso_checksum_sig_url: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM.sig
iso_key_url:          https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-rockyofficial

================================================================================
Verifying: http://dl.rockylinux.org/pub/rocky/8/isos exists...


================================================================================
Verifying: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-boot.iso exists...


================================================================================
Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM ...

*   Trying 146.75.94.132...
* TCP_NODELAY set
* Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
> GET /pub/rocky/8/isos/x86_64/CHECKSUM?v=1fa3a0fadf0c60757479c18254450bc0 HTTP/1.1
> Host: dl.rockylinux.org
> User-Agent: curl/7.61.1
> Accept: */*
>
< HTTP/1.1 200 OK
< Content-Type: application/octet-stream
< Server: nginx
< Last-Modified: Sun, 15 May 2022 22:25:57 GMT
< ETag: "62817df5-1c2"
< Accept-Ranges: bytes
< Via: 1.1 varnish, 1.1 varnish
< Content-Length: 450
< Date: Sun, 22 May 2022 20:01:50 GMT
< Connection: keep-alive
< X-Served-By: cache-mdw17351-MDW, cache-bur-kbur8200027-BUR
< X-Cache: MISS, MISS
< X-Cache-Hits: 0, 0
< X-Timer: S1653249710.286849,VS0,VE83
<
{ [450 bytes data]
* Connection #0 to host dl.rockylinux.org left intact

================================================================================
Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM.sig ...

*   Trying 146.75.94.132...
* TCP_NODELAY set
* Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
> GET /pub/rocky/8/isos/x86_64/CHECKSUM.sig?v=1fa3a0fadf0c60757479c18254450bc0 HTTP/1.1
> Host: dl.rockylinux.org
> User-Agent: curl/7.61.1
> Accept: */*
>
< HTTP/1.1 200 OK
< Content-Type: application/octet-stream
< Server: nginx
< Last-Modified: Mon, 16 May 2022 02:41:30 GMT
< ETag: "6281b9da-236"
< Accept-Ranges: bytes
< Via: 1.1 varnish, 1.1 varnish
< Content-Length: 566
< Date: Sun, 22 May 2022 20:01:50 GMT
< Connection: keep-alive
< X-Served-By: cache-mdw17360-MDW, cache-bur-kbur8200027-BUR
< X-Cache: MISS, MISS
< X-Cache-Hits: 0, 0
< X-Timer: S1653249710.426060,VS0,VE74
<
{ [566 bytes data]
* Connection #0 to host dl.rockylinux.org left intact

================================================================================
Downloading: https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-rockyofficial ...

*   Trying 146.75.94.132...
* TCP_NODELAY set
* Connected to dl.rockylinux.org (146.75.94.132) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: /etc/pki/tls/certs/ca-bundle.crt
  CApath: none
} [5 bytes data]
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
} [512 bytes data]
* TLSv1.3 (IN), TLS handshake, Server hello (2):
{ [122 bytes data]
* TLSv1.3 (IN), TLS handshake, [no content] (0):
{ [1 bytes data]
* TLSv1.3 (IN), TLS handshake, Encrypted Extensions (8):
{ [19 bytes data]
* TLSv1.3 (IN), TLS handshake, [no content] (0):
{ [1 bytes data]
* TLSv1.3 (IN), TLS handshake, Certificate (11):
{ [4033 bytes data]
* TLSv1.3 (IN), TLS handshake, [no content] (0):
{ [1 bytes data]
* TLSv1.3 (IN), TLS handshake, CERT verify (15):
{ [264 bytes data]
* TLSv1.3 (IN), TLS handshake, [no content] (0):
{ [1 bytes data]
* TLSv1.3 (IN), TLS handshake, Finished (20):
{ [52 bytes data]
* TLSv1.3 (OUT), TLS change cipher, Change cipher spec (1):
} [1 bytes data]
* TLSv1.3 (OUT), TLS handshake, [no content] (0):
} [1 bytes data]
* TLSv1.3 (OUT), TLS handshake, Finished (20):
} [52 bytes data]
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
* ALPN, server accepted to use h2
* Server certificate:
*  subject: CN=dl.rockylinux.org
*  start date: Apr 25 17:43:32 2022 GMT
*  expire date: Jul 24 17:43:31 2022 GMT
*  subjectAltName: host "dl.rockylinux.org" matched cert's "dl.rockylinux.org"
*  issuer: C=US; O=Let's Encrypt; CN=R3
*  SSL certificate verify ok.
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
} [5 bytes data]
* TLSv1.3 (OUT), TLS app data, [no content] (0):
} [1 bytes data]
* TLSv1.3 (OUT), TLS app data, [no content] (0):
} [1 bytes data]
* TLSv1.3 (OUT), TLS app data, [no content] (0):
} [1 bytes data]
* Using Stream ID: 1 (easy handle 0x55db6f2af6b0)
} [5 bytes data]
* TLSv1.3 (OUT), TLS app data, [no content] (0):
} [1 bytes data]
> GET /pub/rocky/RPM-GPG-KEY-rockyofficial?v=1fa3a0fadf0c60757479c18254450bc0 HTTP/2
> Host: dl.rockylinux.org
> User-Agent: curl/7.61.1
> Accept: */*
>
{ [5 bytes data]
* TLSv1.3 (IN), TLS handshake, [no content] (0):
{ [1 bytes data]
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
{ [193 bytes data]
* TLSv1.3 (IN), TLS app data, [no content] (0):
{ [1 bytes data]
* Connection state changed (MAX_CONCURRENT_STREAMS == 100)!
} [5 bytes data]
* TLSv1.3 (OUT), TLS app data, [no content] (0):
} [1 bytes data]
* TLSv1.3 (IN), TLS app data, [no content] (0):
{ [1 bytes data]
* TLSv1.3 (IN), TLS app data, [no content] (0):
{ [1 bytes data]
< HTTP/2 200
< content-type: application/octet-stream
< server: nginx
< last-modified: Mon, 03 May 2021 21:11:09 GMT
< etag: "609066ed-688"
< accept-ranges: bytes
< via: 1.1 varnish, 1.1 varnish
< date: Sun, 22 May 2022 20:01:50 GMT
< x-served-by: cache-mdw17333-MDW, cache-bur-kbur8200143-BUR
< x-cache: MISS, MISS
< x-cache-hits: 0, 0
< x-timer: S1653249711.597966,VS0,VE76
< content-length: 1672
<
{ [5 bytes data]
* TLSv1.3 (IN), TLS app data, [no content] (0):
{ [1 bytes data]
* TLSv1.3 (IN), TLS app data, [no content] (0):
{ [1 bytes data]
* Connection #0 to host dl.rockylinux.org left intact

================================================================================
Downloading: Rocky-8.6-x86_64-boot.iso ...

*   Trying 146.75.94.132...
* TCP_NODELAY set
* Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
> GET /pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-boot.iso?v=1fa3a0fadf0c60757479c18254450bc0 HTTP/1.1
> Host: dl.rockylinux.org
> User-Agent: curl/7.61.1
> Accept: */*
>
< HTTP/1.1 200 OK
< Content-Type: application/octet-stream
< Server: nginx
< Last-Modified: Sun, 15 May 2022 22:18:32 GMT
< ETag: "62817c38-35800000"
< Via: 1.1 varnish, 1.1 varnish
< Cache-Control: max-age=11059200, public, stale-while-revalidate=86400, stale-if-error=259200
< Accept-Ranges: bytes
< Date: Sun, 22 May 2022 20:01:50 GMT
< Age: 0
< Connection: keep-alive
< X-Served-By: cache-mdw17347-MDW, cache-bur-kbur8200082-BUR
< X-Cache: MISS, MISS
< X-Cache-Hits: 0, 0
< X-Timer: S1653249711.737785,VS0,VE88
< Content-Length: 897581056
<
{ [1444 bytes data]
* Connection #0 to host dl.rockylinux.org left intact

================================================================================
Importing: RPM-GPG-KEY-rockyofficial ...

gpg: directory '/home/home/rocky/.gnupg' created
gpg: keybox '/home/home/rocky/.gnupg/pubring.kbx' created
gpg: /home/home/rocky/.gnupg/trustdb.gpg: trustdb created
gpg: key 15AF5DAC6D745A60: public key "Release Engineering <infrastructure@rockylinux.org>" imported
gpg: Total number processed: 1
gpg:               imported: 1

================================================================================
Verifying gpg signature: /home/rocky/testing/CHECKSUM.sig ...

gpg: assuming signed data in '/home/rocky/testing/CHECKSUM'
gpg: Signature made Mon 16 May 2022 02:41:30 AM UTC
gpg:                using RSA key 7051C470A929F454CEBE37B715AF5DAC6D745A60
gpg: Good signature from "Release Engineering <infrastructure@rockylinux.org>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 7051 C470 A929 F454 CEBE  37B7 15AF 5DAC 6D74 5A60

================================================================================
Verifying sha256sum: /home/rocky/testing/Rocky-8.6-x86_64-boot.iso ...

Rocky-8.6-x86_64-boot.iso: OK

================================================================================
Verifying internal ISO md5: /home/rocky/testing/Rocky-8.6-x86_64-boot.iso ...


The media check is complete, the result is: PASS.

It is OK to use this media.
Press [Esc] to abort check.
```

## minimal ISO

```
[rocky@localhost testing]$ ./scripts/test_wrapper.sh minimal

================================================================================
Derived URLs...

iso_url:              http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-minimal.iso
iso_checksum_url:     http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM
iso_checksum_sig_url: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM.sig
iso_key_url:          https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-rockyofficial

================================================================================
Verifying: http://dl.rockylinux.org/pub/rocky/8/isos exists...


================================================================================
Verifying: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-minimal.iso exists...


================================================================================
Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM ...

*   Trying 146.75.94.132...
* TCP_NODELAY set
* Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
> GET /pub/rocky/8/isos/x86_64/CHECKSUM?v=442542130be00383183bdb98860548b9 HTTP/1.1
> Host: dl.rockylinux.org
> User-Agent: curl/7.61.1
> Accept: */*
>
< HTTP/1.1 200 OK
< Content-Type: application/octet-stream
< Server: nginx
< Last-Modified: Sun, 15 May 2022 22:25:57 GMT
< ETag: "62817df5-1c2"
< Accept-Ranges: bytes
< Via: 1.1 varnish, 1.1 varnish
< Content-Length: 450
< Date: Sun, 22 May 2022 20:17:49 GMT
< Connection: keep-alive
< X-Served-By: cache-mdw17357-MDW, cache-bur-kbur8200025-BUR
< X-Cache: MISS, MISS
< X-Cache-Hits: 0, 0
< X-Timer: S1653250669.932034,VS0,VE79
<
{ [450 bytes data]
* Connection #0 to host dl.rockylinux.org left intact

================================================================================
Downloading: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM.sig ...

*   Trying 146.75.94.132...
* TCP_NODELAY set
* Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
> GET /pub/rocky/8/isos/x86_64/CHECKSUM.sig?v=442542130be00383183bdb98860548b9 HTTP/1.1
> Host: dl.rockylinux.org
> User-Agent: curl/7.61.1
> Accept: */*
>
< HTTP/1.1 200 OK
< Content-Type: application/octet-stream
< Server: nginx
< Last-Modified: Mon, 16 May 2022 02:41:30 GMT
< ETag: "6281b9da-236"
< Accept-Ranges: bytes
< Via: 1.1 varnish, 1.1 varnish
< Content-Length: 566
< Date: Sun, 22 May 2022 20:17:49 GMT
< Connection: keep-alive
< X-Served-By: cache-mdw17321-MDW, cache-bur-kbur8200026-BUR
< X-Cache: MISS, MISS
< X-Cache-Hits: 0, 0
< X-Timer: S1653250669.077514,VS0,VE77
<
{ [566 bytes data]
* Connection #0 to host dl.rockylinux.org left intact

================================================================================
Downloading: Rocky-8.6-x86_64-minimal.iso ...

*   Trying 146.75.94.132...
* TCP_NODELAY set
* Connected to dl.rockylinux.org (146.75.94.132) port 80 (#0)
> GET /pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-minimal.iso?v=442542130be00383183bdb98860548b9 HTTP/1.1
> Host: dl.rockylinux.org
> User-Agent: curl/7.61.1
> Accept: */*
>
< HTTP/1.1 200 OK
< Content-Type: application/octet-stream
< Server: nginx
< Last-Modified: Sun, 15 May 2022 22:21:52 GMT
< ETag: "62817d00-87100000"
< Via: 1.1 varnish, 1.1 varnish
< Cache-Control: max-age=11059200, public, stale-while-revalidate=86400, stale-if-error=259200
< Accept-Ranges: bytes
< Date: Sun, 22 May 2022 20:17:49 GMT
< Age: 0
< Connection: keep-alive
< X-Served-By: cache-mdw17341-MDW, cache-bur-kbur8200087-BUR
< X-Cache: MISS, MISS
< X-Cache-Hits: 0, 0
< X-Timer: S1653250669.211274,VS0,VE72
< Content-Length: 2265972736
<
{ [4380 bytes data]
* Connection #0 to host dl.rockylinux.org left intact

================================================================================
Importing: RPM-GPG-KEY-rockyofficial ...

gpg: key 15AF5DAC6D745A60: "Release Engineering <infrastructure@rockylinux.org>" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1

================================================================================
Verifying gpg signature: /home/rocky/testing/CHECKSUM.sig ...

gpg: assuming signed data in '/home/rocky/testing/CHECKSUM'
gpg: Signature made Mon 16 May 2022 02:41:30 AM UTC
gpg:                using RSA key 7051C470A929F454CEBE37B715AF5DAC6D745A60
gpg: Good signature from "Release Engineering <infrastructure@rockylinux.org>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 7051 C470 A929 F454 CEBE  37B7 15AF 5DAC 6D74 5A60

================================================================================
Verifying sha256sum: /home/rocky/testing/Rocky-8.6-x86_64-minimal.iso ...

Rocky-8.6-x86_64-minimal.iso: OK

================================================================================
Verifying internal ISO md5: /home/rocky/testing/Rocky-8.6-x86_64-minimal.iso ...


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
repo: downloading from remote: BaseOS
BaseOS                                           50 MB/s | 2.6 MB     00:00
BaseOS: using metadata from Sun 15 May 2022 08:59:01 PM UTC.
repo: downloading from remote: Minimal
Minimal                                          41 kB/s | 384  B     00:00
Minimal: using metadata from Sun 15 May 2022 08:59:06 PM UTC.
Completion plugin: Generating completion cache...
Completion plugin: Can't write completion cache: attempt to write a readonly database

================================================================================
Running:
	python3 /home/rocky/testing/scripts/potential_conflict.py --repofrompath BaseOS,/media/BaseOS --repoid BaseOS --repofrompath Minimal,/media/Minimal --repoid Minimal ...

Added BaseOS repo from /media/BaseOS
Added Minimal repo from /media/Minimal
Getting complete filelist for:
file:///media/BaseOS
file:///media/Minimal
185139 files found.

Looking for duplicated filenames:
17229 duplicates found.

Doing more advanced checks to see if these are real conflicts:
  5% complete (   861/ 17229, 11363/sec),    0 found - eta 0:00:01
 10% complete (  1722/ 17229,  5973/sec),    0 found - eta 0:00:01
 15% complete (  2583/ 17229, 51202/sec),    0 found - eta 0:00:01
 20% complete (  3444/ 17229, 102894/sec),    0 found - eta 0:00:00
 25% complete (  4305/ 17229,  3637/sec),    0 found - eta 0:00:01
 30% complete (  5166/ 17229, 547497/sec),    0 found - eta 0:00:01
 35% complete (  6027/ 17229, 2076650/sec),    0 found - eta 0:00:00
 40% complete (  6888/ 17229, 201601/sec),    0 found - eta 0:00:00
 45% complete (  7749/ 17229, 444686/sec),    0 found - eta 0:00:00
 50% complete (  8610/ 17229, 129655/sec),    0 found - eta 0:00:00
 55% complete (  9471/ 17229, 2346520/sec),    0 found - eta 0:00:00
 60% complete ( 10332/ 17229, 2166344/sec),    0 found - eta 0:00:00
 65% complete ( 11193/ 17229, 2407530/sec),    0 found - eta 0:00:00
 70% complete ( 12054/ 17229, 2418818/sec),    0 found - eta 0:00:00
 75% complete ( 12915/ 17229, 2281298/sec),    0 found - eta 0:00:00
 80% complete ( 13776/ 17229, 2328366/sec),    0 found - eta 0:00:00
 85% complete ( 14637/ 17229, 45758/sec),    0 found - eta 0:00:00
 90% complete ( 15498/ 17229, 19243/sec),    0 found - eta 0:00:00
 95% complete ( 16359/ 17229, 2037977/sec),    0 found - eta 0:00:00
100% complete ( 17220/ 17229, 2126793/sec),    0 found - eta 0:00:00

0 file conflicts found.
0 package conflicts found.

== Package conflicts ==

== File conflicts, listed by conflicting packages ==
```
