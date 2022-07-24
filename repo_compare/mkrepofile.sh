#!/bin/bash

# Simple script to produce valid Rocky + RHEL repos with nice names
# (so the repo compare html script can be run against them)
# 
# We assume we're running on a RHEL 8 box with a valid entitlement
# (and that /etc/yum.repos.d/redhat.repo exists)

RHREPOFILE='/etc/yum.repos.d/redhat.repo'

# what each RedHat main URL line should start with:
#RH8_URL_LINE="mirrorlist = https://rhui3.REGION.aws.ce.redhat.com/pulp/mirror/content/dist/rhel8/rhui/\$releasever/\$basearch"
RH8_URL_LINE="baseurl = https://cdn.redhat.com/content/dist/rhel8/8/\$basearch"
RH8_BETA_LINE="baseurl = https://cdn.redhat.com/content/beta/rhel8/8/\$basearch"
RH9_URL_LINE="baseurl = https://cdn.redhat.com/content/dist/rhel9/9/\$basearch"
RH9_BETA_LINE="baseurl = https://cdn.redhat.com/content/beta/rhel9/9/\$basearch"



# Get the proper cert/key files - these are rotated regularly, so we need them as variables:
cacert=$(grep 'sslcacert' ${RHREPOFILE} | head -1)
clientkey=$(grep 'sslclientkey' ${RHREPOFILE} | head -1)
clientcert=$(grep 'sslclientcert' ${RHREPOFILE} | head -1)


# Big giant echo to (re)create Rocky/RHEL repo file
cat > /etc/yum.repos.d/rocky_repocompare.repo << EOF
# Test Rocky repos for comparison

# RHEL 8 repos, with alternate names:
[RHEL8_BaseOS]
name = Red Hat Enterprise Linux 8 for x86_64 - BaseOS (RPMs)
${RH8_URL_LINE}/baseos/os
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1


[RHEL8_AppStream]
name = Red Hat Enterprise Linux 8 for x86_64 - AppStream (RPMs)
${RH8_URL_LINE}/appstream/os
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1



[RHEL8_CodeReady]
name = Red Hat CodeReady Linux Builder for RHEL 8 x86_64 (RPMs)
${RH8_URL_LINE}/codeready-builder/os
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1


[RHEL8_ResilientStorage]
name = Red Hat Enterprise Linux 8 for x86_64 - Resilient Storage (RPMs)
${RH8_URL_LINE}/resilientstorage/os
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 0


[RHEL8_HighAvailability]
name = Red Hat Enterprise Linux 8 for x86_64 - High Availability (RPMs)
${RH8_URL_LINE}/highavailability/os
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 0



# RHEL 8 Source repos:

[RHEL8_BaseOS_Source]
name = Red Hat Enterprise Linux 8 for x86_64 - BaseOS (Source RPMs)
${RH8_URL_LINE}/baseos/source/SRPMS
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1


[RHEL8_AppStream_Source]
name = Red Hat Enterprise Linux 8 for x86_64 - AppStream (Source RPMs)
${RH8_URL_LINE}/appstream/source/SRPMS
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1



[RHEL8_CodeReady_Source]
name = Red Hat CodeReady Linux Builder for RHEL 8 x86_64 (Source RPMs)
${RH8_URL_LINE}/codeready-builder/source/SRPMS
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1



[RHEL8_ResilientStorage_Source]
name = Red Hat Enterprise Linux 8 for x86_64 - Resilient Storage (Source RPMs)
${RH8_URL_LINE}/resilientstorage/source/SRPMS
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 0


[RHEL8_HighAvailability_Source]
name = Red Hat Enterprise Linux 8 for x86_64 - High Availability (Source RPMs)
${RH8_URL_LINE}/highavailability/source/SRPMS
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 0




# RHEL 9 repos, with alternate names:
[RHEL9_BaseOS]
name = Red Hat Enterprise Linux 9 for x86_64 - BaseOS (RPMs)
${RH9_URL_LINE}/baseos/os
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1


[RHEL9_AppStream]
name = Red Hat Enterprise Linux 9 for x86_64 - AppStream (RPMs)
${RH9_URL_LINE}/appstream/os
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1



[RHEL9_CodeReady]
name = Red Hat CodeReady Linux Builder for RHEL 9 x86_64 (RPMs)
${RH9_URL_LINE}/codeready-builder/os
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1


[RHEL9_ResilientStorage]
name = Red Hat Enterprise Linux 9 for x86_64 - Resilient Storage (RPMs)
${RH9_URL_LINE}/resilientstorage/os
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 0


[RHEL9_HighAvailability]
name = Red Hat Enterprise Linux 9 for x86_64 - High Availability (RPMs)
${RH9_URL_LINE}/highavailability/os
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 0


# RHEL 9 Source repos:

[RHEL9_BaseOS_Source]
name = Red Hat Enterprise Linux 9 for x86_64 - BaseOS (Source RPMs)
${RH9_URL_LINE}/baseos/source/SRPMS
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1


[RHEL9_AppStream_Source]
name = Red Hat Enterprise Linux 9 for x86_64 - AppStream (Source RPMs)
${RH9_URL_LINE}/appstream/source/SRPMS
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1



[RHEL9_CodeReady_Source]
name = Red Hat CodeReady Linux Builder for RHEL 9 x86_64 (Source RPMs)
${RH9_URL_LINE}/codeready-builder/source/SRPMS
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1






#########################################
# (end of RHEL Repos)



# Corresponding Rocky Repos:
[Rocky8_BaseOS]
name=Rocky8_BaseOS
baseurl=http://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_AppStream]
name=Rocky8_AppStream
baseurl=http://dl.rockylinux.org/pub/rocky/8/AppStream/x86_64/os/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_CodeReady]
name=Rocky8_CodeReady
baseurl=http://dl.rockylinux.org/pub/rocky/8/PowerTools/x86_64/os/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_ResilientStorage]
name=Rocky8_ResilientStorage
baseurl=https://dl.rockylinux.org/pub/rocky/8/ResilientStorage/x86_64/os/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_HighAvailability]
name=Rocky8_HighAvailability
baseurl=https://dl.rockylinux.org/pub/rocky/8/HighAvailability/x86_64/os/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial



# Rocky Staging repos:
[Rocky8_BaseOS_stg]
name=Rocky8_BaseOS_stg
baseurl=http://dl.rockylinux.org/stg/rocky/8/BaseOS/x86_64/os/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_AppStream_stg]
name=Rocky8_AppStream_stg
baseurl=http://dl.rockylinux.org/stg/rocky/8/AppStream/x86_64/os/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_CodeReady_stg]
name=Rocky8_CodeReady_stg
baseurl=http://dl.rockylinux.org/stg/rocky/8/PowerTools/x86_64/os/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_ResilientStorage_stg]
name=Rocky8_ResilientStorage_stg
baseurl=https://dl.rockylinux.org/stg/rocky/8/ResilientStorage/x86_64/os/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_HighAvailability_stg]
name=Rocky8_HighAvailability_stg
baseurl=https://dl.rockylinux.org/stg/rocky/8/HighAvailability/x86_64/os/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial





# Rocky 9 Staging repos:
[Rocky9_BaseOS_stg]
name=Rocky9_BaseOS_stg
baseurl=https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/BaseOS/x86_64/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky9_AppStream_stg]
name=Rocky9_AppStream_stg
baseurl=https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/AppStream/x86_64/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky9_CodeReady_stg]
name=Rocky9_CodeReady_stg
baseurl=https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/CRB/x86_64/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky9_ResilientStorage_stg]
name=Rocky9_ResilientStorage_stg
baseurl=https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/ResilientStorage/x86_64/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky9_HighAvailability_stg]
name=Rocky9_HighAvailability_stg
baseurl=https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/HighAvailability/x86_64/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial




# Rocky Source repos:

[Rocky8_BaseOS_Source]
name=Rocky8_BaseOS_Source
baseurl=http://dl.rockylinux.org/pub/rocky/8/BaseOS/source/tree/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_AppStream_Source]
name=Rocky8_AppStream_Source
baseurl=http://dl.rockylinux.org/pub/rocky/8/AppStream/source/tree/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_CodeReady_Source]
name=Rocky8_CodeReady_Source
baseurl=http://dl.rockylinux.org/pub/rocky/8/PowerTools/source/tree/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_ResilientStorage_Source]
name=Rocky8_ResilientStorage_Source
baseurl=https://dl.rockylinux.org/pub/rocky/8/ResilientStorage/source/tree/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_HighAvailability_Source]
name=Rocky8_HighAvailability_Source
baseurl=https://dl.rockylinux.org/pub/rocky/8/HighAvailability/source/tree/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial




# Rocky Staging sources:

[Rocky8_BaseOS_Source_stg]
name=Rocky8_BaseOS_Source_Staging
baseurl=http://dl.rockylinux.org/stg/rocky/8/BaseOS/source/tree/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_AppStream_Source_stg]
name=Rocky8_AppStream_Source_Staging
baseurl=http://dl.rockylinux.org/stg/rocky/8/AppStream/source/tree/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_CodeReady_Source_stg]
name=Rocky8_CodeReady_Source_Staging
baseurl=http://dl.rockylinux.org/stg/rocky/8/PowerTools/source/tree/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_ResilientStorage_Source_stg]
name=Rocky8_ResilientStorage_Source_Staging
baseurl=https://dl.rockylinux.org/stg/rocky/8/ResilientStorage/source/tree/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky8_HighAvailability_Source_stg]
name=Rocky8_HighAvailability_Source_Staging
baseurl=https://dl.rockylinux.org/stg/rocky/8/HighAvailability/source/tree/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial



# Rocky 9 Staging sources:

[Rocky9_BaseOS_Source_stg]
name=Rocky9_BaseOS_Source_Staging
baseurl=https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/BaseOS/src/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky9_AppStream_Source_stg]
name=Rocky9_AppStream_Source_Staging
baseurl=https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/AppStream/src/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky9_CodeReady_Source_stg]
name=Rocky9_CodeReady_Source_Staging
baseurl=https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/CRB/src/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky9_ResilientStorage_Source_stg]
name=Rocky9_ResilientStorage_Source_Staging
baseurl=https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/ResilientStorage/src/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


[Rocky9_HighAvailability_Source_stg]
name=Rocky9_HighAvailability_Source_Staging
baseurl=https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/HighAvailability/src/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial


EOF



cat > /etc/yum.repos.d/rhel8_beta.repo << EOF
# RHEL 8 Beta Repos

[RHEL8_Beta_BaseOS]
name = Red Hat Enterprise Linux 8 for x86_64 - BaseOS (RPMs) (BETA)
${RH8_BETA_LINE}/baseos/os
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1


[RHEL8_Beta_AppStream]
name = Red Hat Enterprise Linux 8 for x86_64 - AppStream (RPMs) (BETA)
${RH8_BETA_LINE}/appstream/os
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1



[RHEL8_Beta_CodeReady]
name = Red Hat CodeReady Linux Builder for RHEL 8 x86_64 (RPMs) (BETA)
${RH8_BETA_LINE}/codeready-builder/os
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1


[RHEL8_Beta_ResilientStorage]
name = Red Hat Enterprise Linux 8 for x86_64 - Resilient Storage (RPMs) (BETA)
${RH8_BETA_LINE}/resilientstorage/os
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 0


[RHEL8_Beta_HighAvailability]
name = Red Hat Enterprise Linux 8 for x86_64 - High Availability (RPMs) (BETA)
${RH8_BETA_LINE}/highavailability/os
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 0



# RHEL 8 Source repos:

[RHEL8_Beta_BaseOS_Source]
name = Red Hat Enterprise Linux 8 for x86_64 - BaseOS (Source RPMs) (BETA)
${RH8_BETA_LINE}/baseos/source/SRPMS
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1


[RHEL8_Beta_AppStream_Source]
name = Red Hat Enterprise Linux 8 for x86_64 - AppStream (Source RPMs) (BETA)
${RH8_BETA_LINE}/appstream/source/SRPMS
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1



[RHEL8_Beta_CodeReady_Source]
name = Red Hat CodeReady Linux Builder for RHEL 8 x86_64 (Source RPMs) (BETA)
${RH8_BETA_LINE}/codeready-builder/source/SRPMS
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 1



[RHEL8_Beta_ResilientStorage_Source]
name = Red Hat Enterprise Linux 8 for x86_64 - Resilient Storage (Source RPMs) (BETA)
${RH8_BETA_LINE}/resilientstorage/source/SRPMS
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 0


[RHEL8_Beta_HighAvailability_Source]
name = Red Hat Enterprise Linux 8 for x86_64 - High Availability (Source RPMs) (BETA)
${RH8_BETA_LINE}/highavailability/source/SRPMS
enabled = 0
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
sslverify = 1
$cacert
$clientkey
$clientcert
metadata_expire = 86400
enabled_metadata = 0

EOF
