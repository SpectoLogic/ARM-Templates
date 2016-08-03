#!/bin/bash
echo "Installing install.sh script..." >> /home/$1/progress.txt
cp install.sh /home/$1/install.sh
echo "Running install.sh script..." >> /home/$1/progress.txt
echo "	See Logs/specto_status.txt for deails!" >> /home/$1/progress.txt
sudo -i -E -u $1 sh /home/$1/install.sh $1
echo "Completed install.sh script." >> /home/$1/progress.txt
exit 0
