# Standalone System

**_NOTE: The dvd1 ISO must be downloaded and stored in the ./isos directory next to the ./scripts directory._**

```
[rocky@localhost testing]$ ./scripts/test_wrapper.sh
mkdir: created directory '/home/rocky/testing/output'
mkdir: created directory '/home/rocky/testing/output/2022-05-23'

================================================================================
abrt                gcc                    libreport             python-pip
anaconda            gcc-toolset-10-gcc     nginx                 redhat-rpm-config
anaconda-user-help  gcc-toolset-11-gcc     opa-ff                scap-security-guide
chrony              gcc-toolset-9-gcc      opa-fm                shim
cloud-init          gnome-boxes            openscap              shim-unsigned-aarch64
crash               gnome-settings-daemon  open-vm-tools         shim-unsigned-x64
dhcp                grub2                  oscap-anaconda-addon  sos
dnf                 initial-setup          PackageKit            subscription-manager
dotnet              kernel                 pcs                   systemd
dotnet3.0           kernel-rt              pesign                thunderbird
firefox             libdnf                 plymouth              WALinuxAgent
fwupd               libguestfs             python2
fwupdate            libreoffice            python3

================================================================================
Package Debrand Validation for x86_64 packages in Rocky-8.6-x86_64-dvd1.iso

================================================================================
General Processing Parameters

             type: dvd1
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

WARN: dvd1 media does not contain SRPMs, use koji or cache

================================================================================
cloud-init


       binary_pkg: cloud-init-21.1-15.el8.noarch.rpm

SUCCESS: FileContents found pattern.

================================================================================
crash

WARN: dvd1 media does not contain SRPMs, use koji or cache

================================================================================
dhcp

WARN: dvd1 media does not contain SRPMs, use koji or cache

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

WARN: dvd1 media does not contain SRPMs, use koji or cache

================================================================================
gnome-settings-daemon


       binary_pkg: gnome-settings-daemon-3.32.0-16.el8.x86_64.rpm
WARN: /tmp/tmp.ukWhLF8PuJ/etc/xdg/autostart/org.gnome.SettingsDaemon.Subscription.desktop does not exist, should you be using koji or cache?

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
cp: cannot stat '': No such file or directory
WARN: /tmp/tmp.vJSsPkh2FL/lib/modules/4.18.0-372.9.1.rt7.166.el8.x86_64/vmlinuz does not exist, should you be using koji or cache?

================================================================================
libdnf


       binary_pkg: libdnf-0.63.0-8.el8.x86_64.rpm

SUCCESS: BinaryStrings found pattern.

================================================================================
libguestfs

WARN: dvd1 media does not contain SRPMs, use koji or cache

================================================================================
libreoffice

WARN: dvd1 media does not contain SRPMs, use koji or cache

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

WARN: dvd1 media does not contain SRPMs, use koji or cache

================================================================================
opa-fm

WARN: dvd1 media does not contain SRPMs, use koji or cache

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

WARN: dvd1 media does not contain SRPMs, use koji or cache

================================================================================
pcs


       binary_pkg: pcs-0.10.12-6.el8.x86_64.rpm
cp: cannot stat '': No such file or directory
WARN: /tmp/tmp.GSQJAUxmvR/usr/lib64/pcsd/public/images/HAM-logo.png does not exist, should you be using koji or cache?

================================================================================
pesign


       binary_pkg: pesign-0.112-26.el8.x86_64.rpm

SUCCESS: FileContents found pattern.

================================================================================
plymouth

WARN: dvd1 media does not contain SRPMs, use koji or cache

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

WARN: dvd1 media does not contain SRPMs, use koji or cache

================================================================================
shim

WARN: dvd1 media does not contain SRPMs, use koji or cache

================================================================================
shim-unsigned-aarch64

WARN: dvd1 media does not contain SRPMs, use koji or cache

================================================================================
shim-unsigned-x64

WARN: dvd1 media does not contain SRPMs, use koji or cache

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

WARN: dvd1 media does not contain SRPMs, use koji or cache

================================================================================
thunderbird


       binary_pkg: thunderbird-91.9.0-3.el8_5.x86_64.rpm

SUCCESS: FileContents found pattern.
```
