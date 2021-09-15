# RepoCompare

Code to compare Rocky Linux repositories against RHEL 8 ones and produce status information

So far, a simple script that you can call to compare like-for-like RHEL 8 vs. Rocky 8 Repos.

Example call:  ```./repo_compare_html.sh  RHEL8_BaseOS   Rocky8_BaseOS```

WARNING:  only compares default modules right now!  Non-default module comparisons coming soon(tm)

WARNING:  The order of the arguments VERY MUCH MATTERS!  For Rocky 8 comparisons, RHEL repos should ALWAYS come first, they are the source to compare against!

<br />
<br />

# ModuleCompare

This is a similar script to the above RepoCompare, but will analyze all the module versions against each other from one distro to the next.

It's called like the above script, except with a comma separated list of repositories that include modules.

For example, a typical usage looks like this:  ```./module_compare_html.sh   RHEL8_AppStream,RHEL8_CodeReady   Rocky8_AppStream,Rocky8_PowerTools```

The example compares all modules found in RHEL AppStream and CodeReady against their Rocky equivalents.

Note that only the packages contained in a module are compared.  No other metadata (module version strings, etc.) is considered, as it is likely unique and not meant to be copied.

WARNING:  As with the above script, the order of the arguments absolutely matters.  Generally RHEL repos should be listed first, as the source to compare against.
