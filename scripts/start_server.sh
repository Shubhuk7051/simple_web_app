#!/bin/bash
cd /var/www/flaskapp
pip3 install -r requirements.txt
nohup python3 app.py > app.log 2>&1 &