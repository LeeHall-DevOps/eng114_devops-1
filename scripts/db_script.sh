!#/bin/bash

# update
sudo apt-get update -y

# adds key
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927

echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# update & upgrades
sudo apt-get update -y && sudo apt-get upgrade -y

# install mongo 3.2.20
sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20

# move the mongod.conf 
sudo cp ./mongod.conf /etc/

# mongo restart and enable
sudo systemctl restart mongod
sudo systemctl enable mongod
sudo systemctl start mongod

# Makes sure that mongo doesn't upgrade
echo "mongodb-org hold" | sudo dpkg --set-selections &&
echo "mongodb-org-server hold" | sudo dpkg --set-selections &&
echo "mongodb-org-shell hold" | sudo dpkg --set-selections &&
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections &&
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

