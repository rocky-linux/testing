################################################################################
# @file         mtgencomplist.sh                                               #
# @author       Muhammad Taibah [taibah@linux.com]                             #
# @version      0.1                                                            #
# @details      This program is used for taking the list of packages produced  #
#               during Rocky's build process generating a csv file for BaseOS  #
#               packages and another for AppStream packages, while making sure #
#               to have the ones with the exact similar name first, and then   #
#               it starts looking into the ones with modified names.           #
#               The idea is to have as complete as possible list with 1-to-1   #
#               mapping to upstream packages (e.g. CentOS, or RHEL).           #
# @copyright                                                                   #
#                                                                              #
# 3-Clause BSD License                                                         #
#                                                                              #
# Copyright (C) 2021 Rocky Linux Project Authors.                              #
#                                                                              #
# Redistribution and use in source and binary forms, with or without           #
# modification, are permitted provided that the following conditions are met:  #
#                                                                              #
# 1. Redistributions of source code must retain the above copyright notice,    #
# this list of conditions and the following disclaimer.                        #
#                                                                              #
# 2. Redistributions in binary form must reproduce the above copyright notice, #
# this list of conditions and the following disclaimer in the documentation    #
# and/or other materials provided with the distribution.                       #
#                                                                              #
# 3. Neither the name of the copyright holder nor the names of its             #
# contributors may be used to endorse or promote products derived from this    #
# software without specific prior written permission.                          #
#                                                                              #
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"  #
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE    #
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE   #
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE    #
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR          #
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF         #
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS     #
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN      #
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)      #
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE   #
# POSSIBILITY OF SUCH DAMAGE.                                                  #
#                                                                              #
################################################################################

#!/bin/bash

# This assumes that you have the package files within the system running this
# script, and within the working direcrtory

current=`pwd`
upstr_dir="CentOS-8-3-2011-x86_64-dvd1"
upstr_baseos_lst="mtgen_CentOS-BaseOS-pkg-list.txt"
upstr_appstream_lst="mtgen_CentOS-AppStream-pkg-list.txt"

rocky_dir="Rocky-8.3-x86_64-dvd1"
rocky_baseos_lst="mtgen_Rocky-BaseOS-pkg-list.txt"
rocky_appstream_lst="mtgen_Rocky-AppStream-pkg-list.txt"

# Populate the BasesOS packages list text files
cd $current/$rocky_dir/BaseOS/Packages/
ls *.rpm -la | awk '{print $9}' > $current/$rocky_baseos_lst
cd $current/$upstr_dir/BaseOS/Packages/
ls *.rpm -la | awk '{print $9}' > $current/$upstr_baseos_lst

# Populate the AppStream packages list text files
cd $current/$rocky_dir/AppStream/Packages
ls *rpm -la | awk '{print $9}' > $current/$rocky_appstream_lst
cd $current/$upstr_dir/AppStream/Packages
ls *rpm -la | awk '{print $9}' > $current/$upstr_appstream_lst

cd $current
# Generate the list of similarly named BaseOS packages
while IFS= read -r line
do
  tmp_var=`grep "^$line$" $current/$upstr_baseos_lst`
  if [[ "^$tmp_var$" == "^$line$" ]]; then
    echo "$line,$line" >> $current/baseos_mapped.csv
  else
    echo "$line" >> $current/baseos_unmapped.csv
  fi
done < "$current/$rocky_baseos_lst"

cd $current
# Generate the list of similarly named AppStream package
while IFS= read -r line
do
  tmp_var=`grep "^$line$" $current/$upstr_appstream_lst`
  if [[ "^$tmp_var$" == "^$line$" ]]; then
    echo "$line,$line" >> $current/appstream_mapped.csv
  else
    echo "$line" >> $current/appstream_unmapped.csv
  fi
done < "$current/$rocky_appstream_lst"

rm mtgen_*

#### @TODO
# 1- Deal with unmapped package names
# 2- Deal with packages without mapping at all
