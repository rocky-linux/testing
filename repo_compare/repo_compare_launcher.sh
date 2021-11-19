#!/bin/bash
# Big giant script that launches everything in sequence:

SCRIPTSDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"


# Pre-run: Make repo file, clean metadata, make folders
"${SCRIPTSDIR}"/mkrepofile.sh
yum clean all
yum makecache

now=$(date +%Y%m%d_%H)
export now


# RepoCompare 1:  "Normal" BaseOS/AppStream/PowerTools RHEL vs. Rocky
mkdir -p /root/pkgcompare/repo_compare
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_BaseOS   Rocky8_BaseOS  > /root/pkgcompare/repo_compare/RHEL_Rocky_BaseOS_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_AppStream   Rocky8_AppStream  > /root/pkgcompare/repo_compare/RHEL_Rocky_AppStream_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh RHEL8_CodeReady   Rocky8_PowerTools  > /root/pkgcompare/repo_compare/RHEL_Rocky_PowerTools_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh RHEL8_ResilientStorage   Rocky8_ResilientStorage  > /root/pkgcompare/repo_compare/RHEL_Rocky_ResilientStorage_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh RHEL8_HighAvailability   Rocky8_HighAvailability  > /root/pkgcompare/repo_compare/RHEL_Rocky_HighAvailability_"${now}".html
cp -f  /root/pkgcompare/repo_compare/RHEL_Rocky_BaseOS_"${now}".html  /root/pkgcompare/repo_compare/RHEL_Rocky_BaseOS.html
cp -f  /root/pkgcompare/repo_compare/RHEL_Rocky_AppStream_"${now}".html  /root/pkgcompare/repo_compare/RHEL_Rocky_AppStream.html
cp -f  /root/pkgcompare/repo_compare/RHEL_Rocky_PowerTools_"${now}".html  /root/pkgcompare/repo_compare/RHEL_Rocky_PowerTools.html
cp -f  /root/pkgcompare/repo_compare/RHEL_Rocky_ResilientStorage_"${now}".html  /root/pkgcompare/repo_compare/RHEL_Rocky_ResilientStorage.html
cp -f  /root/pkgcompare/repo_compare/RHEL_Rocky_HighAvailability_"${now}".html  /root/pkgcompare/repo_compare/RHEL_Rocky_HighAvailability.html



# RepoCompare 2: RHEL 8 vs. Rocky 8 Staging repos:
mkdir -p /root/pkgcompare/repo_compare_stg
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_BaseOS   Rocky8_BaseOS_stg  > /root/pkgcompare/repo_compare_stg/RHEL_Rocky_BaseOS_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_AppStream   Rocky8_AppStream_stg  > /root/pkgcompare/repo_compare_stg/RHEL_Rocky_AppStream_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_CodeReady   Rocky8_PowerTools_stg  > /root/pkgcompare/repo_compare_stg/RHEL_Rocky_PowerTools_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh RHEL8_ResilientStorage   Rocky8_ResilientStorage_stg  > /root/pkgcompare/repo_compare_stg/RHEL_Rocky_ResilientStorage_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh RHEL8_HighAvailability   Rocky8_HighAvailability_stg  > /root/pkgcompare/repo_compare_stg/RHEL_Rocky_HighAvailability_stg_"${now}".html
cp -f  /root/pkgcompare/repo_compare_stg/RHEL_Rocky_BaseOS_stg_"${now}".html  /root/pkgcompare/repo_compare_stg/RHEL_Rocky_BaseOS_stg.html
cp -f  /root/pkgcompare/repo_compare_stg/RHEL_Rocky_AppStream_stg_"${now}".html  /root/pkgcompare/repo_compare_stg/RHEL_Rocky_AppStream_stg.html
cp -f  /root/pkgcompare/repo_compare_stg/RHEL_Rocky_PowerTools_stg_"${now}".html  /root/pkgcompare/repo_compare_stg/RHEL_Rocky_PowerTools_stg.html
cp -f  /root/pkgcompare/repo_compare_stg/RHEL_Rocky_ResilientStorage_stg_"${now}".html  /root/pkgcompare/repo_compare_stg/RHEL_Rocky_ResilientStorage_stg.html
cp -f  /root/pkgcompare/repo_compare_stg/RHEL_Rocky_HighAvailability_stg_"${now}".html  /root/pkgcompare/repo_compare_stg/RHEL_Rocky_HighAvailability_stg.html


# RepoCompare 3: RHEL 8 Beta vs. Rocky 8 Staging repos:
mkdir -p /root/pkgcompare/beta_repo_compare_stg
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_Beta_BaseOS   Rocky8_BaseOS_stg  > /root/pkgcompare/beta_repo_compare_stg/Beta_RHEL_Rocky_BaseOS_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_Beta_AppStream   Rocky8_AppStream_stg  > /root/pkgcompare/beta_repo_compare_stg/Beta_RHEL_Rocky_AppStream_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_Beta_CodeReady   Rocky8_PowerTools_stg  > /root/pkgcompare/beta_repo_compare_stg/Beta_RHEL_Rocky_PowerTools_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh RHEL8_Beta_ResilientStorage   Rocky8_ResilientStorage_stg  > /root/pkgcompare/beta_repo_compare_stg/Beta_RHEL_Rocky_ResilientStorage_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh RHEL8_Beta_HighAvailability   Rocky8_HighAvailability_stg  > /root/pkgcompare/beta_repo_compare_stg/Beta_RHEL_Rocky_HighAvailability_stg_"${now}".html
cp -f  /root/pkgcompare/beta_repo_compare_stg/Beta_RHEL_Rocky_BaseOS_stg_"${now}".html  /root/pkgcompare/beta_repo_compare_stg/Beta_RHEL_Rocky_BaseOS_stg.html
cp -f  /root/pkgcompare/beta_repo_compare_stg/Beta_RHEL_Rocky_AppStream_stg_"${now}".html  /root/pkgcompare/beta_repo_compare_stg/Beta_RHEL_Rocky_AppStream_stg.html
cp -f  /root/pkgcompare/beta_repo_compare_stg/Beta_RHEL_Rocky_PowerTools_stg_"${now}".html  /root/pkgcompare/beta_repo_compare_stg/Beta_RHEL_Rocky_PowerTools_stg.html
cp -f  /root/pkgcompare/beta_repo_compare_stg/Beta_RHEL_Rocky_ResilientStorage_stg_"${now}".html  /root/pkgcompare/beta_repo_compare_stg/Beta_RHEL_Rocky_ResilientStorage_stg.html
cp -f  /root/pkgcompare/beta_repo_compare_stg/Beta_RHEL_Rocky_HighAvailability_stg_"${now}".html  /root/pkgcompare/beta_repo_compare_stg/Beta_RHEL_Rocky_HighAvailability_stg.html





# RepoCompare Source 1: RHEL 8 Sources vs. Rocky 8 Sources (production repo):
mkdir -p /root/pkgcompare/source_compare
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_BaseOS_Source  Rocky8_BaseOS_Source   >  /root/pkgcompare/source_compare/RHEL_Rocky_BaseOS_src_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_AppStream_Source  Rocky8_AppStream_Source   >  /root/pkgcompare/source_compare/RHEL_Rocky_AppStream_src_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_CodeReady_Source  Rocky8_PowerTools_Source   >  /root/pkgcompare/source_compare/RHEL_Rocky_PowerTools_src_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh RHEL8_ResilientStorage_Source   Rocky8_ResilientStorage_Source  > /root/pkgcompare/source_compare/RHEL_Rocky_ResilientStorage_src_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh RHEL8_HighAvailability_Source   Rocky8_HighAvailability_Source  > /root/pkgcompare/source_compare/RHEL_Rocky_HighAvailability_src_"${now}".html
cp -f  /root/pkgcompare/source_compare/RHEL_Rocky_BaseOS_src_"${now}".html   /root/pkgcompare/source_compare/RHEL_Rocky_BaseOS_src.html
cp -f  /root/pkgcompare/source_compare/RHEL_Rocky_AppStream_src_"${now}".html  /root/pkgcompare/source_compare/RHEL_Rocky_AppStream_src.html
cp -f  /root/pkgcompare/source_compare/RHEL_Rocky_PowerTools_src_"${now}".html  /root/pkgcompare/source_compare/RHEL_Rocky_PowerTools_src.html
cp -f  /root/pkgcompare/source_compare/RHEL_Rocky_ResilientStorage_src_"${now}".html  /root/pkgcompare/source_compare/RHEL_Rocky_ResilientStorage_src.html
cp -f  /root/pkgcompare/source_compare/RHEL_Rocky_HighAvailability_src_"${now}".html  /root/pkgcompare/source_compare/RHEL_Rocky_HighAvailability_src.html



# RepoCompare Source 2:  RHEL 8 Sources vs. Rocky 8 Sources (staging repo):
mkdir -p /root/pkgcompare/source_compare_stg
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_BaseOS_Source  Rocky8_BaseOS_Source_stg   >  /root/pkgcompare/source_compare_stg/RHEL_Rocky_BaseOS_src_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_AppStream_Source   Rocky8_AppStream_Source_stg   >  /root/pkgcompare/source_compare_stg/RHEL_Rocky_AppStream_src_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_CodeReady_Source   Rocky8_PowerTools_Source_stg   >  /root/pkgcompare/source_compare_stg/RHEL_Rocky_PowerTools_src_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh RHEL8_ResilientStorage_Source   Rocky8_ResilientStorage_Source_stg  > /root/pkgcompare/source_compare_stg/RHEL_Rocky_ResilientStorage_src_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh RHEL8_HighAvailability_Source   Rocky8_HighAvailability_Source_stg  > /root/pkgcompare/source_compare_stg/RHEL_Rocky_HighAvailability_src_stg_"${now}".html
cp -f  /root/pkgcompare/source_compare_stg/RHEL_Rocky_BaseOS_src_stg_"${now}".html   /root/pkgcompare/source_compare_stg/RHEL_Rocky_BaseOS_src_stg.html
cp -f  /root/pkgcompare/source_compare_stg/RHEL_Rocky_AppStream_src_stg_"${now}".html  /root/pkgcompare/source_compare_stg/RHEL_Rocky_AppStream_src_stg.html
cp -f  /root/pkgcompare/source_compare_stg/RHEL_Rocky_PowerTools_src_stg_"${now}".html  /root/pkgcompare/source_compare_stg/RHEL_Rocky_PowerTools_src_stg.html
cp -f  /root/pkgcompare/source_compare_stg/RHEL_Rocky_ResilientStorage_src_stg_"${now}".html  /root/pkgcompare/source_compare_stg/RHEL_Rocky_ResilientStorage_src_stg.html
cp -f  /root/pkgcompare/source_compare_stg/RHEL_Rocky_HighAvailability_src_stg_"${now}".html  /root/pkgcompare/source_compare_stg/RHEL_Rocky_HighAvailability_src_stg.html



# RepoCompare Source 3: RHEL 8 Beta Sources vs. Rocky 8 Staging sources
mkdir -p /root/pkgcompare/beta_source_compare_stg
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_Beta_BaseOS_Source  Rocky8_BaseOS_Source_stg   >  /root/pkgcompare/beta_source_compare_stg/Beta_RHEL_Rocky_BaseOS_src_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_Beta_AppStream_Source   Rocky8_AppStream_Source_stg   >  /root/pkgcompare/beta_source_compare_stg/Beta_RHEL_Rocky_AppStream_src_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh  RHEL8_Beta_CodeReady_Source   Rocky8_PowerTools_Source_stg   >  /root/pkgcompare/beta_source_compare_stg/Beta_RHEL_Rocky_PowerTools_src_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh RHEL8_Beta_ResilientStorage_Source   Rocky8_ResilientStorage_Source_stg  > /root/pkgcompare/beta_source_compare_stg/Beta_RHEL_Rocky_ResilientStorage_src_stg_"${now}".html
"${SCRIPTSDIR}"/repo_compare_html.sh RHEL8_Beta_HighAvailability_Source   Rocky8_HighAvailability_Source_stg  > /root/pkgcompare/beta_source_compare_stg/Beta_RHEL_Rocky_HighAvailability_src_stg_"${now}".html
cp -f  /root/pkgcompare/beta_source_compare_stg/Beta_RHEL_Rocky_BaseOS_src_stg_"${now}".html   /root/pkgcompare/beta_source_compare_stg/Beta_RHEL_Rocky_BaseOS_src_stg.html
cp -f  /root/pkgcompare/beta_source_compare_stg/Beta_RHEL_Rocky_AppStream_src_stg_"${now}".html  /root/pkgcompare/beta_source_compare_stg/Beta_RHEL_Rocky_AppStream_src_stg.html
cp -f  /root/pkgcompare/beta_source_compare_stg/Beta_RHEL_Rocky_PowerTools_src_stg_"${now}".html  /root/pkgcompare/beta_source_compare_stg/Beta_RHEL_Rocky_PowerTools_src_stg.html
cp -f  /root/pkgcompare/beta_source_compare_stg/Beta_RHEL_Rocky_ResilientStorage_src_stg_"${now}".html  /root/pkgcompare/beta_source_compare_stg/Beta_RHEL_Rocky_ResilientStorage_src_stg.html
cp -f  /root/pkgcompare/beta_source_compare_stg/Beta_RHEL_Rocky_HighAvailability_src_stg_"${now}".html  /root/pkgcompare/beta_source_compare_stg/Beta_RHEL_Rocky_HighAvailability_src_stg.html



# Module Compare 1: RHEL 8 vs. Rocky 8 production:
mkdir -p /root/pkgcompare/module_compare
"${SCRIPTSDIR}"/module_compare_html.sh RHEL8_AppStream,RHEL8_CodeReady   Rocky8_AppStream,Rocky8_PowerTools  > /root/pkgcompare/module_compare/module_compare_"${now}".html
cp  -f  /root/pkgcompare/module_compare/module_compare_"${now}".html   /root/pkgcompare/module_compare/module_compare.html



# Module Compare 2: RHEL 8 vs. Rocky 8 staging: 
mkdir -p /root/pkgcompare/module_compare_stg
"${SCRIPTSDIR}"/module_compare_html.sh RHEL8_AppStream,RHEL8_CodeReady   Rocky8_AppStream_stg,Rocky8_PowerTools_stg  > /root/pkgcompare/module_compare_stg/module_compare_stg_"${now}".html
cp  -f  /root/pkgcompare/module_compare_stg/module_compare_stg_"${now}".html   /root/pkgcompare/module_compare_stg/module_compare_stg.html


# Module Compare 3: RHEL 8 Beta vs. Rocky 8 staging: 
mkdir -p /root/pkgcompare/beta_module_compare_stg
"${SCRIPTSDIR}"/module_compare_html.sh RHEL8_Beta_AppStream,RHEL8_Beta_CodeReady   Rocky8_AppStream_stg,Rocky8_PowerTools_stg  > /root/pkgcompare/beta_module_compare_stg/beta_module_compare_stg_"${now}".html
cp  -f  /root/pkgcompare/beta_module_compare_stg/beta_module_compare_stg_"${now}".html   /root/pkgcompare/beta_module_compare_stg/beta_module_compare_stg.html

