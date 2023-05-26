#!/bin/bash

sudo apt update -y
sudo apt install apache2 -y


#sudo systemctl stop apache2
#sudo sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf
#sudo sed -i 's/:80>/:8080>/g' /etc/apache2/sites-available/000-default.conf
#sudo systemctl start apache2