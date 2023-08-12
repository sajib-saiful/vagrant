#!/usr/bin/env bash

sudo apt update -y
sudo apt install -y apache2
sudo systemctl start apache2

sudo ufw allow 80/tcp
sudo ufw --force enable
