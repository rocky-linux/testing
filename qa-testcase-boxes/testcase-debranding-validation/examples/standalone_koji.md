# Standalone System with Packages from Rocky Linux koji

When more specific tests are required the `debrand_validation.sh` script can be used directly.

The script supports many options from the command line...

```
[vagrant@localhost testing]$ ./scripts/debrand_validation.sh -h
Usage: debrand_validation.sh [-h] [-x] [-t minimal|dvd1|repo|koji|cache] [-a x86_64|aarch64|ppc64le|s390x] [-v 8.6|9.0|maj.min] [others... see -h] [package(s)]
Perform debranding analysis on PACKAGEs.

  -h                        provide this help
  -x                        enable extended output
  -t                        specify source for packages
                              minimal and dvd1 specify locally available ISO
                              media, repo and koji specify Internet package sources
                              and cache specifies local package cache. If/when
                              using repo or koji packages pulled from that location
                              will be store in the local package cache.
  -a                        specify architecture for packages
                              x86_64 and aarch64 are available pre 9 while
                              ppc64le and s390x will be added for Rocky Linux 9
  -v                        specify Rocky Linux version for ISOs
                              Typically 8.6 or 8 depending on the repository
  -p                        iso filename prefix
                              The standard prefix for Rocky Linux is 'Rocky' with
                              the full ISO name being derived as...
                              <prefix>-<version>-<arch>-<type>.iso. Thus,
                              with creative use of these variables packages on
                              other ISOs (eg. prefix='CentOS-Stream') can possible
                              be examined as well.
  -b                        repository baseurl
                              Allows definition of non-default repository baseurl
                              to support os of vault or staging repositories or
                              even closest mirrors
                              default='http://dl.rockylinux.org/pub/rocky/'
  -l                        output log directory
                              default location for logs is $(pwd)/output/$(date +%Y-%m-%d)
                              but a custom location for the base for logs can be
                              supplied.
  -r                        repository name(s)
                              default='baseos,appstream,extras,powertools' can
                              be overridden if/when working with a local repository
                              clone, for example of Peridot yumrepofs where this
                              might be... 'pdot-dev-x86_64'. Requires definition
                              of repo in /etc/yum.repos.d/<repofile>.repo
  -k                        koji tag
                              When koji is used for packages alternate koji tags
                              for package search may be used. default='dist-rocky8-compose'
  -c                        debrand yaml override
                              When debrand validation for a non-default version
                              is being performed a version specific YAML file
                              can be selected. default='r8'

```


## Run with koji download and extended output

```
[vagrant@localhost vagrant]$ ./scripts/debrand_validation.sh -x -t koji anaconda

================================================================================
Package Debrand Validation for x86_64 builds in koji

anaconda


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
```
