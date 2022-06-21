#!/bin/bash

sudo apt update -y && sudo apt upgrade -y

sudo apt install nginx -y
sudo systemctl enable nginx

sudo apt install nodejs -y
sudo apt install npm -y
npm install -g npm -y
sudo apt install python-software-properties -y
sudo npm install pm2 -g
npm cache clean -f
npm install -g n
sudo n stable
sudo rm -rf /etc/nginx/sites-available/default

sudo cp default /etc/nginx/sites-available/
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl enable nginx

cd app/app && sudo npm i
nohup node app.js > /dev/null 2>&1 &
