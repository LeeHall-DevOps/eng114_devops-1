#!/bin/bash

#update & upgrade
sudo apt-get update -y

sudo apt-get upgrade -y

# install nginx
sudo apt-get install nginx -y

# install nodejs v6
sudo curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

# install nodejs part 2
sudo apt-get install nodejs -y

# install pm2
sudo npm install pm2 -g

# change port number on the app

cd /etc/nginx/sites-available/

# start nginx
sudo systemctl start nginx

# enable nginx
sudo systemctl enable nginx

# cd into app and install and start app

cd ~/app/app

npm install && npm start -d
