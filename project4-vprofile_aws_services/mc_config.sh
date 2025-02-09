#!/bin/bash

echo "INSTALLING memchache client"

rm -rf /home/mc_conf
mkdir /home/mc_conf
cd /home/mc_conf

pip3 install pymemcache

