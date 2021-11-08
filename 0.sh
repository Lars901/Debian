#!/usr/bin/env bash
sudo nano /etc/apt/sources.list
sudo apt -y update && upgrade 
sudo apt -y install terminus-font
sudo dpkg-reconfigure console-setup