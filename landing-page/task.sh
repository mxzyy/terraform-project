#!/bin/bash

# Repo update & upgrade
sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y

# Ganti Nameserver
sudo sed -i 's/127.0.0.53/8.8.8.8/g' /etc/resolv.conf

# Install add repo deps
sudo DEBIAN_FRONTEND=noninteractive apt install ca-certificates curl apt-transport-https curl gnupg software-properties-common curl -y

# Docker Repo
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# PHP Repo
sudo add-apt-repository ppa:ondrej/php -y

# Install pkg
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install apache2-utils nginx php8.3 php8.3-cli php8.3-fpm php8.3-mysql php8.3-xml php8.3-mbstring php8.3-curl php8.3-zip php8.3-gd docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose -y

# PHP info
sudo mkdir /var/www/html/phpinfo
sudo echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo/index.php
sudo chown -R www-data:www-data /var/www/html/phpinfo/index.php
sudo chmod -R 755 /var/www/html/phpinfo/index.php


# htpasswd
htpasswd -cb /etc/nginx/.htpasswd admin nimda

# Nginx Conf
#wget "https://raw.githubusercontent.com/mxzyy/terraform-project/main/landing-page/nginx.conf" -O default
sudo mv default /etc/nginx/sites-available/
sudo service nginx restart

# NJS
sudo wget https://raw.githubusercontent.com/mxzyy/terraform-project/main/landing-page/app/index.js
sudo wget https://raw.githubusercontent.com/mxzyy/terraform-project/main/landing-page/app/package.json

# app
sudo mkdir app
sudo mv index.js app
sudo mv package.json app
sudo chown -R user:user app
sudo chmod -R 755 app
# Docker
sudo docker compose up --build --detach

# 
# nginx conf
# docker 
