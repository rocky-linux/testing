# RepoCompare

Code to compare Rocky Linux repositories against RHEL ones and produce status information in HTML format.

Comparison can be done one at a time by calling the scripts with repos as arguments, or the "helper" scripts can be used to produce automated reports across all repos.

These scripts can be called against any repositories, but are designed to compare Red Hat Enterprise Linux against Rocky Linux.  When doing this, they **must** be run on a Red Hat Enterprise Linux system, with a valid subscription!

<br />
<br />

## QuickStart:

How to get a friendly HTML menu comparison of RHEL vs. Rocky (like the one published on https://repocompare.rockylinux.org ):  

1. Have a subscribed Red Hat Enterprise Linux 8 or 9 machine you are running this on, with root access.
2. Clone or copy this repository on to the subscribed machine.
3. Edit **repo_compare_launcher.sh**, change the **$RESULTSDIR** variable at the top to a folder where you want to store HTML output of the scripts.
4. Run **repo_compare_launcher.sh**.  It will take a while, likely between 30-60 minutes.
5. Copy the **html/** folder to a web directory of your choice.
6. Copy the resulting HTML files from the RESULTSDIR folder (that you specified earlier) into **html/repocompare_results/** in the same web directory.
7. You can now browse the results via web browser with friendly headers and organized pages.
8. Steps 4-6 can be automated via **cron** job to run on a schedule.  Remember the script must be run as root! (due to RHEL DNF subscription limitations).
9. When scheduling via `cron`, I recommend periodically wiping older html results files after 10 days or so, or the folder will become massive:  `find /path/to/repocompare_results/ -iname "*.html" -type f -mtime +10 -exec rm -f {} \;`

<br />
<br />


## Base repocompare script:

The base script is **repo_compare_html.sh**, and takes a source repo and destination repo as arguments:  
  
```./repo_compare_html.sh  RepoA   RepoB  >  output.html```


Here is an example for comparing BaseOS in RHEL vs. Rocky:
Example call:  ```./repo_compare_html.sh  RHEL8_BaseOS   Rocky8_BaseOS  >  RHEL8_Rocky8_BaseOS.html```

WARNING:  only compares default modules right now!  Non-default module comparisons coming soon(tm)

WARNING:  The order of the arguments VERY MUCH MATTERS!  For Rocky 8 comparisons, RHEL repos should ALWAYS come first, they are the source to compare against!

<br />
<br />

## Module Comparisons Script:

This is a similar script to the above RepoCompare, but will analyze all the module versions against each other from one distro to the next.

It's called like the above script, except with a comma separated list of repositories that include modules:

```./module_compare_html.sh  RepoA,RepoB   RepoX,RepoY  >  output.html```

For example, a typical usage looks like this:   ```./module_compare_html.sh   RHEL8_AppStream,RHEL8_CodeReady   Rocky8_AppStream,Rocky8_PowerTools```

The example compares all modules found in RHEL AppStream and CodeReady against their Rocky equivalents.

Note that only the packages contained in a module are compared.  No other metadata (module version strings, etc.) is considered, as it is likely unique and not meant to be copied.

WARNING:  As with the above script, the order of the arguments absolutely matters.  Generally RHEL repos should be listed first, as the source to compare against.


<br />
<br />

## Running Comparisons Across Entire Distro

Some support scripts and HTML templates have been included 
A couple support scripts are also in the repository:

**mkrepofile.sh :** Create repo files for Rocky and duplicate ones with friendly names for the RHEL repos (and extract+place subscription entitlement info from RHEL, which rotates regularly)

<br />

**repo_compare_launcher.sh :** Run all combinations of repocompare RHEL <---> Rocky. Compares 8 and 9 production, staging, source, modules, RHEL Beta, etc.


