# Updating debranding configuration

The first builds of packages for Rocky Linux 9 were occuring while these scripts and configuraiton were being developed. As a result some of the debranding configuration either does not exist or needs to be updated before final debranding validation can occur.

This example will show the basic workflow for updating debranding configuration.


## Package debrand configuration

Use `yq` to extract a specific debranding configuration block from the debranding configuration YAML file for the specific release. For this example we'll update the debranding configuration for the `anaconda` package for Rocky Linux 9.

```
[vagrant@localhost vagrant]$ yq '.all.anaconda' < r9.yaml
null
---
modular: false
check: FileContents
nvr_pkg: anaconda-core-34.25.0.29-1.el9_0.rocky.0.1
file: /etc/anaconda/product.d/rocky.conf
content: rocky_help_placeholder.xml
value: true
pkg_arch:
source:
```

The above configuration says that debranding for the `anaconda` package will be performed by looking for specific content (`content: rocky_help_placeholder.xml`) inside a specific file (`file: /etc/anaconda/product.d/rocky.conf`) that is installed by the `anaconda-core` binary package using logic coded in the script `./scripts/debrand_validation.sh` (`check: FileContents`)/

You should also notice that specific NVR for the `ananconda-core` package is configured. This is currently required and means that the debranding configuration YAML must be updated each time the version or release of the package is updated.


## Download package from Peridot

It's likely that debranding validation for Rocky Linux 9 will be most efficient from local cache or a configured yumrepofs repository clone from Peridot prior to the release of the final DVD ISO.

In this example we will the cache method after downloading packages from Peridot.

```
[vagrant@localhost vagrant]$ ./scripts/debrand_validation.sh -t cache -r 9 -v 9.0 anaconda

================================================================================
Package Debrand Validation for x86_64 packages in local package cache

================================================================================
General Processing Parameters

             type: cache
          version: 9.0
             arch: x86_64

================================================================================
anaconda

       binary_pkg: anaconda-core-34.25.0.29-1.el9_0.rocky.0.1.x86_64.rpm
WARN: /tmp/tmp.ItnosEWoLS//etc/anaconda/product.d/rocky.conf does not exist, should you be using koji or cache?

[vagrant@localhost vagrant]$ find rpms/ -name anaconda-core-34.25.0.29-1.el9_0.rocky.0.1.x86_64.rpm
[vagrant@localhost vagrant]$
```

This output indicates that the specified `anaconda-core` package is not found in the local package cache.


### Check Peridot yumrepofs for the binary package

A utility script and configuration is provided in this repository to allow simple query of Peridot for packages it has already built and uploaded to the yumrepofs.

**_NOTE: In the following examples any repository metadata errors have been removed from the output._**

```
[vagrant@localhost vagrant]$ ./scripts/peridot_repo_query.sh anaconda-core
# dnf --forcearch=x86_64 --repofrompath=pdot-x86_64,https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64 --repo=pdot-x86_64 search anaconda-core
Added pdot-x86_64 repo from https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64
Last metadata expiration check: 1:23:05 ago on Mon 30 May 2022 06:09:08 PM UTC.

anaconda-core.x86_64 : Core of the Anaconda installer
# set +x
```


### Check Peridot yumrepofs for package information

```
[vagrant@localhost vagrant]$ DNF_COMMAND=info ./scripts/peridot_repo_query.sh anaconda-core
# dnf --forcearch=x86_64 --repofrompath=pdot-x86_64,https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64 --repo=pdot-x86_64 info anaconda-core
Added pdot-x86_64 repo from https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64
Last metadata expiration check: 1:23:54 ago on Mon 30 May 2022 06:09:08 PM UTC.

Available Packages
Name         : anaconda-core
Version      : 34.25.0.29
Release      : 1.el9_0.rocky.0.1
Architecture : x86_64
Size         : 2.2 M
Source       : anaconda-34.25.0.29-1.el9_0.rocky.0.1.src.rpm
Repository   : pdot-x86_64
Summary      : Core of the Anaconda installer
URL          : http://fedoraproject.org/wiki/Anaconda
License      : GPLv2+ and MIT
Description  : The anaconda-core package contains the program which was used to install your
             : system.

# set +x
```

### Download package and deposit in cache

```
[vagrant@localhost vagrant]$ DNF_COMMAND=download ./scripts/peridot_repo_query.sh anaconda-core
# dnf --forcearch=x86_64 --repofrompath=pdot-x86_64,https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64 --repo=pdot-x86_64 download anaconda-core
Added pdot-x86_64 repo from https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64
Last metadata expiration check: 1:27:53 ago on Mon 30 May 2022 06:09:08 PM UTC.

anaconda-core-34.25.0.29-1.el9_0.rocky.0.1.x86_64.rpm                                                                        1.2 MB/s | 2.2 MB     00:01
# set +x

[vagrant@localhost vagrant]$ mv anaconda-core-34.25.0.29-1.el9_0.rocky.0.1.x86_64.rpm rpms/
```


## Run debrand validation

```
[vagrant@localhost vagrant]$ ./scripts/debrand_validation.sh -t cache -r 9 -v 9.0 anaconda

================================================================================
Package Debrand Validation for x86_64 packages in local package cache

================================================================================
General Processing Parameters

             type: cache
          version: 9.0
             arch: x86_64

================================================================================
anaconda

       binary_pkg: anaconda-core-34.25.0.29-1.el9_0.rocky.0.1.x86_64.rpm
FAIL: /etc/anaconda/product.d/rocky.conf does not contain pattern.
```

## Debrand validation configuration updated

This debranding **FAIL** is typical and needs to be investigated. The Rocky Linux debranding sources for the `anaconda` package must be manually checked. It's possible that the file that is being checked no longer contains the pattern that is being searched for and this may be expected as debranding patches can be updated over time.

Debranding patches for Rocky Linux packages are generally found at...

-   `https://git.rockylinux.org/staging/patch/[source_package_name]/-/tree/[release_branch]`

The specific debranding patches for the `anaconda` package for Rocky Linux 9 are [here](https://git.rockylinux.org/staging/patch/anaconda/-/tree/r9).


### Update debranding configuration

Examination of the debranding patches for the `anaconda` source will allow us to identify a candidate that is both easy to find and not likely to change with updates to the package. When such a patch / modification has been found the debranding configuration can be changed and the validation re-run.


#### Modify debranding configuration

```
[vagrant@localhost vagrant]$ git diff r9.yaml
diff --git a/qa-testcase-boxes/testcase-debranding-validation/r9.yaml b/qa-testcase-boxes/testcase-debranding-validation/r9.yaml
index f0cd470..b735f82 100644
--- a/qa-testcase-boxes/testcase-debranding-validation/r9.yaml
+++ b/qa-testcase-boxes/testcase-debranding-validation/r9.yaml
@@ -24,8 +24,8 @@
     modular: false
     check: FileContents
     nvr_pkg: anaconda-core-34.25.0.29-1.el9_0.rocky.0.1
-    file: /etc/anaconda/product.d/rocky.conf
-    content: rocky_help_placeholder.xml
+    file: /usr/lib64/python3.9/site-packages/pyanaconda/core/constants.py
+    content: Rocky Linux
     value: true
     pkg_arch:
     source:
```

#### Verify debranding configuration

```
[vagrant@localhost vagrant]$ yq '.all.anaconda' < r9.yaml
null
---
modular: false
check: FileContents
nvr_pkg: anaconda-core-34.25.0.29-1.el9_0.rocky.0.1
file: /usr/lib64/python3.9/site-packages/pyanaconda/core/constants.py
content: Rocky Linux
value: true
pkg_arch:
source:
```


#### Rerun debranding validation

```
[vagrant@localhost vagrant]$ ./scripts/debrand_validation.sh -t cache -r 9 -v 9.0 anaconda

================================================================================
Package Debrand Validation for x86_64 packages in local package cache

================================================================================
General Processing Parameters

             type: cache
          version: 9.0
             arch: x86_64

================================================================================
anaconda

       binary_pkg: anaconda-core-34.25.0.29-1.el9_0.rocky.0.1.x86_64.rpm

SUCCESS: FileContents found pattern.
```

#### Rerun debranding validation (extended output)

```
[vagrant@localhost vagrant]$ ./scripts/debrand_validation.sh -x -t cache -r 9 -v 9.0 anaconda

================================================================================
Package Debrand Validation for x86_64 packages in local package cache

anaconda


================================================================================
General Processing Parameters

             type: cache
          version: 9.0
             arch: x86_64
          baseurl: http://dl.rockylinux.org/pub/rocky
      iso_baseurl: http://dl.rockylinux.org/pub/rocky/8.6/isos
       iso_prefix: Rocky
       repo_names: baseos,appstream,powertools,extras
         koji_tag: dist-rocky8-compose
        rocky_rel: 9
          log_dir: /vagrant/output/2022-05-30
  log_file_suffix: debrand_validation.out
         extended: 1
       script_dir: /vagrant/scripts
    rpm_cache_dir: /vagrant/rpms

================================================================================
anaconda

r9.yaml contents for anaconda

          modular: false
            check: FileContents
          nvr_pkg: anaconda-core-34.25.0.29-1.el9_0.rocky.0.1
             file: /usr/lib64/python3.9/site-packages/pyanaconda/core/constants.py
          content: Rocky Linux
            value: true
         pkg_arch: x86_64
           source: na

       binary_pkg: anaconda-core-34.25.0.29-1.el9_0.rocky.0.1.x86_64.rpm
       cache_path: /vagrant/rpms/anaconda-core-34.25.0.29-1.el9_0.rocky.0.1.x86_64.rpm

23950 blocks


SUCCESS: FileContents found pattern.
```
