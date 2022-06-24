# Standalone System with Package in RPM cache

## run with local cache and brief output

```
[rocky@localhost vagrant]$ ./scripts/debrand_validation.sh -t cache

================================================================================
Package Debrand Validation for x86_64 packages in local package cache

================================================================================
General Processing Parameters

             type: cache
          version: 8.6
             arch: x86_64

================================================================================
PackageKit


       binary_pkg: PackageKit-1.1.12-6.el8.0.2.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
WALinuxAgent


       binary_pkg: WALinuxAgent-2.3.0.2-2.el8.rocky.0.noarch.rpm

SUCCESS: FileContents found pattern.

================================================================================
abrt


       binary_pkg: abrt-2.10.9-21.el8.rocky.0.x86_64.rpm

SUCCESS: PackageRequires: abrt-2.10.9-21.el8.rocky.0.x86_64.rpm.rpm does not require libreport-plugin-rhtsupport.

================================================================================
anaconda


       binary_pkg: anaconda-core-33.16.6.7-1.el8.rocky.0.4.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
anaconda-user-help


       binary_pkg: anaconda-user-help-8.3.3-1.el8.rocky.3.2.noarch.rpm

SUCCESS: FileContents found pattern.

================================================================================
chrony

          src_pkg: chrony-4.1-1.el8.src.rpm

SUCCESS: FileContents found pattern.

================================================================================
cloud-init


       binary_pkg: cloud-init-21.1-15.el8.noarch.rpm

SUCCESS: FileContents found pattern.

================================================================================
crash

          src_pkg: crash-7.3.1-5.el8.src.rpm

SUCCESS: FileContents found pattern.

================================================================================
dhcp

          src_pkg: dhcp-4.3.6-47.el8.src.rpm

SUCCESS: FileContents found pattern.

================================================================================
dnf


       binary_pkg: python3-dnf-4.7.0-8.el8.noarch.rpm

SUCCESS: FileContents found pattern.

================================================================================
dotnet


       binary_pkg: dotnet-runtime-2.1-2.1.30-1.el8_4.rocky.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
dotnet3.0


       binary_pkg: dotnet-sdk-3.0-3.0.103-1.el8_1.rocky.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
firefox


       binary_pkg: firefox-91.9.0-1.el8_5.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
fwupd


       binary_pkg: fwupd-1.7.4-2.el8.x86_64.rpm

SUCCESS: BinaryStrings found pattern.

================================================================================
fwupdate


       binary_pkg: fwupdate-efi-11-3.el8.1.1.x86_64.rpm

SUCCESS: BinaryStrings found pattern.

================================================================================
gcc


       binary_pkg: gcc-8.5.0-10.el8.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
gnome-boxes

          src_pkg: gnome-boxes-3.36.5-8.el8.rocky.0.1.src.rpm

SUCCESS: FileContents found pattern.

================================================================================
gnome-settings-daemon


       binary_pkg: gnome-settings-daemon-3.32.0-16.el8.x86_64.rpm
WARN: /tmp/tmp.FgyAnH8LmS/etc/xdg/autostart/org.gnome.SettingsDaemon.Subscription.desktop does not exist, should you be using koji or cache?

================================================================================
grub2


       binary_pkg: grub2-efi-x64-2.02-123.el8.x86_64.rpm

SUCCESS: BinaryStrings found pattern.

================================================================================
initial-setup


       binary_pkg: initial-setup-0.3.81.7-1.el8.rocky.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
kernel


       binary_pkg: kernel-core-4.18.0-372.9.1.el8.x86_64.rpm

SUCCESS: BinaryStrings found pattern.

================================================================================
kernel-rt


       binary_pkg: kernel-rt-core-4.18.0-372.9.1.rt7.166.el8.x86_64.rpm
WARN: /tmp/tmp.L0JdArcANa/lib/modules/4.18.0-372.9.1.rt7.166.el8.x86_64/vmlinuz does not exist, should you be using koji or cache?

================================================================================
libdnf


       binary_pkg: libdnf-0.63.0-8.el8.x86_64.rpm

SUCCESS: BinaryStrings found pattern.

================================================================================
libguestfs

          src_pkg: libguestfs-1.44.0-5.module+el8.6.0+847+b490afdd.rocky.src.rpm

SUCCESS: FileContents found pattern.

================================================================================
libreoffice

          src_pkg: libreoffice-6.4.7.2-10.el8.src.rpm

SUCCESS: FileContents found pattern.

================================================================================
libreport


       binary_pkg: libreport-2.9.5-15.el8.rocky.6.3.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
nginx


       binary_pkg: nginx-1.20.1-1.module+el8.6.0+791+48a2bb9d.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
opa-ff

          src_pkg: opa-ff-10.11.0.2-1.el8.rocky.src.rpm

SUCCESS: FileContents found pattern.

================================================================================
opa-fm

          src_pkg: opa-fm-10.11.0.2.1-1.el8.rocky.src.rpm

SUCCESS: FileContents found pattern.

================================================================================
open-vm-tools


       binary_pkg: open-vm-tools-11.3.5-1.el8.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
openscap


       binary_pkg: openscap-1.3.6-3.el8.rocky.0.1.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
oscap-anaconda-addon

          src_pkg: oscap-anaconda-addon-1.2.1-5.el8.src.rpm

SUCCESS: FileContents found pattern.

================================================================================
pcs


       binary_pkg: pcs-0.10.12-6.el8.x86_64.rpm
WARN: /tmp/tmp.AdpiWmJ0iW/usr/lib64/pcsd/public/images/HAM-logo.png does not exist, should you be using koji or cache?

================================================================================
pesign


       binary_pkg: pesign-0.112-26.el8.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
plymouth

          src_pkg: plymouth-0.9.4-11.20200615git1e36e30.el8.src.rpm

SUCCESS: FileContents found pattern.

================================================================================
python-pip


       binary_pkg: platform-python-pip-9.0.3-22.el8.rocky.0.noarch.rpm

SUCCESS: FileContents found pattern.

================================================================================
python2


       binary_pkg: python2-libs-2.7.18-10.module+el8.6.0+793+57002515.rocky.0.2.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
python3


       binary_pkg: python3-libs-3.6.8-45.el8.rocky.0.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
redhat-rpm-config


       binary_pkg: redhat-rpm-config-129-1.el8.noarch.rpm

SUCCESS: FileContents found pattern.

================================================================================
scap-security-guide

          src_pkg: scap-security-guide-0.1.60-7.el8.rocky.0.1.src.rpm

SUCCESS: FileContents found pattern.

================================================================================
shim

          src_pkg: shim-15.4-2.el8_5.2.rocky.src.rpm

SUCCESS: FileContents found pattern.

================================================================================
shim-unsigned-aarch64

          src_pkg: shim-unsigned-aarch64-15-7.el8.1.src.rpm

SUCCESS: FileContents found pattern.

================================================================================
shim-unsigned-x64

          src_pkg: shim-unsigned-x64-15.4-4.el8_5.2.rocky.src.rpm

SUCCESS: FileContents found pattern.

================================================================================
sos


       binary_pkg: sos-4.2-15.el8.noarch.rpm

SUCCESS: FileContents found pattern.

================================================================================
subscription-manager


       binary_pkg: subscription-manager-1.28.29-3.el8.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
systemd

          src_pkg: systemd-239-58.el8.src.rpm

SUCCESS: systemd.spec does not contain pattern.

================================================================================
thunderbird


       binary_pkg: thunderbird-91.9.0-3.el8_5.x86_64.rpm

SUCCESS: FileContents found pattern.
```


## run with local cache and extended output

```
[rocky@localhost testing]$ ./scripts/debrand_validation.sh -x -t cache

================================================================================
Package Debrand Validation for x86_64 packages in local package cache

PackageKit           WALinuxAgent          abrt
anaconda             anaconda-user-help    chrony
cloud-init           crash                 dhcp
dnf                  dotnet                dotnet3.0
firefox              fwupd                 fwupdate
gcc                  gnome-boxes           gnome-settings-daemon
grub2                initial-setup         kernel
kernel-rt            libdnf                libguestfs
libreoffice          libreport             nginx
opa-ff               opa-fm                open-vm-tools
openscap             oscap-anaconda-addon  pcs
pesign               plymouth              python-pip
python2              python3               redhat-rpm-config
scap-security-guide  shim                  shim-unsigned-aarch64
shim-unsigned-x64    sos                   subscription-manager
systemd              thunderbird


================================================================================
General Processing Parameters

             type: cache
          version: 8.6
             arch: x86_64
          baseurl: http://dl.rockylinux.org/pub/rocky
      iso_baseurl: http://dl.rockylinux.org/pub/rocky/8.6/isos
       iso_prefix: Rocky
       repo_names: baseos,appstream,powertools,extras
         koji_tag: dist-rocky8-compose
        rocky_rel: 8
          log_dir: /home/rocky/testing/output/2022-05-26
  log_file_suffix: debrand_validation.out
         extended: 1
       script_dir: /home/rocky/testing/scripts
    rpm_cache_dir: /home/rocky/testing/rpms

================================================================================
PackageKit


r8.yaml contents for PackageKit


          modular: false
            check: FileContents
          nvr_pkg: PackageKit-1.1.12-6.el8.0.2
             file: /etc/PackageKit/Vendor.conf
          content: https://wiki.rockylinux.org/
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: PackageKit-1.1.12-6.el8.0.2.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/PackageKit-1.1.12-6.el8.0.2.x86_64.rpm

5420 blocks


SUCCESS: FileContents found pattern.

================================================================================
WALinuxAgent


r8.yaml contents for WALinuxAgent


          modular: false
            check: FileContents
          nvr_pkg: WALinuxAgent-2.3.0.2-2.el8.rocky.0
             file: /usr/lib/python3.6/site-packages/azurelinuxagent/common/osutil/factory.py
          content: rocky
            value: true
         pkg_arch: noarch
           source: na

       binary_pkg: WALinuxAgent-2.3.0.2-2.el8.rocky.0.noarch.rpm
       cache_path: /home/rocky/testing/rpms/WALinuxAgent-2.3.0.2-2.el8.rocky.0.noarch.rpm

3756 blocks


SUCCESS: FileContents found pattern.

================================================================================
abrt


r8.yaml contents for abrt


          modular: false
            check: PackageRequires
          nvr_pkg: abrt-2.10.9-21.el8.rocky.0
             file: na
          content: libreport-plugin-rhtsupport
            value: false
         pkg_arch: x86_64
           source: na

       binary_pkg: abrt-2.10.9-21.el8.rocky.0.x86_64.rpm

SUCCESS: PackageRequires: abrt-2.10.9-21.el8.rocky.0.x86_64.rpm.rpm does not require libreport-plugin-rhtsupport.

================================================================================
anaconda


r8.yaml contents for anaconda


          modular: false
            check: FileContents
          nvr_pkg: anaconda-core-33.16.6.7-1.el8.rocky.0.4
             file: /etc/anaconda/product.d/rocky.conf
          content: rocky_help_placeholder.xml
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: anaconda-core-33.16.6.7-1.el8.rocky.0.4.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/anaconda-core-33.16.6.7-1.el8.rocky.0.4.x86_64.rpm

23009 blocks


SUCCESS: FileContents found pattern.

================================================================================
anaconda-user-help


r8.yaml contents for anaconda-user-help


          modular: false
            check: FileContents
          nvr_pkg: anaconda-user-help-8.3.3-1.el8.rocky.3.2
             file: /usr/share/anaconda/help/rocky/en-US/anaconda-help.xml
          content: Welcome to Rocky Linux
            value: true
         pkg_arch: noarch
           source: na

       binary_pkg: anaconda-user-help-8.3.3-1.el8.rocky.3.2.noarch.rpm
       cache_path: /home/rocky/testing/rpms/anaconda-user-help-8.3.3-1.el8.rocky.3.2.noarch.rpm

252 blocks


SUCCESS: FileContents found pattern.

================================================================================
chrony


r8.yaml contents for chrony


          modular: false
            check: FileContents
          nvr_pkg: chrony-4.1-1.el8
             file: chrony.spec
          content: The NTP people really
            value: true
         pkg_arch: src
           source: koji
          src_pkg: chrony-4.1-1.el8.src.rpm
       cache_path: /home/rocky/testing/rpms/chrony-4.1-1.el8.src.rpm

1314 blocks


SUCCESS: FileContents found pattern.

================================================================================
cloud-init


r8.yaml contents for cloud-init


          modular: false
            check: FileContents
          nvr_pkg: cloud-init-21.1-15.el8
             file: /usr/lib/python3.6/site-packages/cloudinit/distros/__init__.py
          content: rocky
            value: true
         pkg_arch: noarch
           source: na

       binary_pkg: cloud-init-21.1-15.el8.noarch.rpm
       cache_path: /home/rocky/testing/rpms/cloud-init-21.1-15.el8.noarch.rpm

7278 blocks


SUCCESS: FileContents found pattern.

================================================================================
crash


r8.yaml contents for crash


          modular: false
            check: FileContents
          nvr_pkg: crash-7.3.1-5.el8
             file: crash.spec
          content: Rocky Linux
            value: true
         pkg_arch: src
           source: koji
          src_pkg: crash-7.3.1-5.el8.src.rpm
       cache_path: /home/rocky/testing/rpms/crash-7.3.1-5.el8.src.rpm

64147 blocks


SUCCESS: FileContents found pattern.

================================================================================
dhcp


r8.yaml contents for dhcp


          modular: false
            check: FileContents
          nvr_pkg: dhcp-4.3.6-47.el8
             file: dhcp-errwarn-message.patch
          content: https://bugs.rockylinux.org/
            value: true
         pkg_arch: src
           source: koji
          src_pkg: dhcp-4.3.6-47.el8.src.rpm
       cache_path: /home/rocky/testing/rpms/dhcp-4.3.6-47.el8.src.rpm

20582 blocks


SUCCESS: FileContents found pattern.

================================================================================
dnf


r8.yaml contents for dnf


          modular: false
            check: FileContents
          nvr_pkg: python3-dnf-4.7.0-8.el8
             file: /usr/lib/python3.6/site-packages/dnf/const.py
          content: BUGTRACKER='https://bugs.rockylinux.org/'
            value: true
         pkg_arch: noarch
           source: na

       binary_pkg: python3-dnf-4.7.0-8.el8.noarch.rpm
       cache_path: /home/rocky/testing/rpms/python3-dnf-4.7.0-8.el8.noarch.rpm

3816 blocks


SUCCESS: FileContents found pattern.

================================================================================
dotnet


r8.yaml contents for dotnet


          modular: false
            check: FileContents
          nvr_pkg: dotnet-runtime-2.1-2.1.30-1.el8_4.rocky
             file: /usr/lib64/dotnet/shared/Microsoft.NETCore.App/2.1.30/Microsoft.NETCore.App.deps.json
          content: runtime.rocky
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: dotnet-runtime-2.1-2.1.30-1.el8_4.rocky.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/dotnet-runtime-2.1-2.1.30-1.el8_4.rocky.x86_64.rpm

131048 blocks


SUCCESS: FileContents found pattern.

================================================================================
dotnet3.0


r8.yaml contents for dotnet3.0


          modular: false
            check: FileContents
          nvr_pkg: dotnet-sdk-3.0-3.0.103-1.el8_1.rocky
             file: /usr/lib64/dotnet/sdk/3.0.103/RuntimeIdentifierGraph.json
          content: rocky
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: dotnet-sdk-3.0-3.0.103-1.el8_1.rocky.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/dotnet-sdk-3.0-3.0.103-1.el8_1.rocky.x86_64.rpm

280847 blocks


SUCCESS: FileContents found pattern.

================================================================================
firefox


r8.yaml contents for firefox


          modular: false
            check: FileContents
          nvr_pkg: firefox-91.9.0-1.el8_5
             file: /usr/lib64/firefox/defaults/preferences/all-redhat.js
          content: https://rockylinux.org
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: firefox-91.9.0-1.el8_5.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/firefox-91.9.0-1.el8_5.x86_64.rpm

536557 blocks


SUCCESS: FileContents found pattern.

================================================================================
fwupd


r8.yaml contents for fwupd


          modular: false
            check: BinaryStrings
          nvr_pkg: fwupd-1.7.4-2.el8
             file: /usr/libexec/fwupd/efi/fwupdx64.efi.signed
          content: Rocky Linux Secure Boot Root CA
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: fwupd-1.7.4-2.el8.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/fwupd-1.7.4-2.el8.x86_64.rpm

17009 blocks


SUCCESS: BinaryStrings found pattern.

================================================================================
fwupdate


r8.yaml contents for fwupdate


          modular: false
            check: BinaryStrings
          nvr_pkg: fwupdate-efi-11-3.el8.1.1
             file: /boot/efi/EFI/rocky/fwupx64.efi
          content: Rocky Linux Secure Boot Root CA
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: fwupdate-efi-11-3.el8.1.1.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/fwupdate-efi-11-3.el8.1.1.x86_64.rpm

281 blocks


SUCCESS: BinaryStrings found pattern.

================================================================================
gcc


r8.yaml contents for gcc


          modular: false
            check: FileContents
          nvr_pkg: gcc-8.5.0-10.el8
             file: /usr/share/man/man1/gcc.1.gz
          content: https://bugs.rockylinux.org/
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: gcc-8.5.0-10.el8.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/gcc-8.5.0-10.el8.x86_64.rpm

120716 blocks


SUCCESS: FileContents found pattern.

================================================================================
gnome-boxes


r8.yaml contents for gnome-boxes


          modular: false
            check: FileContents
          nvr_pkg: gnome-boxes-3.36.5-8.el8.rocky.0.1
             file: add-rocky-logo-and-update-recommended-list.patch
          content: http://rockylinux.org/rocky/8.6
            value: true
         pkg_arch: src
           source: koji
          src_pkg: gnome-boxes-3.36.5-8.el8.rocky.0.1.src.rpm
       cache_path: /home/rocky/testing/rpms/gnome-boxes-3.36.5-8.el8.rocky.0.1.src.rpm

2545 blocks


SUCCESS: FileContents found pattern.

================================================================================
gnome-settings-daemon


r8.yaml contents for gnome-settings-daemon


          modular: false
            check: FileExists
          nvr_pkg: gnome-settings-daemon-3.32.0-16.el8
             file: /etc/xdg/autostart/org.gnome.SettingsDaemon.Subscription.desktop
          content: na
            value: false
         pkg_arch: x86_64
           source: na

       binary_pkg: gnome-settings-daemon-3.32.0-16.el8.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/gnome-settings-daemon-3.32.0-16.el8.x86_64.rpm

10698 blocks

WARN: /tmp/tmp.0GgkeFFHTb/etc/xdg/autostart/org.gnome.SettingsDaemon.Subscription.desktop does not exist, should you be using koji or cache?

================================================================================
grub2


r8.yaml contents for grub2


          modular: false
            check: BinaryStrings
          nvr_pkg: grub2-efi-x64-2.02-123.el8
             file: /boot/efi/EFI/rocky/grubx64.efi
          content: Rocky Linux Secure Boot Root CA
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: grub2-efi-x64-2.02-123.el8.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/grub2-efi-x64-2.02-123.el8.x86_64.rpm

4480 blocks


SUCCESS: BinaryStrings found pattern.

================================================================================
initial-setup


r8.yaml contents for initial-setup


          modular: false
            check: FileContents
          nvr_pkg: initial-setup-0.3.81.7-1.el8.rocky
             file: /usr/lib/python3.6/site-packages/initial_setup/product.py
          content: /usr/share/rocky-release
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: initial-setup-0.3.81.7-1.el8.rocky.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/initial-setup-0.3.81.7-1.el8.rocky.x86_64.rpm

430 blocks


SUCCESS: FileContents found pattern.

================================================================================
kernel


r8.yaml contents for kernel


          modular: false
            check: BinaryStrings
          nvr_pkg: kernel-core-4.18.0-372.9.1.el8
             file: /lib/modules/4.18.0-372.9.1.el8.x86_64/vmlinuz
          content: Rocky Linux Secure Boot Root CA
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: kernel-core-4.18.0-372.9.1.el8.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/kernel-core-4.18.0-372.9.1.el8.x86_64.rpm

70300 blocks


SUCCESS: BinaryStrings found pattern.

================================================================================
kernel-rt


r8.yaml contents for kernel-rt


          modular: false
            check: BinaryStrings
          nvr_pkg: kernel-rt-core-4.18.0-372.9.1.rt7.166.el8
             file: /lib/modules/4.18.0-372.9.1.rt7.166.el8.x86_64/vmlinuz
          content: Rocky Linux Secure Boot Root CA
            value: true
         pkg_arch: x86_64
           source: koji

       binary_pkg: kernel-rt-core-4.18.0-372.9.1.rt7.166.el8.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/kernel-rt-core-4.18.0-372.9.1.rt7.166.el8.x86_64.rpm

cpio: premature end of archive

WARN: /tmp/tmp.aIM5nn8npR/lib/modules/4.18.0-372.9.1.rt7.166.el8.x86_64/vmlinuz does not exist, should you be using koji or cache?

================================================================================
libdnf


r8.yaml contents for libdnf


          modular: false
            check: BinaryStrings
          nvr_pkg: libdnf-0.63.0-8.el8
             file: /usr/lib64/libdnf.so.2
          content: https://bugs.rockylinux.org/
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: libdnf-0.63.0-8.el8.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/libdnf-0.63.0-8.el8.x86_64.rpm

4725 blocks


SUCCESS: BinaryStrings found pattern.

================================================================================
libguestfs


r8.yaml contents for libguestfs


          modular: true
            check: FileContents
          nvr_pkg: libguestfs-1.44.0-5.module+el8.6.0+847+b490afdd.rocky
             file: 0001-Add-ROCKY-to-list-of-REDHAT-distros.patch
          content: ROCKY
            value: true
         pkg_arch: src
           source: koji
          src_pkg: libguestfs-1.44.0-5.module+el8.6.0+847+b490afdd.rocky.src.rpm
       cache_path: /home/rocky/testing/rpms/libguestfs-1.44.0-5.module+el8.6.0+847+b490afdd.rocky.src.rpm

46973 blocks


SUCCESS: FileContents found pattern.

================================================================================
libreoffice


r8.yaml contents for libreoffice


          modular: true
            check: FileContents
          nvr_pkg: libreoffice-6.4.7.2-10.el8
             file: libreoffice.spec
          content: Rocky Enterprise Software Foundation
            value: true
         pkg_arch: src
           source: koji
          src_pkg: libreoffice-6.4.7.2-10.el8.src.rpm
       cache_path: /home/rocky/testing/rpms/libreoffice-6.4.7.2-10.el8.src.rpm

974756 blocks


SUCCESS: FileContents found pattern.

================================================================================
libreport


r8.yaml contents for libreport


          modular: false
            check: FileContents
          nvr_pkg: libreport-2.9.5-15.el8.rocky.6.3
             file: /usr/share/doc/libreport/README.md
          content: https://bugs.rockylinux.org
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: libreport-2.9.5-15.el8.rocky.6.3.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/libreport-2.9.5-15.el8.rocky.6.3.x86_64.rpm

4838 blocks


SUCCESS: FileContents found pattern.

================================================================================
nginx


r8.yaml contents for nginx


          modular: true
            check: FileContents
          nvr_pkg: nginx-1.20.1-1.module+el8.6.0+791+48a2bb9d
             file: /usr/share/nginx/html/404.html
          content: <a href="https://www.rockylinux.org/">
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: nginx-1.20.1-1.module+el8.6.0+791+48a2bb9d.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/nginx-1.20.1-1.module+el8.6.0+791+48a2bb9d.x86_64.rpm

3448 blocks


SUCCESS: FileContents found pattern.

================================================================================
opa-ff


r8.yaml contents for opa-ff


          modular: false
            check: FileContents
          nvr_pkg: opa-ff-10.11.0.2-1.el8.rocky
             file: 5000-add-rocky.patch
          content: Rocky Linux
            value: true
         pkg_arch: src
           source: koji
          src_pkg: opa-ff-10.11.0.2-1.el8.rocky.src.rpm
       cache_path: /home/rocky/testing/rpms/opa-ff-10.11.0.2-1.el8.rocky.src.rpm

3626 blocks


SUCCESS: FileContents found pattern.

================================================================================
opa-fm


r8.yaml contents for opa-fm


          modular: false
            check: FileContents
          nvr_pkg: opa-fm-10.11.0.2.1-1.el8.rocky
             file: 5000-add-rocky.patch
          content: Rocky Linux
            value: true
         pkg_arch: src
           source: koji
          src_pkg: opa-fm-10.11.0.2.1-1.el8.rocky.src.rpm
       cache_path: /home/rocky/testing/rpms/opa-fm-10.11.0.2.1-1.el8.rocky.src.rpm

3716 blocks


SUCCESS: FileContents found pattern.

================================================================================
open-vm-tools


r8.yaml contents for open-vm-tools


          modular: true
            check: FileContents
          nvr_pkg: open-vm-tools-11.3.5-1.el8
             file: /usr/lib64/libvmtools.so.0.0.0
          content: Rocky
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: open-vm-tools-11.3.5-1.el8.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/open-vm-tools-11.3.5-1.el8.x86_64.rpm

6558 blocks


SUCCESS: FileContents found pattern.

================================================================================
openscap


r8.yaml contents for openscap


          modular: false
            check: FileContents
          nvr_pkg: openscap-1.3.6-3.el8.rocky.0.1
             file: /usr/share/openscap/cpe/openscap-cpe-oval.xml
          content: <platform>Rocky Linux 8</platform>
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: openscap-1.3.6-3.el8.rocky.0.1.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/openscap-1.3.6-3.el8.rocky.0.1.x86_64.rpm

134700 blocks


SUCCESS: FileContents found pattern.

================================================================================
oscap-anaconda-addon


r8.yaml contents for oscap-anaconda-addon


          modular: true
            check: FileContents
          nvr_pkg: oscap-anaconda-addon-1.2.1-5.el8
             file: oscap-anaconda-addon.spec
          content: This is a Rocky maintained package
            value: true
         pkg_arch: src
           source: koji
          src_pkg: oscap-anaconda-addon-1.2.1-5.el8.src.rpm
       cache_path: /home/rocky/testing/rpms/oscap-anaconda-addon-1.2.1-5.el8.src.rpm

13259 blocks


SUCCESS: FileContents found pattern.

================================================================================
pcs


r8.yaml contents for pcs


          modular: false
            check: FileChecksum
          nvr_pkg: pcs-0.10.12-6.el8
             file: /usr/lib64/pcsd/public/images/HAM-logo.png
          content: 043a89fba25a8dbf8d1b860f4a991e4b4dd20ce30b9eccd969f77a85cf1715fd
            value: true
         pkg_arch: x86_64
           source: koji

       binary_pkg: pcs-0.10.12-6.el8.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/pcs-0.10.12-6.el8.x86_64.rpm

cpio: premature end of archive

WARN: /tmp/tmp.P0bKqRDyns/usr/lib64/pcsd/public/images/HAM-logo.png does not exist, should you be using koji or cache?

================================================================================
pesign


r8.yaml contents for pesign


          modular: false
            check: FileContents
          nvr_pkg: pesign-0.112-26.el8
             file: /usr/lib/rpm/macros.d/macros.pesign
          content: Rocky Linux Secure Boot Signing Local Test Cert - Rocky Enterprise Software Foundation
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: pesign-0.112-26.el8.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/pesign-0.112-26.el8.x86_64.rpm

2205 blocks


SUCCESS: FileContents found pattern.

================================================================================
plymouth


r8.yaml contents for plymouth


          modular: false
            check: FileContents
          nvr_pkg: plymouth-0.9.4-11.20200615git1e36e30.el8
             file: plymouth.spec
          content: Rocky Linux
            value: true
         pkg_arch: src
           source: koji
          src_pkg: plymouth-0.9.4-11.20200615git1e36e30.el8.src.rpm
       cache_path: /home/rocky/testing/rpms/plymouth-0.9.4-11.20200615git1e36e30.el8.src.rpm

2377 blocks


SUCCESS: FileContents found pattern.

================================================================================
python-pip


r8.yaml contents for python-pip


          modular: false
            check: FileContents
          nvr_pkg: platform-python-pip-9.0.3-22.el8.rocky.0
             file: /usr/lib/python3.6/site-packages/pip/_vendor/distro.py
          content: Rocky Linux
            value: true
         pkg_arch: noarch
           source: na

       binary_pkg: platform-python-pip-9.0.3-22.el8.rocky.0.noarch.rpm
       cache_path: /home/rocky/testing/rpms/platform-python-pip-9.0.3-22.el8.rocky.0.noarch.rpm

14239 blocks


SUCCESS: FileContents found pattern.

================================================================================
python2


r8.yaml contents for python2


          modular: true
            check: FileContents
          nvr_pkg: python2-libs-2.7.18-10.module+el8.6.0+793+57002515.rocky.0.2
             file: /usr/lib64/python2.7/platform.py
          content: rocky
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: python2-libs-2.7.18-10.module+el8.6.0+793+57002515.rocky.0.2.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/python2-libs-2.7.18-10.module+el8.6.0+793+57002515.rocky.0.2.x86_64.rpm

51587 blocks


SUCCESS: FileContents found pattern.

================================================================================
python3


r8.yaml contents for python3


          modular: false
            check: FileContents
          nvr_pkg: python3-libs-3.6.8-45.el8.rocky.0
             file: /usr/lib64/python3.6/platform.py
          content: rocky
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: python3-libs-3.6.8-45.el8.rocky.0.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/python3-libs-3.6.8-45.el8.rocky.0.x86_64.rpm

64128 blocks


SUCCESS: FileContents found pattern.

================================================================================
redhat-rpm-config


r8.yaml contents for redhat-rpm-config


          modular: false
            check: FileContents
          nvr_pkg: redhat-rpm-config-129-1.el8
             file: /usr/lib/rpm/redhat/dist.sh
          content: Rocky
            value: true
         pkg_arch: noarch
           source: na

       binary_pkg: redhat-rpm-config-129-1.el8.noarch.rpm
       cache_path: /home/rocky/testing/rpms/redhat-rpm-config-129-1.el8.noarch.rpm

305 blocks


SUCCESS: FileContents found pattern.

================================================================================
scap-security-guide


r8.yaml contents for scap-security-guide


          modular: false
            check: FileContents
          nvr_pkg: scap-security-guide-0.1.60-7.el8.rocky.0.1
             file: scap-security-guide.spec
          content: DSSG_PRODUCT_ROCKY8
            value: true
         pkg_arch: src
           source: koji
          src_pkg: scap-security-guide-0.1.60-7.el8.rocky.0.1.src.rpm
       cache_path: /home/rocky/testing/rpms/scap-security-guide-0.1.60-7.el8.rocky.0.1.src.rpm

28928 blocks


SUCCESS: FileContents found pattern.

================================================================================
shim


r8.yaml contents for shim


          modular: false
            check: FileContents
          nvr_pkg: shim-15.4-2.el8_5.2.rocky
             file: shim.spec
          content: rocky-root-ca.der
            value: true
         pkg_arch: src
           source: koji
          src_pkg: shim-15.4-2.el8_5.2.rocky.src.rpm
       cache_path: /home/rocky/testing/rpms/shim-15.4-2.el8_5.2.rocky.src.rpm

4955 blocks


SUCCESS: FileContents found pattern.

================================================================================
shim-unsigned-aarch64


r8.yaml contents for shim-unsigned-aarch64


          modular: false
            check: FileContents
          nvr_pkg: shim-unsigned-aarch64-15-7.el8.1
             file: shim-unsigned-aarch64.spec
          content: rocky-root-ca.der
            value: true
         pkg_arch: src
           source: koji
          src_pkg: shim-unsigned-aarch64-15-7.el8.1.src.rpm
       cache_path: /home/rocky/testing/rpms/shim-unsigned-aarch64-15-7.el8.1.src.rpm

2070 blocks


SUCCESS: FileContents found pattern.

================================================================================
shim-unsigned-x64


r8.yaml contents for shim-unsigned-x64


          modular: false
            check: FileContents
          nvr_pkg: shim-unsigned-x64-15.4-4.el8_5.2.rocky
             file: shim-unsigned-x64.spec
          content: rocky-root-ca.der
            value: true
         pkg_arch: src
           source: koji
          src_pkg: shim-unsigned-x64-15.4-4.el8_5.2.rocky.src.rpm
       cache_path: /home/rocky/testing/rpms/shim-unsigned-x64-15.4-4.el8_5.2.rocky.src.rpm

2769 blocks


SUCCESS: FileContents found pattern.

================================================================================
sos


r8.yaml contents for sos


          modular: false
            check: FileContents
          nvr_pkg: sos-4.2-15.el8
             file: /usr/lib/python3.6/site-packages/sos/policies/distros/rocky.py
          content: Rocky Enterprise Software Foundation
            value: true
         pkg_arch: noarch
           source: na

       binary_pkg: sos-4.2-15.el8.noarch.rpm
       cache_path: /home/rocky/testing/rpms/sos-4.2-15.el8.noarch.rpm

5555 blocks


SUCCESS: FileContents found pattern.

================================================================================
subscription-manager


r8.yaml contents for subscription-manager


          modular: false
            check: FileContents
          nvr_pkg: subscription-manager-1.28.29-3.el8
             file: /etc/dnf/plugins/subscription-manager.conf
          content: enabled=0
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: subscription-manager-1.28.29-3.el8.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/subscription-manager-1.28.29-3.el8.x86_64.rpm

9079 blocks


SUCCESS: FileContents found pattern.

================================================================================
systemd


r8.yaml contents for systemd


          modular: false
            check: FileContents
          nvr_pkg: systemd-239-58.el8
             file: systemd.spec
          content: 0028-journal-change-support-URL-shown-in-the-catalog-entr.patch
            value: false
         pkg_arch: src
           source: koji
          src_pkg: systemd-239-58.el8.src.rpm
       cache_path: /home/rocky/testing/rpms/systemd-239-58.el8.src.rpm

28352 blocks


SUCCESS: systemd.spec does not contain pattern.

================================================================================
thunderbird


r8.yaml contents for thunderbird


          modular: false
            check: FileContents
          nvr_pkg: thunderbird-91.9.0-3.el8_5
             file: /usr/lib64/thunderbird/defaults/pref/all-redhat.js
          content: Rocky
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: thunderbird-91.9.0-3.el8_5.x86_64.rpm
       cache_path: /home/rocky/testing/rpms/thunderbird-91.9.0-3.el8_5.x86_64.rpm

535088 blocks


SUCCESS: FileContents found pattern.
```
