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
#########################################################################################################	
#	Version:	1.0 
#	Author:		Andreas Pollak, (c) by SpectoLogic (R) 2016
#   Parameter:
#		userName		admin user name for the machine
#		bUbuntuDesktop	true or false, depending if you want a full Ubuntu Desktop
#	Examples:
#		manual execution:
#			cd ~/
#			wget https://raw.githubusercontent.com/SpectoLogic/ARM-Templates/master/UbuntoXRDPVSCode/UbuntoXRDPVSCode/Config-Files/xfce4-keyboard-shortcuts.xml - O xfce4-keyboard-shortcuts.xml
#			wget https://raw.githubusercontent.com/SpectoLogic/ARM-Templates/master/UbuntoXRDPVSCode/UbuntoXRDPVSCode/Startup-Scripts/install.sh -O startup.sh
#			chmod +x startup.sh
#			./startup.sh $USER <bool install ubuntu desktop>
#########################################################################################################	

# Add Logs Directory to write Logs to
mkdir /home/$1/Logs
sudo chmod 777 /home/$1/Logs

echo "Installation running as user: " $USER >> /home/$1/Logs/specto_status.txt

# Ensure machine is up to date 
echo "Updating machine... (specto_update_Log0.txt)" >> /home/$1/Logs/specto_status.txt
sudo apt-get -y update	>> /home/$1/Logs/specto_update_Log0.txt 2>&1
if [ "$?" != "0" ]; then
	echo "	FAILED to execute to execute sudo apt-get -y update" >> /home/$1/Logs/specto_status.txt
else
	echo "	SUCCESSFULLY executed sudo apt-get update" >> /home/$1/Logs/specto_status.txt
fi

# Preinstall the item that is responsible for the issues
echo "Installing dictionaries-common..." >> /home/$1/Logs/specto_status.txt
sudo apt-get -y install dictionaries-common
if [ "$?" != "0" ]; then
	echo "	FAILED to execute running apt-get -y install dictionaries-common" >> /home/$1/Logs/specto_status.txt
else
	echo "	SUCCESSFULLY executed apt-get -y install dictionaries-common" >> /home/$1/Logs/specto_status.txt
fi

# Install XRDP 
echo "Installing XRDP... (specto_xrdp_Log1.txt)" >> /home/$1/Logs/specto_status.txt
sudo apt-get -y install xrdp  >> /home/$1/Logs/specto_xrdp_Log1.txt 2>&1
if [ "$?" != "0" ]; then
	echo "	FAILED to execute sudo apt-get -y install xrdp" >> /home/$1/Logs/specto_status.txt
else
	echo "	SUCCESSFULLY executed sudo apt-get -y install xrdp" >> /home/$1/Logs/specto_status.txt
fi

#Install XFCE4 
echo "Installing XFCE4... (specto_xfce4_Log0.txt)" >> /home/$1/Logs/specto_status.txt
sudo apt-get install -y xfce4 >> /home/$1/Logs/specto_xfce4_Log0.txt 2>&1
if [ "$?" != "0" ]; then
	echo "	FAILED to execute sudo apt-get install -y xfce4" >> /home/$1/Logs/specto_status.txt
else
	echo "	SUCCESSFULLY executed sudo apt-get install -y xfce4" >> /home/$1/Logs/specto_status.txt
fi

# Configure XRDP with xfce 
echo "Configure XFCE4..." >> /home/$1/Logs/specto_status.txt
sudo echo xfce4-session >~/.xsession
# Add line xfce4-session before the line /etc/X11/Xsession in startwm.sh file.  
sudo sed -i 's/\. \/etc\/X11\/Xsession/xfce4-session\n. \/etc\/X11\/Xsession/' /etc/xrdp/startwm.sh
sudo service xrdp restart
if [ "$?" != "0" ]; then
	echo "	FAILED to configure XRDP" >> /home/$1/Logs/specto_status.txt
else
	echo "	SUCCESSFULLY configured XRDP" >> /home/$1/Logs/specto_status.txt
fi

# Update eventually missing packages
echo "Try to download missing packages (specto_packages_Log0.txt)..." >> /home/$1/Logs/specto_status.txt
sudo apt-get -y -f install >> /home/$1/Logs/specto_packages_Log0.txt 2>&1
if [ "$?" != "0" ]; then
	echo "	FAILED to execute sudo apt-get -f install" >> /home/$1/Logs/specto_status.txt
else
	echo "	SUCCESSFULLY executed sudo apt-get -f install" >> /home/$1/Logs/specto_status.txt
fi

# Install Visual Studio Code
echo "Downloading Visual Studio Code (specto_vscode_Log0.txt)..." >> /home/$1/Logs/specto_status.txt
wget http://go.microsoft.com/fwlink/?LinkID=760868 -O code.deb >> /home/$1/Logs/specto_vscode_Log0.txt 2>&1
if [ "$?" != "0" ]; then
	echo "FAILED to execute wget vscode" >> /home/$1/Logs/specto_status.txt
else
	echo "SUCCESSFULLY executed wget vscode" >> /home/$1/Logs/specto_status.txt
fi
echo "Installing Visual Studio Code (specto_packages_Log1)..." >> /home/$1/Logs/specto_status.txt
sudo dpkg -i code.deb >> /home/$1/Logs/specto_vscode_Log1.txt 2>&1
if [ "$?" != "0" ]; then
	echo "	FAILED to execute sudo dpkg -i code.deb" >> /home/$1/Logs/specto_status.txt
	echo "	Try to download missing packages (specto_packages_Log1.txt)..." >> /home/$1/Logs/specto_status.txt
	sudo apt-get -y -f install >> /home/$1/Logs/specto_packages_Log1.txt 2>&1
	if [ "$?" != "0" ]; then
		echo "		FAILED to execute sudo apt-get -y -f install" >> /home/$1/Logs/specto_status.txt
	else
		echo "		SUCCESSFULLY executed sudo apt-get -y -f install" >> /home/$1/Logs/specto_status.txt
	fi
	echo "	Installing Visual Studio Code (specto_packages_Log2)..." >> /home/$1/Logs/specto_status.txt
	sudo dpkg -i code.deb >> /home/$1/Logs/specto_vscode_Log2.txt 2>&1
	if [ "$?" != "0" ]; then
		echo "		FAILED to execute sudo dpkg -i code.deb" >> /home/$1/Logs/specto_status.txt
	else
		echo "		SUCCESSFULLY executed sudo dpkg -i code.deb" >> /home/$1/Logs/specto_status.txt
	fi
else
	echo "	SUCCESSFULLY executed sudo dpkg -i code.deb" >> /home/$1/Logs/specto_status.txt
fi
echo "Fixing Visual Studio Code Bug (hack) with libxcb.so.1..." >> /home/$1/Logs/specto_status.txt
# Fix (HACK) a Visual Code "Bug" with Gnome Desktop and XRDP (Why is everything related to Linux forcing you to use hacks instead of real solution? *eyeroll*)
sudo sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1

# Configure for .NET Core SDK Installation
echo "Configuring for .NET Core SDK Installation (specto_netcore_Log0.txt)..." >> /home/$1/Logs/specto_status.txt
sudo sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ trusty main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893 >> /home/$1/Logs/specto_netcore_Log0.txt 2>&1
if [ "$?" != "0" ]; then
	echo "	FAILED to execute sudo apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893" >> /home/$1/Logs/specto_status.txt
else
	echo "	SUCCESSFULLY executed sudo apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893" >> /home/$1/Logs/specto_status.txt
fi
echo "Updating packages list for .NET Core SDK Installation (specto_netcore_Log1.txt)..." >> /home/$1/Logs/specto_status.txt
sudo apt-get -y update >> /home/$1/Logs/specto_netcore_Log1.txt 2>&1
if [ "$?" != "0" ]; then
	echo "	FAILED to execute sudo apt-get -y update" >> /home/$1/Logs/specto_status.txt
else
	echo "	SUCCESSFULLY executed sudo apt-get -y update" >> /home/$1/Logs/specto_status.txt
fi

# Install .NET Core SDK
echo "Installing .NET Core SDK (specto_netcore_Log2.txt)..." >> /home/$1/Logs/specto_status.txt
sudo apt-get -y install dotnet-dev-1.0.0-preview2-003121 >> /home/$1/Logs/specto_netcore_Log2.txt 2>&1
if [ "$?" != "0" ]; then
	echo "	FAILED to execute apt-get -y install dotnet-dev-1.0.0-preview2-003121" >> /home/$1/Logs/specto_status.txt
else
	echo "	SUCCESSFULLY executed apt-get -y install dotnet-dev-1.0.0-preview2-003121" >> /home/$1/Logs/specto_status.txt
fi

# Install NodeJS and NPM
echo "Installing NodeJS and NPM (specto_nodejs_Log0.txt)..." >> /home/$1/Logs/specto_status.txt
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get -y install nodejs >> /home/$1/Logs/specto_nodejs_Log0.txt 2>&1
if [ "$?" != "0" ]; then
	echo "	FAILED to execute sudo apt-get -y install nodejs" >> /home/$1/Logs/specto_status.txt
else
	echo "	SUCCESSFULLY executed sudo apt-get -y install nodejs" >> /home/$1/Logs/specto_status.txt
fi
#No longer necessary
#sudo ln -s /usr/bin/nodejs /usr/bin/node >> /home/$1/Logs/specto_nodejs_Log1.txt 2>&1
#if [ "$?" != "0" ]; then
#	echo "FAILED to execute sudo ln -s /usr/bin/nodejs /usr/bin/node" >> /home/$1/Logs/specto_status.txt
#else
#	echo "SUCCESSFULLY executed sudo ln -s /usr/bin/nodejs /usr/bin/node" >> /home/$1/Logs/specto_status.txt
#fi

# Install Yeoman + ASP.NET Core Generator
echo "Installing Yeoman (specto_yeoman_Log0.txt)..." >> /home/$1/Logs/specto_status.txt
sudo npm -y install -g yo >> /home/$1/Logs/specto_yeoman_Log0.txt 2>&1
if [ "$?" != "0" ]; then
	echo "	FAILED to execute sudo npm -y install -g yo" >> /home/$1/Logs/specto_status.txt
else
	echo "	SUCCESSFULLY executed sudo npm -y install -g yo" >> /home/$1/Logs/specto_status.txt
fi
echo "Installing Yeoman ASP.NET Generator (specto_yeoman_Log1.txt)..." >> /home/$1/Logs/specto_status.txt
sudo npm -y install -g generator-aspnet >> /home/$1/Logs/specto_yeoman_Log1.txt 2>&1
if [ "$?" != "0" ]; then
	echo "	FAILED to execute sudo npm -y install -g generator-aspnet" >> /home/$1/Logs/specto_status.txt
else
	echo "	SUCCESSFULLY executed sudo npm -y install -g generator-aspnet" >> /home/$1/Logs/specto_status.txt
fi

# Install Desktop
if [ "$2" == "true" ]; then
	echo "Installing Ubuntu Desktop (specto_ubuntudsktop_Log1.txt)..." >> /home/$1/Logs/specto_status.txt
	sudo apt-get -y install ubuntu-desktop >> /home/$1/Logs/specto_ubuntudsktop_Log1.txt 2>&1
	if [ "$?" != "0" ]; then
		echo "	FAILED to execute sudo apt-get -y install ubuntu-desktop" >> /home/$1/Logs/specto_status.txt
		# TODO: We always land here because of the "dictionaries" error. See /var/crash/ for details.
		# Remove annoying crash message altough it would be better to fix this
		# sudo rm /var/crash/*
	else
		echo "	SUCCESSFULLY executed sudo apt-get -y install ubuntu-desktop" >> /home/$1/Logs/specto_status.txt
	fi
	# Install XDesktop
	echo "Installing Ubuntu XDesktop (specto_ubuntudsktop_Log0.txt)..." >> /home/$1/Logs/specto_status.txt
	sudo apt-get -y install xubuntu-desktop  >> /home/$1/Logs/specto_ubuntudsktop_Log0.txt 2>&1
	if [ "$?" != "0" ]; then
		echo "	FAILED to execute sudo apt-get -y install xubuntu-desktop" >> /home/$1/Logs/specto_status.txt
	else
		echo "	SUCCESSFULLY executed sudo apt-get -y install xubuntu-desktop" >> /home/$1/Logs/specto_status.txt
	fi
else
	echo "NOT installing Ubuntu Desktop as requested..." >> /home/$1/Logs/specto_status.txt
	echo "Installing required libgconf-2-4 package instead of full Desktop..." >> /home/$1/Logs/specto_status.txt
	sudo apt-get -y install libgconf-2-4
	echo "Installing required gnome-icon-theme package instead of full Desktop..." >> /home/$1/Logs/specto_status.txt
	sudo apt-get install gnome-icon-theme
fi

# Install Visual Studio Extensions under admin user
# again some hacks to make code --install-extension work *sighs*
echo "Installing C# VSCode Extension (specto_vsexten_Log0)..." >> /home/$1/Logs/specto_status.txt
sudo -i -E -u $1  mkdir -p /home/$1/.vscode/extensions
sudo -i -E -u $1  chmod 777 /home/$1/.vscode/extensions/
sudo -i -E -u $1  mkdir -p /home/$1/.config/Code/User
# The following line caused the issue with remote desktop if run as root instead of the user !!!
sudo -i -E -u $1  chmod 777 /home/$1/.config/Code
sudo -i -E -u $1  chmod 777 /home/$1/.config/Code/User
sudo -i -E -u $1 code --install-extension "ms-vscode.csharp" >> /home/$1/Logs/specto_vsexten_Log0.txt 2>&1
if [ "$?" != "0" ]; then
	echo "	FAILED to execute sudo -u $1 code --install-extension 'ms-vscode.csharp'" >> /home/$1/Logs/specto_status.txt
else
	echo "	SUCCESSFULLY executed sudo -u $1 code --install-extension 'ms-vscode.csharp'" >> /home/$1/Logs/specto_status.txt
fi
# Remove that config direcory we created earlier as it makes troubles later! Just another hack for the VSCOde Extension Installation Bug
cd /home/$1/.config/Code/
sudo -i -E -u $1 rmdir User
cd ..
sudo -i -E -u $1 rmdir Code

# Configure default setup for desktop 
echo "Setting up default desktop..." >> /home/$1/Logs/specto_status.txt
cp -r /etc/xdg/xfce4 ~/.config/xfce4
if [ "$?" != "0" ]; then
	echo "	FAILED setting up default desktop" >> /home/$1/Logs/specto_status.txt
else
	echo "	SUCCESSFULLY set up default desktop'" >> /home/$1/Logs/specto_status.txt
fi
# Show default setup for desktop 
echo "Fixing TAB behaviour..." >> /home/$1/Logs/specto_status.txt
chmod 664 /home/$1/xfce4-keyboard-shortcuts.xml
mv /home/$1/xfce4-keyboard-shortcuts.xml /home/$1/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

# Upgrade the machine
sudo apt-get -y upgrade 

exit 0
