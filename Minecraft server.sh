#!/usr/bin/env bash
username=$(id -u -n 1000)
builddir=$(pwd)

mkdir -p "/home/$username/Minecraft_Server"
sudo apt install openjdk-17-jre-headless -y
sudo apt install wget -y
java -version
sudo apt install screen git -y
udo apt-get install software-properties-common -y
sudo apt-get install python-software-properties -y
sudo ufw allow 25565
cd "/home/$username/Minecraft_Server"
wget https://piston-data.mojang.com/v1/objects/5b868151bd02b41319f54c8d4061b8cae84e665c/server.jar
java -Xmx512M -Xms2048M -jar minecraft_server.1.20.2.jar nogui