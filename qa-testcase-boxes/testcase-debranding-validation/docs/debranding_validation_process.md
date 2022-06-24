# QA:Debranding Validation Process

## Scope

The purpose of debranding validation is to verify that debranding has been applied to specific packages identified by Release Engineering as requiring debranding prior to release to the community.

Debranding validation shall be able to be performed against packages available in any official repository or distributed on any released media for any supported arch.

Current methods for direct validation are...

1. `PackageRequires` - examine package metadata to verify requires match expectations
2. `BinaryStrings` - examine binary file for specific strings
4. `FileContents` - examine text file for specific contents
4. `FileChecksum` - examine binary or text file for specific checksum
5. `FileExists` - detect presence of specific file in package contents

If the criteria for the debranding validation are satisfied the package will be certified as debranded.

## Workflow

```
             Is pkg on debrand list?   -----> NOOP
                        |                no
                    yes |
                        V
        Get specific nvra or src pkg for pkg
                        |
                        V
        nvra or src pkg contents debranded?  -----> FAIL
                        |                      no
                    yes |
                        V
                     SUCCESS
```


## Debrand YAML (portion only)

```yaml
---
  "r8":
    "dotnet":
      modular: false
      check: FileContents
      nvr_pkg: dotnet-runtime-2.1-2.1.30-1.el8_4.rocky
      file: /usr/lib64/dotnet/shared/Microsoft.NETCore.App/2.1.30/Microsoft.NETCore.App.deps.json
      content: runtime.rocky
      value: true
      pkg_arch:
      source:
  "libguestfs":
    modular: true
    check: FileContents
    nvr_pkg: libguestfs-1.44.0-5.module+el8.6.0+847+b490afdd.rocky
    file: 0001-Add-ROCKY-to-list-of-REDHAT-distros.patch
    content: ROCKY
    value: true
    pkg_arch: src
    source: koji
```


## Sample Output

The following is completed with packages on the debrand list built for Rocky Linux 8.6 and pulled directly from Rocky koji. Aside from anaconda-core package the remaining packages had already been pulled and were locally cached.

```
[rocky@localhost testing]$ ./scripts/debrand_validation.sh -x -t koji anaconda cloud-init dnf fwupd

================================================================================
Package Debrand Validation for x86_64 builds in koji

anaconda	cloud-init	dnf		fwupd


================================================================================
General Processing Parameters

             type: koji
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
         koji_pkg: anaconda-core-33.16.6.7-1.el8.rocky.0.4.x86_64.rpm

Downloading: anaconda-core-33.16.6.7-1.el8.rocky.0.4.x86_64.rpm
[====================================] 100% 2.43 MiB / 2.43 MiB

       cache_path: /home/rocky/testing/rpms/anaconda-core-33.16.6.7-1.el8.rocky.0.4.x86_64.rpm

23009 blocks


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
         koji_pkg: .rpm

2022-05-26 15:29:03,944 [ERROR] koji: GenericError: invalid format:

       cache_path: /home/rocky/testing/rpms/cloud-init-21.1-15.el8.noarch.rpm

7278 blocks


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
         koji_pkg: python3-dnf-4.7.0-8.el8.noarch.rpm

Downloading: python3-dnf-4.7.0-8.el8.noarch.rpm
File python3-dnf-4.7.0-8.el8.noarch.rpm already downloaded, skipping

       cache_path: /home/rocky/testing/rpms/python3-dnf-4.7.0-8.el8.noarch.rpm

3816 blocks


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
         koji_pkg: fwupd-1.7.4-2.el8.x86_64.rpm

2022-05-26 15:29:06,951 [ERROR] koji: PermissionError: [Errno 13] Permission denied: 'fwupd-1.7.4-2.el8.x86_64.rpm'
Downloading: fwupd-1.7.4-2.el8.x86_64.rpm

       cache_path: /home/rocky/testing/rpms/fwupd-1.7.4-2.el8.x86_64.rpm

17009 blocks


SUCCESS: BinaryStrings found pattern.
```
