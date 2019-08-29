#!/bin/bash
set -e

wget -q -O supervisor-master.zip https://github.com/Supervisor/supervisor/archive/master.zip
pip install supervisor-master.zip

mkdir -p /etc/supervisor/
echo_supervisord_conf > /etc/supervisor/supervisord.conf

rm supervisor-master.zip