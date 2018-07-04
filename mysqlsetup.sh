#!/bin/bash

# Author: David Sopkin (sopkin.sf@gmail.com)
# This script installs mysql

sudo su
export http_proxy=http://proxy:8080
apt-get update
apt-get install cmake libncurses5-dev openjdk-7-jdk
get source from http://dev.mysql.com/downloads/cluster/7.3.html#downloads
cd /usr/local/src
tar xzfv /home/pi/mysql-cluster-gpl-7.3.0.tar.gz
cd mysql-cluster-gpl-7.3.0

get patch from http://bugs.mysql.com/file.php?id=17637
cd sql-common
patch -l -f --verbose -i mysql-va-list.patch client_plugin.c
cd ..


groupadd mysql
useradd -r -g mysql mysql
cmake .
make
make install


