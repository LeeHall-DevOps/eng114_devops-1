#!/bin/bash

sudo apt update -y

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927

echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf

sudo systemctl restart mongod
sudo systemctl enable mongod
sudo systemctl start mongod

echo "mongodb-org hold" | sudo dpkg --set-selections &&
echo "mongodb-org-server hold" | sudo dpkg --set-selections &&
echo "mongodb-org-shell hold" | sudo dpkg --set-selections &&
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections &&
echo "mongodb-org-tools hold" | sudo dpkg --set-selections
