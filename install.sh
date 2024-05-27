#!/bin/bash

if ! [ -x "$(command -v docker compose)" ]; then
  echo 'Error: docker-compose is not installed.' >&2
  exit 1
fi

if [ -f "./docker-compose.yml" ]; then
  read -p "Already installed. Do you want to re-install? (y/N) " decision
  if [ "$decision" != "Y" ] && [ "$decision" != "y" ]; then
    echo "Exiting..."
    exit
  fi
  rm ./docker-compose.yml
  rm ./data/nginx/*
fi

echo "Nginx Server Installer with Docker Compose"
echo "1. Install Nginx Server without SSL"
echo "2. Install Nginx Server with SSL"
echo "3. Exit"
read -p "Choose your option: " option

case $option in
  1)
    echo "Installing Nginx Server without SSL"
    cp ./data/config/nginx/without-ssl.conf ./data/nginx/without-ssl.conf
    cp ./data/config/docker-compose/docker-compose-without-ssl.yml ./docker-compose.yml
    docker-compose up -d
    ;;
  2)
    echo "Installing Nginx Server with SSL"
    while true; do
      read -p "Enter your domain name: " domain
      echo "You entered: $domain"
      read -p "Is this correct? (y/N) " decision
      if [ "$decision" == "Y" ] || [ "$decision" == "y" ]; then
        break
      fi
    done
    while true; do
      read -p "Enter your email: " email
      echo "You entered: $email"
      read -p "Is this correct? (y/N) " decision
      if [ "$decision" == "Y" ] || [ "$decision" == "y" ]; then
        break
      fi
    done
    export domain=$domain
    export email=$email
    envsubst '$domain $email' < ./init-letsencrypt.sh > ./init.sh
    envsubst '$domain' < ./data/config/nginx/with-ssl.conf > ./data/nginx/with-ssl.conf
    cp ./data/config/docker-compose/docker-compose-with-ssl.yml ./docker-compose.yml
    chmod +x ./init.sh
    ./init.sh
    ;;
  3)
    echo "Exiting..."
    exit
    ;;
  *)
    echo "Invalid option"
    exit
    ;;
esac