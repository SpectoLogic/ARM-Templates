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

mkdir /home/$1/Logs
sudo chmod 777 /home/$1/Logs
# Ensure machine is up to date 
sudo apt-get update	>> /home/$1/Logs/specto_update_Log0.txt 2>&1
if [ "$?" != "0" ]; then
	echo "ERROR in sudo apt-get update \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for sudo apt-get update \n" >> /home/$1/Logs/specto_status.txt
fi
sudo apt-get -f -y install >> /home/$1/Logs/specto_update_Log1.txt 2>&1
if [ "$?" != "0" ]; then
	echo "ERROR in sudo apt-get -f -y install \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for sudo apt-get -f -y install \n" >> /home/$1/Logs/specto_status.txt
fi

sudo apt-get clean

# Install Desktop and XRDP
sudo apt-get -y install ubuntu-desktop >> /home/$1/Logs/specto_xrdp_Log0.txt 2>&1
if [ "$?" != "0" ]; then
	echo "ERROR in sudo apt-get -y install ubuntu-desktop \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for sudo apt-get -y install ubuntu-desktop \n" >> /home/$1/Logs/specto_status.txt
fi
sudo apt-get -y install xrdp  >> /home/$1/Logs/specto_xrdp_Log1.txt 2>&1
if [ "$?" != "0" ]; then
	echo "ERROR in sudo apt-get -y install xrdp \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for sudo apt-get -y install xrdp \n" >> /home/$1/Logs/specto_status.txt
fi
sudo apt-get -y install xubuntu-desktop  >> /home/$1/Logs/specto_xrdp_Log2.txt 2>&1
if [ "$?" != "0" ]; then
	echo "ERROR in sudo apt-get -y install xubuntu-desktop \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for sudo apt-get -y install xubuntu-desktop \n" >> /home/$1/Logs/specto_status.txt
fi

# Configure XRDP
sudo echo xfce4-session >~/.xsession
# Add line xfce4-session before the line /etc/X11/Xsession.  
sudo sed -i 's/\. \/etc\/X11\/Xsession/xfce4-session\n. \/etc\/X11\/Xsession/' /etc/xrdp/startwm.sh
sudo service xrdp restart
if [ "$?" != "0" ]; then
	echo "ERROR in Configure XRDP \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for Configure XRDP \n" >> /home/$1/Logs/specto_status.txt
fi

# Install Visual Studio Code
wget http://go.microsoft.com/fwlink/?LinkID=760868 -O code.deb >> /home/$1/Logs/specto_vscode_Log0.txt 2>&1
if [ "$?" != "0" ]; then
	echo "ERROR in wget vscode \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for wget vscode \n" >> /home/$1/Logs/specto_status.txt
fi
sudo dpkg -i code.deb >> /home/$1/Logs/specto_vscode_Log1.txt 2>&1
if [ "$?" != "0" ]; then
	echo "ERROR in sudo dpkg -i code.deb \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for sudo dpkg -i code.deb \n" >> /home/$1/Logs/specto_status.txt
fi
# Fix "Bug" with Gnome Desktop and XRDP
sudo sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1

# Configure for .NET Core SDK Installation
sudo sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ trusty main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893 >> /home/$1/Logs/specto_netcore_Log0.txt 2>&1
if [ "$?" != "0" ]; then
	echo "ERROR in sudo apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893 \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for sudo apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893 \n" >> /home/$1/Logs/specto_status.txt
fi
sudo apt-get -y update >> /home/$1/Logs/specto_netcore_Log1.txt 2>&1
if [ "$?" != "0" ]; then
	echo "ERROR in sudo apt-get -y update \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for sudo apt-get -y update \n" >> /home/$1/Logs/specto_status.txt
fi
# Install .NET Core SDK
sudo apt-get -y install dotnet-dev-1.0.0-preview2-003121 >> /home/$1/Logs/specto_netcore_Log2.txt 2>&1
if [ "$?" != "0" ]; then
	echo "ERROR in apt-get -y install dotnet-dev-1.0.0-preview2-003121 \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for apt-get -y install dotnet-dev-1.0.0-preview2-003121 \n" >> /home/$1/Logs/specto_status.txt
fi

# Install NodeJS and NPM
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get -y install nodejs >> /home/$1/Logs/specto_nodejs_Log0.txt 2>&1
if [ "$?" != "0" ]; then
	echo "ERROR in sudo apt-get -y install nodejs \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for sudo apt-get -y install nodejs \n" >> /home/$1/Logs/specto_status.txt
fi
sudo ln -s /usr/bin/nodejs /usr/bin/node >> /home/$1/Logs/specto_nodejs_Log1.txt 2>&1
if [ "$?" != "0" ]; then
	echo "ERROR in sudo ln -s /usr/bin/nodejs /usr/bin/node \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for sudo ln -s /usr/bin/nodejs /usr/bin/node \n" >> /home/$1/Logs/specto_status.txt
fi
#sudo apt-get -y install npm 

# Install Yeoman + ASP.NET Core Generator
sudo npm -y install -g yo >> /home/$1/Logs/specto_yeoman_Log0.txt 2>&1
if [ "$?" != "0" ]; then
	echo "ERROR in sudo npm -y install -g yo \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for sudo npm -y install -g yo \n" >> /home/$1/Logs/specto_status.txt
fi
sudo npm -y install -g generator-aspnet >> /home/$1/Logs/specto_yeoman_Log1.txt 2>&1
if [ "$?" != "0" ]; then
	echo "ERROR in sudo npm -y install -g generator-aspnet \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for sudo npm -y install -g generator-aspnet \n" >> /home/$1/Logs/specto_status.txt
fi

# Install Visual Studio Extensions under admin user
mkdir -p /home/$1/.vscode/extensions
sudo chmod 777 /home/$1/.vscode/extensions/
sudo -u $1 code --install-extension "ms-vscode.csharp" >> /home/$1/Logs/specto_vsexten_Log0.txt 2>&1
if [ "$?" != "0" ]; then
	echo "ERROR in sudo -u $1 code --install-extension 'ms-vscode.csharp' \n" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESS for sudo -u $1 code --install-extension 'ms-vscode.csharp' \n" >> /home/$1/Logs/specto_status.txt
fi
