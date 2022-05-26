# Default Vagrant Example

```
[rocky@localhost ~]$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'rockylinux/8'...
==> default: Matching MAC address for NAT networking...
==> default: Setting the name of the VM: testcase-debranding-validation_default_1653577650369_30157
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
    default: /vagrant => /home/rocky/testing/qa-testcase-boxes/testcase-debranding-validation
==> default: Running provisioner: Start Timestamp (shell)...
    default: Running: script: Start Timestamp
    default: Starting QA:Testcase-Debranding on Thu May 26 15:07:49 UTC 2022
==> default: Running provisioner: Install requirements (shell)...
    default: Running: script: Install requirements
    default: Rocky Linux 8 - AppStream                       9.1 MB/s | 8.3 MB     00:00
    default: Rocky Linux 8 - BaseOS                          3.3 MB/s | 2.6 MB     00:00
    default: Rocky Linux 8 - Extras                           12 kB/s |  11 kB     00:00
    default: Rocky Linux 8 - PowerTools                      2.9 MB/s | 2.3 MB     00:00
    default: Extra Packages for Enterprise Linux 8 - x86_64  7.2 MB/s |  11 MB     00:01
    default: Extra Packages for Enterprise Linux Modular 8 - 764 kB/s | 1.0 MB     00:01
    default: Dependencies resolved.
    default: ================================================================================
    default:  Package                Architecture   Version             Repository      Size
    default: ================================================================================
    default: Upgrading:
    default:  rocky-gpg-keys         noarch         8.6-3.el8           baseos          12 k
    default:  rocky-release          noarch         8.6-3.el8           baseos          21 k
    default:  rocky-repos            noarch         8.6-3.el8           baseos          14 k
    default:
    default: Transaction Summary
    default: ================================================================================
    default: Upgrade  3 Packages
    default:
    default: Total download size: 47 k
    default: Downloading Packages:
    default: (1/3): rocky-gpg-keys-8.6-3.el8.noarch.rpm      157 kB/s |  12 kB     00:00
    default: (2/3): rocky-repos-8.6-3.el8.noarch.rpm         151 kB/s |  14 kB     00:00
    default: (3/3): rocky-release-8.6-3.el8.noarch.rpm       199 kB/s |  21 kB     00:00
    default: --------------------------------------------------------------------------------
    default: Total                                           166 kB/s |  47 kB     00:00
    default: Running transaction check
    default: Transaction check succeeded.
    default: Running transaction test
    default: Transaction test succeeded.
    default: Running transaction
    default:   Preparing        :                                                        1/1
    default:   Running scriptlet: rocky-gpg-keys-8.6-3.el8.noarch                        1/1
    default:   Upgrading        : rocky-gpg-keys-8.6-3.el8.noarch                        1/6
    default:   Upgrading        : rocky-release-8.6-3.el8.noarch                         2/6
    default:   Upgrading        : rocky-repos-8.6-3.el8.noarch                           3/6
    default:   Cleanup          : rocky-release-8.6-2.el8.noarch                         4/6
    default:   Cleanup          : rocky-repos-8.6-2.el8.noarch                           5/6
    default:   Cleanup          : rocky-gpg-keys-8.6-2.el8.noarch                        6/6
    default:   Running scriptlet: rocky-gpg-keys-8.6-2.el8.noarch                        6/6
    default:   Verifying        : rocky-gpg-keys-8.6-3.el8.noarch                        1/6
    default:   Verifying        : rocky-gpg-keys-8.6-2.el8.noarch                        2/6
    default:   Verifying        : rocky-release-8.6-3.el8.noarch                         3/6
    default:   Verifying        : rocky-release-8.6-2.el8.noarch                         4/6
    default:   Verifying        : rocky-repos-8.6-3.el8.noarch                           5/6
    default:   Verifying        : rocky-repos-8.6-2.el8.noarch                           6/6
    default:
    default: Upgraded:
    default:   rocky-gpg-keys-8.6-3.el8.noarch         rocky-release-8.6-3.el8.noarch
    default:   rocky-repos-8.6-3.el8.noarch
    default:
    default: Complete!
    default: Last metadata expiration check: 0:00:02 ago on Thu 26 May 2022 03:08:01 PM UTC.
    default: Package epel-release-8-15.el8.noarch is already installed.
    default: Dependencies resolved.
    default: Nothing to do.
    default: Complete!
    default: Last metadata expiration check: 0:00:03 ago on Thu 26 May 2022 03:08:01 PM UTC.
    default: Dependencies resolved.
    default: ========================================================================================
    default:  Package                   Arch    Version                              Repo        Size
    default: ========================================================================================
    default: Installing:
    default:  jq                        x86_64  1.6-3.el8                            appstream  201 k
    default:  koji                      noarch  1.28.1-1.el8                         epel       223 k
    default:  python36                  x86_64  3.6.8-38.module+el8.5.0+671+195e4563 appstream   18 k
    default: Installing dependencies:
    default:  oniguruma                 x86_64  6.8.2-2.el8                          appstream  186 k
    default:  python3-chardet           noarch  3.0.4-7.el8                          baseos     194 k
    default:  python3-gssapi            x86_64  1.5.1-5.el8                          appstream  487 k
    default:  python3-idna              noarch  2.5-5.el8                            baseos      96 k
    default:  python3-koji              noarch  1.28.1-1.el8                         epel       331 k
    default:  python3-pip               noarch  9.0.3-22.el8.rocky.0                 appstream   19 k
    default:  python3-pysocks           noarch  1.6.8-3.el8                          baseos      33 k
    default:  python3-requests          noarch  2.20.0-2.1.el8_1                     baseos     122 k
    default:  python3-requests-gssapi   noarch  1.2.2-1.el8                          epel        26 k
    default:  python3-setuptools        noarch  39.2.0-6.el8                         baseos     162 k
    default:  python3-urllib3           noarch  1.24.2-5.el8                         baseos     176 k
    default: Enabling module streams:
    default:  python36                          3.6
    default:
    default: Transaction Summary
    default: ========================================================================================
    default: Install  14 Packages
    default:
    default: Total download size: 2.2 M
    default: Installed size: 8.1 M
    default: Downloading Packages:
    default: (1/14): oniguruma-6.8.2-2.el8.x86_64.rpm        346 kB/s | 186 kB     00:00
    default: (2/14): jq-1.6-3.el8.x86_64.rpm                 332 kB/s | 201 kB     00:00
    default: (3/14): python3-pip-9.0.3-22.el8.rocky.0.noarch 219 kB/s |  19 kB     00:00
    default: (4/14): python36-3.6.8-38.module+el8.5.0+671+19 217 kB/s |  18 kB     00:00
    default: (5/14): python3-gssapi-1.5.1-5.el8.x86_64.rpm   430 kB/s | 487 kB     00:01
    default: (6/14): python3-idna-2.5-5.el8.noarch.rpm       187 kB/s |  96 kB     00:00
    default: (7/14): python3-chardet-3.0.4-7.el8.noarch.rpm  300 kB/s | 194 kB     00:00
    default: (8/14): python3-setuptools-39.2.0-6.el8.noarch. 1.7 MB/s | 162 kB     00:00
    default: (9/14): python3-requests-2.20.0-2.1.el8_1.noarc 710 kB/s | 122 kB     00:00
    default: (10/14): python3-urllib3-1.24.2-5.el8.noarch.rp 1.8 MB/s | 176 kB     00:00
    default: (11/14): python3-pysocks-1.6.8-3.el8.noarch.rpm  90 kB/s |  33 kB     00:00
    default: (12/14): python3-requests-gssapi-1.2.2-1.el8.no 145 kB/s |  26 kB     00:00
    default: (13/14): koji-1.28.1-1.el8.noarch.rpm           454 kB/s | 223 kB     00:00
    default: (14/14): python3-koji-1.28.1-1.el8.noarch.rpm   639 kB/s | 331 kB     00:00
    default: --------------------------------------------------------------------------------
    default: Total                                           814 kB/s | 2.2 MB     00:02
    default: Running transaction check
    default: Transaction check succeeded.
    default: Running transaction test
    default: Transaction test succeeded.
    default: Running transaction
    default:   Preparing        :                                                        1/1
    default:   Installing       : python3-setuptools-39.2.0-6.el8.noarch                1/14
    default:   Installing       : python36-3.6.8-38.module+el8.5.0+671+195e4563.x86_    2/14
    default:   Running scriptlet: python36-3.6.8-38.module+el8.5.0+671+195e4563.x86_    2/14
    default:   Installing       : python3-pip-9.0.3-22.el8.rocky.0.noarch               3/14
    default:   Installing       : python3-pysocks-1.6.8-3.el8.noarch                    4/14
    default:   Installing       : python3-urllib3-1.24.2-5.el8.noarch                   5/14
    default:   Installing       : python3-idna-2.5-5.el8.noarch                         6/14
    default:   Installing       : python3-chardet-3.0.4-7.el8.noarch                    7/14
    default:   Installing       : python3-requests-2.20.0-2.1.el8_1.noarch              8/14
    default:   Installing       : python3-gssapi-1.5.1-5.el8.x86_64                     9/14
    default:   Installing       : python3-requests-gssapi-1.2.2-1.el8.noarch           10/14
    default:   Installing       : python3-koji-1.28.1-1.el8.noarch                     11/14
    default:   Installing       : oniguruma-6.8.2-2.el8.x86_64                         12/14
    default:   Running scriptlet: oniguruma-6.8.2-2.el8.x86_64                         12/14
    default:   Installing       : jq-1.6-3.el8.x86_64                                  13/14
    default:   Installing       : koji-1.28.1-1.el8.noarch                             14/14
    default:   Running scriptlet: koji-1.28.1-1.el8.noarch                             14/14
    default:   Verifying        : jq-1.6-3.el8.x86_64                                   1/14
    default:   Verifying        : oniguruma-6.8.2-2.el8.x86_64                          2/14
    default:   Verifying        : python3-gssapi-1.5.1-5.el8.x86_64                     3/14
    default:   Verifying        : python3-pip-9.0.3-22.el8.rocky.0.noarch               4/14
    default:   Verifying        : python36-3.6.8-38.module+el8.5.0+671+195e4563.x86_    5/14
    default:   Verifying        : python3-chardet-3.0.4-7.el8.noarch                    6/14
    default:   Verifying        : python3-idna-2.5-5.el8.noarch                         7/14
    default:   Verifying        : python3-pysocks-1.6.8-3.el8.noarch                    8/14
    default:   Verifying        : python3-requests-2.20.0-2.1.el8_1.noarch              9/14
    default:   Verifying        : python3-setuptools-39.2.0-6.el8.noarch               10/14
    default:   Verifying        : python3-urllib3-1.24.2-5.el8.noarch                  11/14
    default:   Verifying        : koji-1.28.1-1.el8.noarch                             12/14
    default:   Verifying        : python3-koji-1.28.1-1.el8.noarch                     13/14
    default:   Verifying        : python3-requests-gssapi-1.2.2-1.el8.noarch           14/14
    default:
    default: Installed:
    default:   jq-1.6-3.el8.x86_64
    default:   koji-1.28.1-1.el8.noarch
    default:   oniguruma-6.8.2-2.el8.x86_64
    default:   python3-chardet-3.0.4-7.el8.noarch
    default:   python3-gssapi-1.5.1-5.el8.x86_64
    default:   python3-idna-2.5-5.el8.noarch
    default:   python3-koji-1.28.1-1.el8.noarch
    default:   python3-pip-9.0.3-22.el8.rocky.0.noarch
    default:   python3-pysocks-1.6.8-3.el8.noarch
    default:   python3-requests-2.20.0-2.1.el8_1.noarch
    default:   python3-requests-gssapi-1.2.2-1.el8.noarch
    default:   python3-setuptools-39.2.0-6.el8.noarch
    default:   python3-urllib3-1.24.2-5.el8.noarch
    default:   python36-3.6.8-38.module+el8.5.0+671+195e4563.x86_64
    default:
    default: Complete!
    default:   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
    default:                                  Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100 9912k  100 9912k    0     0  10.8M      0 --:--:-- --:--:-- --:--:-- 10.8M
==> default: Running provisioner: file...
    default: etc/koji.conf => /tmp/koji.conf
==> default: Running provisioner: Deploy koji.conf (shell)...
    default: Running: script: Deploy koji.conf
==> default: Running provisioner: Prepare testing directories (shell)...
    default: Running: script: Prepare testing directories
==> default: Running provisioner: Rocky 8.6  Debrand Validation (shell)...
    default: Running: script: Rocky 8.6  Debrand Validation
    default: mkdir: created directory '/home/rocky/testing/output'
    default: mkdir: created directory '/home/rocky/testing/output/2022-05-26'
    default:
    default: ================================================================================
    default: Package Debrand Validation for x86_64 packages in Rocky-8.6-x86_64-dvd1.iso
    default:
    default: ================================================================================
    default: General Processing Parameters
    default:
    default:              type: dvd1
    default:           version: 8.6
    default:              arch: x86_64
    default:
    default: ================================================================================
    default: PackageKit
    default:
    default:
    default:        binary_pkg: PackageKit-1.1.12-6.el8.0.2.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: WALinuxAgent
    default:
    default:
    default:        binary_pkg: WALinuxAgent-2.3.0.2-2.el8.rocky.0.noarch.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: abrt
    default:
    default:
    default:        binary_pkg: abrt-2.10.9-21.el8.rocky.0.x86_64.rpm
    default:
    default: SUCCESS: PackageRequires: abrt-2.10.9-21.el8.rocky.0.x86_64.rpm.rpm does not require libreport-plugin-rhtsupport.
    default:
    default: ================================================================================
    default: anaconda
    default:
    default:
    default:        binary_pkg: anaconda-core-33.16.6.7-1.el8.rocky.0.4.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: anaconda-user-help
    default:
    default:
    default:        binary_pkg: anaconda-user-help-8.3.3-1.el8.rocky.3.2.noarch.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: chrony
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: cloud-init
    default:
    default:
    default:        binary_pkg: cloud-init-21.1-15.el8.noarch.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: crash
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: dhcp
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: dnf
    default:
    default:
    default:        binary_pkg: python3-dnf-4.7.0-8.el8.noarch.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: dotnet
    default:
    default:
    default:        binary_pkg: dotnet-runtime-2.1-2.1.30-1.el8_4.rocky.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: dotnet3.0
    default:
    default:
    default:        binary_pkg: dotnet-sdk-3.0-3.0.103-1.el8_1.rocky.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: firefox
    default:
    default:
    default:        binary_pkg: firefox-91.9.0-1.el8_5.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: fwupd
    default:
    default:
    default:        binary_pkg: fwupd-1.7.4-2.el8.x86_64.rpm
    default:
    default: SUCCESS: BinaryStrings found pattern.
    default:
    default: ================================================================================
    default: fwupdate
    default:
    default:
    default:        binary_pkg: fwupdate-efi-11-3.el8.1.1.x86_64.rpm
    default:
    default: SUCCESS: BinaryStrings found pattern.
    default:
    default: ================================================================================
    default: gcc
    default:
    default:
    default:        binary_pkg: gcc-8.5.0-10.el8.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: gnome-boxes
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: gnome-settings-daemon
    default:
    default:
    default:        binary_pkg: gnome-settings-daemon-3.32.0-16.el8.x86_64.rpm
    default: WARN: /tmp/tmp.1A1cVWYyn1/etc/xdg/autostart/org.gnome.SettingsDaemon.Subscription.desktop does not exist, should you be using koji or cache?
    default:
    default: ================================================================================
    default: grub2
    default:
    default:
    default:        binary_pkg: grub2-efi-x64-2.02-123.el8.x86_64.rpm
    default:
    default: SUCCESS: BinaryStrings found pattern.
    default:
    default: ================================================================================
    default: initial-setup
    default:
    default:
    default:        binary_pkg: initial-setup-0.3.81.7-1.el8.rocky.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: kernel
    default:
    default:
    default:        binary_pkg: kernel-core-4.18.0-372.9.1.el8.x86_64.rpm
    default:
    default: SUCCESS: BinaryStrings found pattern.
    default:
    default: ================================================================================
    default: kernel-rt
    default:
    default:
    default:        binary_pkg: kernel-rt-core-4.18.0-372.9.1.rt7.166.el8.x86_64.rpm
    default: cp: cannot stat '': No such file or directory
    default: WARN: /tmp/tmp.9TPNgIxVaL/lib/modules/4.18.0-372.9.1.rt7.166.el8.x86_64/vmlinuz does not exist, should you be using koji or cache?
    default:
    default: ================================================================================
    default: libdnf
    default:
    default:
    default:        binary_pkg: libdnf-0.63.0-8.el8.x86_64.rpm
    default:
    default: SUCCESS: BinaryStrings found pattern.
    default:
    default: ================================================================================
    default: libguestfs
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: libreoffice
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: libreport
    default:
    default:
    default:        binary_pkg: libreport-2.9.5-15.el8.rocky.6.3.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: nginx
    default:
    default:
    default:        binary_pkg: nginx-1.20.1-1.module+el8.6.0+791+48a2bb9d.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: opa-ff
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: opa-fm
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: open-vm-tools
    default:
    default:
    default:        binary_pkg: open-vm-tools-11.3.5-1.el8.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: openscap
    default:
    default:
    default:        binary_pkg: openscap-1.3.6-3.el8.rocky.0.1.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: oscap-anaconda-addon
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: pcs
    default:
    default:
    default:        binary_pkg: pcs-0.10.12-6.el8.x86_64.rpm
    default: cp: cannot stat '': No such file or directory
    default: WARN: /tmp/tmp.LVI6hfpPuK/usr/lib64/pcsd/public/images/HAM-logo.png does not exist, should you be using koji or cache?
    default:
    default: ================================================================================
    default: pesign
    default:
    default:
    default:        binary_pkg: pesign-0.112-26.el8.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: plymouth
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: python-pip
    default:
    default:
    default:        binary_pkg: platform-python-pip-9.0.3-22.el8.rocky.0.noarch.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: python2
    default:
    default:
    default:        binary_pkg: python2-libs-2.7.18-10.module+el8.6.0+793+57002515.rocky.0.2.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: python3
    default:
    default:
    default:        binary_pkg: python3-libs-3.6.8-45.el8.rocky.0.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: redhat-rpm-config
    default:
    default:
    default:        binary_pkg: redhat-rpm-config-129-1.el8.noarch.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: scap-security-guide
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: shim
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: shim-unsigned-aarch64
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: shim-unsigned-x64
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: sos
    default:
    default:
    default:        binary_pkg: sos-4.2-15.el8.noarch.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: subscription-manager
    default:
    default:
    default:        binary_pkg: subscription-manager-1.28.29-3.el8.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: systemd
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: thunderbird
    default:
    default:
    default:        binary_pkg: thunderbird-91.9.0-3.el8_5.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
==> default: Running provisioner: End Timestamp (shell)...
    default: Running: script: End Timestamp
    default: Finished QA:Testcase-Debranding on Thu May 26 15:08:37 UTC 2022
```
