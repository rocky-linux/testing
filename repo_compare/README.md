# RepoCompare

Code to compare Rocky Linux repositories against RHEL 8 ones and produce status information

So far, a simple script that you can call to compare like-for-like RHEL 8 vs. Rocky 8 Repos.

Example call:  ```./repo_compare_html.sh  RHEL8_BaseOS   Rocky8_BaseOS```

WARNING:  only compares default modules right now!  Non-default module comparisons coming soon(tm)

WARNING:  The order of the arguments VERY MUCH MATTERS!  For Rocky 8 comparisons, RHEL repos should ALWAYS come first, they are the source to compare against!
