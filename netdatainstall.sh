#!/bin/bash

# Author: David Sopkin (sopkin.sf@gmail.com)
# this script installs netdata server for stats monitoring

sudo apt-get update --fix-missing --force-yes -y && curl -Ss 'https://raw.githubusercontent.com/firehol/netdata-demo-site/master/install-required-packages.sh' >/tmp/kickstart.sh && bash /tmp/kickstart.sh netdata-all && git clone https://github.com/firehol/netdata.git --depth=1 && cd netdata && sudo. /netdata-installer.sh


