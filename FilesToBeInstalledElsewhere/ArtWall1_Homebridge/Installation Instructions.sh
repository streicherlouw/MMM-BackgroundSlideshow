Installation Instructions

Install OS:


1: Set Hostname in Rasberry Pi configuration with https://www.raspberrypi.com/software/
2: Flash Raspberry Pi 64 Bit OS  
3: Sign in Raspberry Pi Connect service on the Pi screen
4: Set Desktop image to none and menu to medium
5: Update Pi OS with 

sudo apt update
sudo apt full-upgrade
sudo reboot

Install Magic Mirror:

1: Install Base
bash -c  "$(curl -sL https://raw.githubusercontent.com/sdetweil/MagicMirror_scripts/master/raspberry.sh)"

3: Clone the fork of the slideshow module
cd ~/MagicMirror/modules/
git clone https://github.com/streicherlouw/MMM-BackgroundSlideshow
cd ~/MagicMirror/modules/MMM-BackgroundSlideshow
npm install
npm audit fix

5: Copy Photo and Artwork Folders to ~/MagicMirror/modules/MMM-BackgroundSlideshow/
cp ~/MagicMirror/modules/MMM-BackgroundSlideshow/FilesToBeInstalledElsewhere/MagicMirror/set_slideshow_folder.sh ~/MagicMirror/
cp ~/MagicMirror/modules/MMM-BackgroundSlideshow/FilesToBeInstalledElsewhere/MagicMirror/config/config_Artwall1.js ~/MagicMirror/config/config.js
chmod +x set_slideshow_folder.sh
12: Test the slideshow folder setting
./set_slideshow_folder.sh Art
pm2 save

sudo raspi-config > Turn off screen blanking


Install Homebridge:

1: Install Homebridge
curl -sSfL https://repo.homebridge.io/KEY.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/homebridge.gpg  > /dev/null
echo "deb [signed-by=/usr/share/keyrings/homebridge.gpg] https://repo.homebridge.io stable main" | sudo tee /etc/apt/sources.list.d/homebridge.list > /dev/null
sudo apt-get update
sudo apt-get install homebridge

sudo usermod -a -G homebridge streicher

2: Set Homebridge to use user “streicher”
sudo nano /lib/systemd/system/homebridge.service

***SNIP***
[Unit]
Description=Homebridge
Wants=network-online.target
After=syslog.target network-online.target

[Service]
Type=simple
User=streicher
EnvironmentFile=-/etc/default/homebridge
SupplementaryGroups=streicher
PermissionsStartOnly=true
WorkingDirectory=/var/lib/homebridge
ExecStartPre=-/bin/run-parts /etc/hb-service/homebridge/prestart.d
ExecStart=/opt/homebridge/start.sh
Restart=always
RestartSec=3
KillMode=process
AmbientCapabilities=CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_NET_ADMIN

[Install]
WantedBy=multi-user.target
***SNIP***

sudo reboot

The Commands for switchign wayland HDMI on an off with id prodided by "id -u streicher"
XDG_RUNTIME_DIR=/run/user/1000 /usr/bin/wlr-randr --output HDMI-A-1 --on
XDG_RUNTIME_DIR=/run/user/1000 /usr/bin/wlr-randr --output HDMI-A-1 --off

The Commands for switching art screen is:
~/MagicMirror/set_slideshow_folder.sh Art

#Install Samba

sudo apt-get install samba samba-common-bin
sudo nano /etc/samba/smb.conf
ADD >>> 
[ArtWall1]
path = /home/streicher/MagicMirror/modules/MMM-BackgroundSlideshow
writeable=Yes
create mask=0777
directory mask=0777
public=no

sudo smbpasswd -a streicher
sudo systemctl restart smbd


