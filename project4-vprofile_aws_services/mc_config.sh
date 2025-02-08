#!/bin/bash

echo "INSTALLING memchache client"

rm -rf /home/mc_conf
mkdir /home/mc_conf
cd /home/mc_conf

curl -O https://bootstrap.pypa.io/pip/3.7/get-pip.py

python3 get-pip.py --user

pip3 install pymemcache

