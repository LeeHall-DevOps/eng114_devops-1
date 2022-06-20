#!/bin/bash

#update & upgrade
sudo apt update -y

sudo apt upgrade -y

# install nginx
sudo apt install nginx -y

# enable nginx
sudo systemctl enable nginx

# start nginx
sudo systemctl start nginx
sudo apt-get install nodejs -y
sudo apt install npm -y
npm install -g npm -y
sudo apt install python-software-properties -y
sudo npm install pm2 -g
npm cache clean -f
npm install -g n
sudo n stable
sudo rm -rf etc/nginx/sites-available/default

# copy default into sites-available and enabling nginx to work again with the new default file
sudo cp app/default /etc/nginx/sites-available/
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl enable nginx

# Adding env variable
sudo echo "export DB_HOST=mongodb://192.168.10.150:27017/posts" >> .bashrc
source .bashrc

# cd into app and install and start app
cd app/app/
#npm install 
#nohup node app.js > /dev/null 2>&1 &
