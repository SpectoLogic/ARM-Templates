#!/bin/bash
echo "Copying xfce4-keyboard-shortcuts.xml..." >> /home/$1/progress.txt
cp xfce4-keyboard-shortcuts.xml /home/$1/xfce4-keyboard-shortcuts.xml
sudo chown -c $1 /home/$1/xfce4-keyboard-shortcuts.xml
echo "Copying install.sh script..." >> /home/$1/progress.txt
cp install.sh /home/$1/install.sh
echo "Running install.sh script..." >> /home/$1/progress.txt
echo "	See Logs/specto_status.txt for deails!" >> /home/$1/progress.txt
sudo -i -E -u $1 sh /home/$1/install.sh $1 $2
echo "Completed install.sh script." >> /home/$1/progress.txt
rm -f install.sh
exit 0
