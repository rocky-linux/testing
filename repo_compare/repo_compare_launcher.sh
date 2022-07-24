#!/bin/bash
# Big giant script that launches everything in sequence:


# Where this script is being called from (and we assume our compare scripts are located)
SCRIPTSDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"


# Pre-run: Make repo file, clean metadata, make folders
"${SCRIPTSDIR}"/mkrepofile.sh
yum clean all
yum makecache

now=$(date +%Y%m%d_%H)
export now

RESULTSDIR="/opt/repocompare_results"

mkdir -p "${RESULTSDIR}"


for version in "8" "9"; do
  for rockyStage in "" "_stg"; do
    for rhelBeta in "" "_Beta"; do
      for sourceFlag in "" "_Source"; do
        for repo in "BaseOS" "AppStream" "CodeReady" "HighAvailability" "ResilientStorage"; do
          >&2 echo "Now running compare for:  ${RESULTSDIR}/RHEL${version}${rhelBeta}_Rocky${version}_${repo}${sourceFlag}${rockyStage}_${now}.html"
          "${SCRIPTSDIR}"/mkrepofile.sh
          "${SCRIPTSDIR}"/repo_compare_html.sh  "RHEL${version}${rhelBeta}_${repo}${sourceFlag}"  "Rocky${version}_${repo}${sourceFlag}${rockyStage}"  >  "${RESULTSDIR}/RHEL${version}${rhelBeta}_Rocky${version}_${repo}${sourceFlag}${rockyStage}_${now}.html"
	  
      	  # Copy the timestamped html file to the "standard" one - removing the "_$now" timestamp at the end:
      	  cp -f "${RESULTSDIR}/RHEL${version}${rhelBeta}_Rocky${version}_${repo}${sourceFlag}${rockyStage}_${now}.html"  "${RESULTSDIR}/RHEL${version}${rhelBeta}_Rocky${version}_${repo}${sourceFlag}${rockyStage}.html"
	  
        done
      done
    done
  done
done



# Module Compare 1: RHEL 8 vs. Rocky 8 production:
"${SCRIPTSDIR}"/mkrepofile.sh
"${SCRIPTSDIR}"/module_compare_html.sh RHEL8_AppStream,RHEL8_CodeReady   Rocky8_AppStream,Rocky8_PowerTools  > "${RESULTSDIR}/RHEL8_Rocky8_Modules_${now}.html" 
cp  -f  "${RESULTSDIR}/RHEL8_Rocky8_Modules_${now}.html"   "${RESULTSDIR}/RHEL8_Rocky8_Modules.html"



# Module Compare 2: RHEL 8 vs. Rocky 8 staging: 
"${SCRIPTSDIR}"/mkrepofile.sh
"${SCRIPTSDIR}"/module_compare_html.sh RHEL8_AppStream,RHEL8_CodeReady   Rocky8_AppStream_stg,Rocky8_PowerTools_stg  > "${RESULTSDIR}/RHEL8_Rocky8_Modules_stg_${now}.html"
cp  -f  "${RESULTSDIR}/RHEL8_Rocky8_Modules_stg_${now}.html"  "${RESULTSDIR}/RHEL8_Rocky8_Modules_stg.html"


# Module Compare 3: RHEL 8 Beta vs. Rocky 8 staging: 
"${SCRIPTSDIR}"/mkrepofile.sh
"${SCRIPTSDIR}"/module_compare_html.sh RHEL8_Beta_AppStream,RHEL8_Beta_CodeReady   Rocky8_AppStream_stg,Rocky8_PowerTools_stg  > "${RESULTSDIR}/RHEL8_Beta_Rocky8_Modules_stg_${now}.html"
cp  -f  "${RESULTSDIR}/RHEL8_Beta_Rocky8_Modules_stg_${now}.html"  "${RESULTSDIR}/RHEL8_Beta_Rocky8_Modules_stg_${now}.html"




# Module Compare:  RHEL 9 vs. Rocky 9 staging:
"${SCRIPTSDIR}"/module_compare_html.sh RHEL9_AppStream,RHEL9_CodeReady   Rocky9_AppStream_stg,Rocky9_CodeReady_stg  > "${RESULTSDIR}/RHEL9_Rocky9_Modules_stg_${now}.html"
cp -f "${RESULTSDIR}/RHEL9_Rocky9_Modules_stg_${now}.html"  "${RESULTSDIR}/RHEL9_Rocky9_Modules_stg.html"
