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

# install nodejs v6
sudo curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

# install nodejs part 2
sudo apt install nodejs -y
sudo apt install python-software-properties -y

# install pm2
sudo npm install pm2 -g

# copy default into sites-available and enabling nginx to work again with the new default file
sudo rm -rf etc/nginx/sites-available/default
sudo cp default /etc/nginx/sites-available/
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl enable nginx

# Adding env variable
sudo echo "export DB_HOST=mongodb://192.168.10.150:27017/posts" >> .bashrc
source .bashrc

# cd into app and install and start app
cd app/app/
npm install 
nohup node app.js > /dev/null 2>&1 &
