#!/bin/bash
# This script configures a Ubuntu Server running in Azure!
# Installs: 
#	Ubuntu-Desktop & XRDP
#	Visual Studio Code
#   NET Core 
#   NodeJS and NPM
#   Yeoman and ASP.NET Core Generator 
# Configures:  
#   Remote Desktop Login on port 3389
# To run the script manually execute:
#	wget https://raw.githubusercontent.com/SpectoLogic/ARM-Templates/master/UbuntoXRDPVSCode/UbuntoXRDPVSCode/Startup-Scripts/startup.sh -O startup.sh
#	chmod +x startup.sh
#	sudo ./startup.sh
#  (c) by SpectoLogic 2016
#  Version: 0.1 

# Ensure machine is up to date 
sudo apt-get update
sudo apt-get -f -y install

# Install Desktop and XRDP
sudo apt-get -y install ubuntu-desktop
sudo apt-get -y install xrdp
sudo apt-get -y install xubuntu-desktop

# Configure XRDP
echo xfce4-session >~/.xsession
# Add line xfce4-session before the line /etc/X11/Xsession.  
sudo sed -i 's/\. \/etc\/X11\/Xsession/xfce4-session\n. \/etc\/X11\/Xsession/' /etc/xrdp/startwm.sh
sudo service xrdp restart

# Install Visual Studio Code
wget http://go.microsoft.com/fwlink/?LinkID=760868 -O code.deb
sudo dpkg -i code.deb
# Fix "Bug" with Gnome Desktop and XRDP
sudo sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1

# Configure for .NET Core SDK Installation
sudo sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ trusty main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893
sudo apt-get -y update
# Install .NET Core SDK
sudo apt-get -y install dotnet-dev-1.0.0-preview2-003121

# Install NodeJS and NPM
sudo apt-get -y install nodejs
sudo apt-get -y install npm
sudo ln -s /usr/bin/nodejs /usr/bin/node

# Install Yeoman + ASP.NET Core Generator
sudo npm -y install -g yo
sudo npm -y install -g generator-aspnet

# Install Visual Studio Extensions under admin user
sudo -u $1 code --install-extension "ms-vscode.csharp"
