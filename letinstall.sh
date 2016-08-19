#!/bin/sh
#

# Copyright 2016 Paolo Leoni - http://www.paololeoni.altervista.org
# Email: <ulixes84@yahoo.it>
#
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA


#LETInstall - GNU/Linux Fedora
#
#Thanks to Paolo Guasti, Cesare Baronio, Matteo Parmigiani (also doc and sw translation), Marco Gorni and Matteo Giavarini for good hints and beta testing.
#Thanks to Gian Paolo "JP" Ghilardi for his script "Progressbar.sh"
#
#Script for installation and automatic configuration of some preferencial packages. 
#
#In order to make some operation you must be root. If you're not, type [su] and enter your
#root password before you start the script or errors you will be displayed (please don't use "sudo" command).


### SETUP ###
EXIT_SUCCESS=0
PROGNAME="LETInstall"
VERSION="24.0"
REL=`more /etc/redhat-release`
PLEONI_WEB="http://www.paololeoni.altervista.org"

INST_C="dnf"
inst_opt="-y --setopt=strict=0"
my_arch=`uname -m`

GUI_VAL="1"
START=1

### MODIFY THESE PARAMETERS TO EDIT APPS AND CONFIGURATIONS ~ "1" = TRUE; "0" = "FALSE" ###

### APPS ###

UPDATE_VAL="0" ### Update switch ###

GEN_APPS="0" ### General Apps ###
G_FONTS_VAL="0" ### Google FONTS ###
M_FONTS_VAL="0" ### Microsoft FONTS ###
TV_VAL="0" ### Team Viewer ###
GEARTH_VAL="0" ### GOOGLE EARTH ###
FLASH_VAL="0" ### Adobe Flash - not required with Google Chrome ###
TELEGRAM_VAL="0" ### TELEGRAM ###
SKYPE_VAL="0" ### SKYPE ###
DBOX_VAL="0" ### DROPBOX ###
VBOX_VAL="0" ### VIRTUAL BOX ###
CHROME_VAL="0" ### GOOGLE CHROME ###
WINE_VAL="0" ### WINE ###
APM_CONF="0" ### APM CONF ###
DEVEL_VAL="0" ### DEVEL TOOLS ###
SERVER_VAL="0" ### SERVER TOOLS ###
AV_VAL="0" ### ANTIVIRUS ###
DUCKDNS_VAL="0" ###DUCKDNS###
OWNCL_VAL="0" ###OWNCLOUD CLIENT###
GNOME_SW="0" ### GNOME APPS ###
POLUTILS="0" ### POL UTILS ###

SPOL_UTILS="0" ### SERVER POL UTILS ###
PWT_VAL="0" ### Powertop on boot - PLEASE NOTE: test manually first, use command "powertop --auto-tune" as root.

### CONFIGURATIONS ###

APM_CONF="0" # Set to "1" this option to enable auto conf for APM.
APM_VAL=254 ### APM setup ### available only if APM_CONF=1





### DO NOT EDIT BELOW THIS LINE ###

### REPOSITORY ###
MSFONTURL="http://sourceforge.net/projects/mscorefonts2/files/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm"
SKYPE_URL="http://www.skype.com/go/getskype-linux-beta-fc10"
GEARTH64_URL="http://dl.google.com/dl/earth/client/current/google-earth-stable_current_x86_64.rpm"
GEARTH_URL="http://dl.google.com/dl/earth/client/current/google-earth-stable_current_i386.rpm"

### PACKAGES LIST ###

APPS="unrar p7zip p7zip-plugins cabextract nano lynx libXp usb_modeswitch pdfjam djvulibre djvulibre-mozplugin evince-djvu hdparm faad2 gnupg2 mmv sane-backends sane-backends-libs sane-frontends libsane-hpaio hplip icoutils chntpw dbus-x11 xdotool exfat-utils fuse-exfat kernel-tools i7z cpulimit bchunk xmedcon samba samba-common samba-client libsmbclient system-config-samba samba-winbind smartmontools hddtemp htop powertop meld extundelete"

GNOME_APPS="transmission firewall-config dcraw unoconv clamtk youtube-dl libva-intel-driver libva-vdpau-driver libva-utils ffmpeg ImageMagick xine-lib-extras-freeworld gstreamer1 gstreamer1-plugins-good gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly gstreamer1-libav gstreamer-plugins-ugly gstreamer-plugins-farsight gstreamer-ffmpeg gstreamer-plugins-bad gstreamer-plugins-schroedinger libtheora libvorbis libogg dirac dirac-libs schroedinger firefox java-openjdk icedtea-web gnome-music gnome-maps gnome-photos gnome-documents gimp xsane-gimp xsane gnome-weather gnome-calendar bijiben xournal gnome-logs gnome-sound-recorder gnome-books gnome-todo audacity-freeworld polari brasero gnome-boxes deja-dup eog totem pitivi openshot rhythmbox seahorse nautilus-image-converter gnome-terminal-nautilus gparted simple-scan gimagereader-gtk tesseract tesseract-langpack-ita gnome-tweak-tool easytag epiphany gscan2pdf gnome-power-manager gnome-multi-writer pdfshuffler gnome-battery-bench vino vinagre gthumb liveusb-creator stellarium vlc gpredict transmageddon pavucontrol dosbox inkscape libreoffice-calc libreoffice-core libreoffice-draw libreoffice-graphicfilter libreoffice-impress libreoffice-math libreoffice-opensymbol-fonts libreoffice-pdfimport libreoffice-ure libreoffice-writer libreoffice-xsltfilter libreoffice-langpack-it impressive x264 filezilla vorbis-tools soundconverter tracker-preferences gedit-plugins"

DEVEL_TOOLS="python-devel python-matplotlib gcc gcc-c++ libgomp libgcc libstdc++ openmpi gcc-gfortran compat-libstdc++-33 make doxygen doxygen-doxywizard scons texlive-babel-italian texlive-babel-italian-doc texlive-greek-fontenc texlive-esint texlive-esint-type1 texlive-wrapfig texlive-multirow xmlto autoconf automake xmlto-tex lyx latexila git mercurial devassistant octave"

SERVER_TOOLS="owncloud-httpd owncloud-mysql mariadb mariadb-server mod_ssl cockpit minidlna letsencrypt sendmail mailx"

### USER COMMANDS ###

function user_commands
{
####################### TYPE YOUR CUSTOM COMMANDS UNDER THIS LINE
echo

}

#####FUNCTIONS BLOCK#####

function install_flash
{

	if [[ `$INST_C list installed | grep flash-plugin` == "" ]]
		then
			echo "#########################"
			echo "Installing Adobe Flash..."
			echo "#########################"
			

			if [[ `$INST_C list installed | grep adobe-release` == "" ]]
			then
				if [ $my_arch == "x86_64" ]
				then 
					rpm -Uvh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
				else
					rpm -Uvh http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm
				fi
			fi

		$INST_C $inst_opt install flash-plugin
	fi

}


function install_dropbox
{
if [[ $DBOX_VAL == "1" ]]
then
		echo "########################"
		echo "Installing Dropbox..."
		echo "########################"

		$INST_C $inst_opt install dropbox nautilus-dropbox
fi
}

function install_telegram
{
if [[ $TELEGRAM_VAL == "1" ]]
then
		if [[ ! -f /usr/sbin/Telegram/Telegram ]]
		then
			echo "######################"
			echo "Installing Telegram..."
			echo "######################"

			#dnf copr enable rommon/telegram
			#$INST_C $inst_opt install telegram-desktop
			
			### CLASSIC METHOD ###
			if [ $my_arch == "x86_64" ]
			then 
				wget https://tdesktop.com/linux
				tar -xvf linux
			else
				wget https://tdesktop.com/linux32
				tar -xvf linux32
			fi

			mv Telegram/ /usr/sbin/
			rm -f linux*

			touch telegram.desktop

			echo '[Desktop Entry]' >> telegram.desktop
			echo 'Encoding=UTF-8' >> telegram.desktop
			echo 'Name=Telegram' >> telegram.desktop
			echo 'Exec=/usr/sbin/Telegram/Telegram' >> telegram.desktop
			echo 'Type=Application' >> telegram.desktop
			echo 'Categories=Network;' >> telegram.desktop

			chown $USER telegram.desktop

			cp telegram.desktop /home/$USER/.local/share/applications/telegram.desktop

			rm telegram.desktop
		fi
fi
}

function install_pol_utils
{
if [[ $POLUTILS == "1" ]]
then

			echo "#######################"
			echo "Installing Pol Utils..."
			echo "#######################"

			wget $PLEONI_WEB/PolRepo/SimpleBackup
			wget $PLEONI_WEB/PolRepo/ytHelper
			wget $PLEONI_WEB/PolRepo/webm_converter			

			chmod +x SimpleBackup
			chmod +x ytHelper
			chmod +x webm_converter	

			cp SimpleBackup /usr/sbin/SimpleBackup
			cp ytHelper /usr/sbin/ytHelper
			cp webm_converter /usr/sbin/webm_converter

			rm SimpleBackup
			rm ytHelper 
			rm webm_converter

			touch SimpleBackup.desktop

			echo '[Desktop Entry]' >> SimpleBackup.desktop
			echo 'Encoding=UTF-8' >> SimpleBackup.desktop
			echo 'Name=Simple Backup' >> SimpleBackup.desktop
			echo 'Exec=/usr/sbin/SimpleBackup' >> SimpleBackup.desktop
			echo 'Type=Application' >> SimpleBackup.desktop

			chown $USER SimpleBackup.desktop

			mv SimpleBackup.desktop /home/$USER/.local/share/applications/


			touch ytHelper.desktop

			echo '[Desktop Entry]' >> ytHelper.desktop
			echo 'Encoding=UTF-8' >> ytHelper.desktop
			echo 'Name=Youtube Helper' >> ytHelper.desktop
			echo 'Exec=/usr/sbin/ytHelper' >> ytHelper.desktop
			echo 'Type=Application' >> ytHelper.desktop

			chown $USER ytHelper.desktop

			mv ytHelper.desktop /home/$USER/.local/share/applications/

			touch webmConverter.desktop

			echo '[Desktop Entry]' >> webmConverter.desktop
			echo 'Encoding=UTF-8' >> webmConverter.desktop
			echo 'Name=WEBM Converter' >> webmConverter.desktop
			echo 'Exec=/usr/sbin/webm_converter' >> webmConverter.desktop
			echo 'Type=Application' >> webmConverter.desktop

			chown $USER webmConverter.desktop

			mv webmConverter.desktop /home/$USER/.local/share/applications/
fi
}

function apm_setup
{
if [[ $APM_CONF == "1" ]]
then
	echo
	echo "Type APM to setup (e.g. 254):"
	read APM_VAL
	echo
	echo "Configuring APM settings..."
	echo
	echo "hdparm -B $APM_VAL /dev/sda" >> /usr/sbin/user-custom-boot.sh

	if [[ `more /usr/lib/systemd/system-sleep/50_myparams1 | grep hdparm` == "" ]] && [[ `more /etc/pm/sleep.d/50_myparams2 | grep hdparm` == "" ]]
	then 
		touch 50_myparams1
		echo '#!/bin/sh' >> 50_myparams1 
		echo 'case $1 in' >> 50_myparams1 
		echo '	pre)' >> 50_myparams1
		echo '	;;' >> 50_myparams1
		echo '	post)' >> 50_myparams1
		echo '	hdparm -B '$APM_VAL' /dev/sda' >> 50_myparams1
		echo '	;;' >> 50_myparams1
		echo 'esac' >> 50_myparams1

		cp 50_myparams1 /usr/lib/systemd/system-sleep/50_myparams1
		chmod +x /usr/lib/systemd/system-sleep/50_myparams1
		rm -f 50_myparams1

		touch 50_myparams2
		echo '#!/bin/sh' >> 50_myparams2 
		echo 'case $1 in' >> 50_myparams2 
		echo '	hibernate|suspend)' >> 50_myparams2
		echo '	;;' >> 50_myparams2
		echo '	resume|thaw)' >> 50_myparams2
		echo '	hdparm -B '$APM_VAL' /dev/sda' >> 50_myparams2
		echo '	;;' >> 50_myparams2
		echo 'esac' >> 50_myparams2

		cp 50_myparams2 /etc/pm/sleep.d/50_myparams2
		chmod +x /etc/pm/sleep.d/50_myparams2
		rm -f 50_myparams2
	else
		echo
		echo "Configuration files for APM already exist."
		echo "Nothing done."
		echo
		sleep 2
	fi
	echo
	echo "...done."
	echo
fi
}

function setup_duckdns
{
	echo
	echo "###########################"
	echo "DuckDNS SETUP"
	echo "###########################"
	echo
	echo "Enter your Duck DNS sub-domain name"
	read domainName
	mySubDomain="${domainName%%.*}"
	duckDomain="${domainName#*.}"
	if [ "$duckDomain" != "duckdns.org" ] && [ "$duckDomain" != "$mySubDomain" ] || [ "$mySubDomain" = "" ]
	then 
		echo "Invalid domain name."
	else
		# Get Token value

		echo "Enter your Duck DNS Token value (Check spaces)"
		read duckToken

		echo "Enter your Duck DNS time refresh (1h,1d,1w...)"
		read duckTime

		echo
		echo "Your domain name is $mySubDomain.duckdns.org"
		echo "Your token value is $duckToken"
		echo "Refresh Time is $duckTime"
		echo
		echo "Are you sure? (y/n)"
		read duck_sure
		echo

		if [[ $duck_sure == "y" ]]
		then
			echo "Esecuzione DuckDNS"
			#Salvataggio dello script
			echo "echo url=\"https://www.duckdns.org/update?domains=$mySubDomain&token=$duckToken&ip=\" | curl -k -o duck.log -K -" > duck.sh
			chmod +x duck.sh

			sh duck.sh

			mv duck.sh /usr/sbin/

			#Creazione del servizio

			if [[ ! -f /etc/systemd/system/duckdns.service ]]
				then
					touch /etc/systemd/system/duckdns.service

					echo '[Unit]' >> /etc/systemd/system/duckdns.service
					echo 'Description=DuckDNS Refresh Service' >> /etc/systemd/system/duckdns.service
					echo ' ' >> /etc/systemd/system/duckdns.service
					echo '[Service]' >> /etc/systemd/system/duckdns.service
					echo 'Type=simple' >> /etc/systemd/system/duckdns.service
					echo 'WorkingDirectory=/usr/sbin' >> /etc/systemd/system/duckdns.service
					echo 'ExecStart=/bin/bash duck.sh' >> /etc/systemd/system/duckdns.service
					echo ' ' >> /etc/systemd/system/duckdns.service
					echo '[Install]' >> /etc/systemd/system/duckdns.service
					echo 'WantedBy=multi-user.target' >> /etc/systemd/system/duckdns.service



					touch /etc/systemd/system/duckdns.timer

					echo '[Unit]' >> /etc/systemd/system/duckdns.timer
					echo 'Description=DuckDNS Refresh Timer' >> /etc/systemd/system/duckdns.timer
					echo ' ' >> /etc/systemd/system/duckdns.timer
					echo '[Timer]' >> /etc/systemd/system/duckdns.timer
					echo 'OnBootSec=10min' >> /etc/systemd/system/duckdns.timer
					echo "OnUnitActiveSec=$duckTime" >> /etc/systemd/system/duckdns.timer
					echo 'Unit=duckdns.service' >> /etc/systemd/system/duckdns.timer
					echo ' ' >> /etc/systemd/system/duckdns.timer
					echo '[Install]' >> /etc/systemd/system/duckdns.timer
					echo 'WantedBy=multi-user.target' >> /etc/systemd/system/duckdns.timer

					systemctl enable duckdns.timer
					systemctl start duckdns.timer
			
			fi
			echo
			echo "DuckDNS test result is:"
			more duck.log
			rm -f duck.log
			echo
		else
			echo "DuckDNS setup canceled."
		fi
	fi


}

function setup_autoupdate
{
	echo
	echo "###########################"
	echo "AutoUpdate SETUP"
	echo "###########################"
	echo
	echo
	echo "Enter clock time of AutoUpdate (hh:mm:ss):"
	read suspTime
	echo
	echo "Auto Update will occur on 1st, 14th and 28th of month at the time you've selected."
	echo
	echo "Are you sure? (y/n)"
	read susp_sure
	echo

		if [[ $susp_sure == "y" ]]
		then
			echo "Esecuzione Setup Auto Update"
			#Salvataggio dello script
			echo "dnf -y update > /usr/sbin/auto_update_log" >> auto_update.sh
			echo "" >> auto_update.sh			
			echo "#echo 'In allegato il log di aggiornamento di sistema.' | mailx -s 'Server - Log aggiornamento di sistema' -S sendwait -a /usr/sbin/auto_update.log mail@mail.com" >> auto_update.sh

			echo "reboot" >> auto_update.sh
			chmod +x auto_update.sh

			mv auto_update.sh /usr/sbin/

			#Creazione del servizio


			if [[ ! -f /etc/systemd/system/auto_update.service ]]
				then
					touch /etc/systemd/system/auto_update.service

					echo '[Unit]' >> /etc/systemd/system/auto_update.service
					echo 'Description=AutoUpdate Service' >> /etc/systemd/system/auto_update.service
					echo ' ' >> /etc/systemd/system/auto_update.service
					echo '[Service]' >> /etc/systemd/system/auto_update.service
					echo 'Type=simple' >> /etc/systemd/system/auto_update.service
					echo 'WorkingDirectory=/usr/sbin' >> /etc/systemd/system/auto_update.service
					echo 'ExecStart=/bin/bash auto_update.sh' >> /etc/systemd/system/auto_update.service
					echo ' ' >> /etc/systemd/system/auto_update.service
					echo '[Install]' >> /etc/systemd/system/auto_update.service
					echo 'WantedBy=multi-user.target' >> /etc/systemd/system/auto_update.service


					touch /etc/systemd/system/auto_update.timer

					echo '[Unit]' >> /etc/systemd/system/auto_update.timer
					echo 'Description=Auto Suspend Timer' >> /etc/systemd/system/auto_update.timer
					echo ' ' >> /etc/systemd/system/auto_update.timer
					echo '[Timer]' >> /etc/systemd/system/auto_update.timer
					echo "OnCalendar=*-*-1,14,28 $suspTime" >> /etc/systemd/system/auto_update.timer
					echo "Persistent=True" >> /etc/systemd/system/auto_update.timer
					echo 'Unit=auto_update.service' >> /etc/systemd/system/auto_update.timer
					echo ' ' >> /etc/systemd/system/auto_update.timer
					echo '[Install]' >> /etc/systemd/system/auto_update.timer
					echo 'WantedBy=multi-user.target' >> /etc/systemd/system/auto_update.timer

					systemctl enable auto_update.timer
					systemctl start auto_update.timer
			
			fi
		else
			echo "Auto Update setup canceled."
		fi

}

function setup_autosuspend
{
	echo
	echo "###########################"
	echo "AutoSuspend SETUP"
	echo "###########################"
	echo
	echo "Enter clock time of standby (hh:mm:ss)"
	read suspTime

	# Get Token value

	echo "Enter stand by duration (seconds):"
	read suspDuration
	echo
	echo "Are you sure? (y/n)"
	read susp_sure
	echo

		if [[ $susp_sure == "y" ]]
		then
			echo "Esecuzione Auto suspend"

			#Salvataggio dello script
			echo "rtcwake -m mem -s $suspDuration" > auto_suspend.sh
			chmod +x auto_suspend.sh

			mv auto_suspend.sh /usr/sbin/

			#Creazione del servizio

			if [[ ! -f /etc/systemd/system/auto_suspend.service ]]
				then
					touch /etc/systemd/system/auto_suspend.service

					echo '[Unit]' >> /etc/systemd/system/auto_suspend.service
					echo 'Description=Autosuspend Service' >> /etc/systemd/system/auto_suspend.service
					echo ' ' >> /etc/systemd/system/auto_suspend.service
					echo '[Service]' >> /etc/systemd/system/auto_suspend.service
					echo 'Type=simple' >> /etc/systemd/system/auto_suspend.service
					echo 'WorkingDirectory=/usr/sbin' >> /etc/systemd/system/auto_suspend.service
					echo 'ExecStart=/bin/bash auto_suspend.sh' >> /etc/systemd/system/auto_suspend.service
					echo ' ' >> /etc/systemd/system/auto_suspend.service
					echo '[Install]' >> /etc/systemd/system/auto_suspend.service
					echo 'WantedBy=multi-user.target' >> /etc/systemd/system/auto_suspend.service


					touch /etc/systemd/system/auto_suspend.timer

					echo '[Unit]' >> /etc/systemd/system/auto_suspend.timer
					echo 'Description=Auto Suspend Timer' >> /etc/systemd/system/auto_suspend.timer
					echo ' ' >> /etc/systemd/system/auto_suspend.timer
					echo '[Timer]' >> /etc/systemd/system/auto_suspend.timer
					echo "OnCalendar=*-*-* $suspTime" >> /etc/systemd/system/auto_suspend.timer
					echo "Persistent=True" >> /etc/systemd/system/auto_suspend.timer
					echo 'Unit=auto_suspend.service' >> /etc/systemd/system/auto_suspend.timer
					echo ' ' >> /etc/systemd/system/auto_suspend.timer
					echo '[Install]' >> /etc/systemd/system/auto_suspend.timer
					echo 'WantedBy=multi-user.target' >> /etc/systemd/system/auto_suspend.timer

					systemctl enable auto_suspend.timer
					systemctl start auto_suspend.timer
			
			fi
		else
			echo "Auto Suspend setup canceled."
		fi

}

function setup_autobackup
{

	echo
	echo "###########################"
	echo "AutoBackup SETUP"
	echo "###########################"
	echo
	echo
	echo "Type source folder to backup (with final '/'):"
	read bkupSourceFolder
	echo
	echo
	echo "Type destination path of external drive:"
	read bkupTargetFolder
	echo
	echo "Enter backup timing"
	echo "e.g. *-*-1,15 4:00:00 is the 1st and the 15th of every month of every year at 4 AM"
	read bkupFreq
	echo
	echo "Are you sure? (y/n)"
	read bkup_sure
	echo

		if [[ $bkup_sure == "y" ]]
		then
			echo "Esecuzione Auto Backup"
			#Salvataggio dello script

			echo "rm -f /usr/sbin/auto_bkup_log" >> auto_bkup.sh
			echo "rsync -avd --delete --progress --log-file=/usr/sbin/auto_bkup_log --stats $bkupSourceFolder $bkupTargetFolder" >> auto_bkup.sh
			echo "" >> auto_bkup.sh
			echo "#echo 'In allegato il log di backup.' | mailx -s 'BackUp Giornaliero' -S sendwait -a /usr/sbin/auto_bkup.log mail@mail.com" >> auto_bkup.sh



			chmod +x auto_bkup.sh

			mv auto_bkup.sh /usr/sbin/

			#Creazione del servizio



			if [[ ! -f /etc/systemd/system/auto_bkup.service ]]
				then
					touch /etc/systemd/system/auto_bkup.service

					echo '[Unit]' >> /etc/systemd/system/auto_bkup.service
					echo 'Description=AutoBackup Service' >> /etc/systemd/system/auto_bkup.service
					echo ' ' >> /etc/systemd/system/auto_bkup.service
					echo '[Service]' >> /etc/systemd/system/auto_bkup.service
					echo 'Type=simple' >> /etc/systemd/system/auto_bkup.service
					echo 'WorkingDirectory=/usr/sbin' >> /etc/systemd/system/auto_bkup.service
					echo 'ExecStart=/bin/bash auto_bkup.sh' >> /etc/systemd/system/auto_bkup.service
					echo ' ' >> /etc/systemd/system/auto_bkup.service
					echo '[Install]' >> /etc/systemd/system/auto_bkup.service
					echo 'WantedBy=multi-user.target' >> /etc/systemd/system/auto_bkup.service


					touch /etc/systemd/system/auto_bkup.timer

					echo '[Unit]' >> /etc/systemd/system/auto_bkup.timer
					echo 'Description=AutoBackup Timer' >> /etc/systemd/system/auto_bkup.timer
					echo ' ' >> /etc/systemd/system/auto_bkup.timer
					echo '[Timer]' >> /etc/systemd/system/auto_bkup.timer
					echo "OnCalendar=$bkupFreq" >> /etc/systemd/system/auto_bkup.timer
					echo "Persistent=True" >> /etc/systemd/system/auto_bkup.timer
					echo 'Unit=auto_bkup.service' >> /etc/systemd/system/auto_bkup.timer
					echo ' ' >> /etc/systemd/system/auto_bkup.timer
					echo '[Install]' >> /etc/systemd/system/auto_bkup.timer
					echo 'WantedBy=multi-user.target' >> /etc/systemd/system/auto_bkup.timer

					systemctl enable auto_bkup.timer
					systemctl start auto_bkup.timer
			
			fi
		else
			echo "Auto Backup setup canceled."
		fi


}

function setup_autocert
{
	echo
	echo "###########################"
	echo "AutoRenew SSL Cert"
	echo "###########################"
	echo
	echo
	echo "Enter challenge key for web verification (random):"
	read chKey
	echo "Enter challenge file for web verification (random):"
	read chFile
	echo "Enter Email Address:"
	read email
	echo "Enter domain (e.g. www.example.com):"
	read domain
	echo
	echo "Enter SSL Cert renew frequency:"
	echo "e.g. *-*-1,15 4:00:00 is the 1st and the 15th of every month of every year at 4 AM"
	read renewFreq
	echo
	echo "Are you sure? (y/n)"
	read susp_sure
	echo

		if [[ $susp_sure == "y" ]]
		then
			systemctl stop httpd
			echo "Esecuzione Auto Setup certificato SSL:"
			### CREAZIONE CHIAVE VERIFICA LETSENCRYPT ###
			cd /var/www/html
			mkdir -p .well-known/acme-challenge
			echo $chKey > .well-known/acme-challenge/$chFile

			### CREAZIONE CERTIFICATO ####
			letsencrypt --text --renew-by-default --email $email --domains $domain --agree-tos --standalone --standalone-supported-challenges http-01 certonly

			### INSTALLAZIONE CERTIFICATO ###
			ln -s /etc/letsencrypt/live/$domain/cert.pem /etc/pki/tls/certs/$domain.crt
			ln -s /etc/letsencrypt/live/$domain/chain.pem /etc/pki/tls/certs/$domain.chain.crt
			ln -s /etc/letsencrypt/live/$domain/privkey.pem /etc/pki/tls/private/$domain.key
			cp /etc/httpd/conf.d/ssl.conf{,.backup}
			sed -i "s@\(SSLCertificateFile\) .*@\1 /etc/pki/tls/certs/$domain.crt@" /etc/httpd/conf.d/ssl.conf
			sed -i "s@\(SSLCertificateKeyFile\) .*@\1 /etc/pki/tls/private/$domain.key@" /etc/httpd/conf.d/ssl.conf
			sed -i "s@#\(SSLCertificateChainFile\) .*@\1 /etc/pki/tls/certs/$domain.chain.crt@" /etc/httpd/conf.d/ssl.conf

			### SELINUX ###
			semanage fcontext -a -t cert_t '/etc/letsencrypt/(archive|live)(/.*)?'
			restorecon -Rv /etc/letsencrypt
			
			#Creazione dello script
			echo "letsencrypt -d $domain --renew-by-default -m $email --agree-tos -t --webroot -w /var/www/html certonly" >> auto_ssl_renew.sh
			echo "systemctl reload httpd" >> auto_ssl_renew.sh

			echo "" >> auto_ssl_renew.sh
			echo "#if [[ `more /var/log/letsencrypt/letsencrypt.log | grep 'Congratulations'` != '' ]]" >> auto_ssl_renew.sh
			echo "#then" >> auto_ssl_renew.sh
			echo "#echo 'Certificato SSL rinnovato correttamente.' | mailx -s 'Server - Rinnovo Certificato OK' -S sendwait mail@mail.com" >> auto_ssl_renew.sh
echo "#else" >> auto_ssl_renew.sh
echo "#echo 'ATTENZIONE: errore nel rinnovo del certificato SSL.' | mailx -s 'Spol Server - (!) Rinnovo Certificato KO (!)' -S sendwait mail@mail.com" >> auto_ssl_renew.sh
echo "#fi" >> auto_ssl_renew.sh
	

			chmod +x auto_ssl_renew.sh

			mv auto_ssl_renew.sh /usr/sbin/


			#Creazione del servizio

			if [[ ! -f /etc/systemd/system/auto_ssl_renew.service ]]
				then
					touch /etc/systemd/system/auto_ssl_renew.service

					echo '[Unit]' >> /etc/systemd/system/auto_ssl_renew.service
					echo 'Description=Automatically renew the SSL certificate' >> /etc/systemd/system/auto_ssl_renew.service
					echo ' ' >> /etc/systemd/system/auto_ssl_renew.service
					echo '[Service]' >> /etc/systemd/system/auto_ssl_renew.service
					echo 'Type=oneshot' >> /etc/systemd/system/auto_ssl_renew.service
					echo 'WorkingDirectory=/usr/sbin' >> /etc/systemd/system/auto_ssl_renew.service
					echo 'ExecStart=/bin/bash auto_ssl_renew.sh' >> /etc/systemd/system/auto_ssl_renew.service
					echo ' ' >> /etc/systemd/system/auto_ssl_renew.service
					echo '[Install]' >> /etc/systemd/system/auto_ssl_renew.service
					echo 'WantedBy=multi-user.target' >> /etc/systemd/system/auto_ssl_renew.service


					touch /etc/systemd/system/auto_ssl_renew.timer

					echo '[Unit]' >> /etc/systemd/system/auto_ssl_renew.timer
					echo 'Description=Timer auto renew SSL certificate' >> /etc/systemd/system/auto_ssl_renew.timer
					echo ' ' >> /etc/systemd/system/auto_ssl_renew.timer
					echo '[Timer]' >> /etc/systemd/system/auto_ssl_renew.timer
					echo "OnCalendar=$renewFreq" >> /etc/systemd/system/auto_ssl_renew.timer
					echo "Persistent=True" >> /etc/systemd/system/auto_ssl_renew.timer
					echo 'Unit=auto_ssl_renew.service' >> /etc/systemd/system/auto_ssl_renew.timer
					echo ' ' >> /etc/systemd/system/auto_ssl_renew.timer
					echo '[Install]' >> /etc/systemd/system/auto_ssl_renew.timer
					echo 'WantedBy=multi-user.target' >> /etc/systemd/system/auto_ssl_renew.timer

					systemctl daemon-reload

					sleep 5

					systemctl enable auto_ssl_renew.timer
					systemctl start auto_ssl_renew.timer
					
					systemctl start httpd
			
			fi
		else
			echo "Auto Setup SSL Cert canceled."
		fi

}

function setup_samba
{
	echo
	echo "###########################"
	echo "Samba SETUP"
	echo "###########################"
	echo
	echo
	echo "Enter path of folder you want to share:"
	read smb_path
	echo "Enter user that can access to the folder:"
	read smb_user
	echo
	echo "Are you sure? (y/n)"
	read susp_sure
	echo

		if [[ $susp_sure == "y" ]]
		then
			echo "Esecuzione Auto Setup SAMBA:"
			echo
			dnf -y install samba samba-client
			smbpasswd -a $smb_user
			chown $smb_user $smb_path
			chmod 777 -R $smb_path
			cp /etc/samba/smb.conf /etc/samba/smb.conf.bkup
			echo "[share_$smb_user]" >> /etc/samba/smb.conf
			echo "path = $smb_path" >> /etc/samba/smb.conf
			echo "valid users = $smb_user" >> /etc/samba/smb.conf
			echo "read only = no" >> /etc/samba/smb.conf
			echo "writable = yes" >> /etc/samba/smb.conf
			echo "browseable= yes" >> /etc/samba/smb.conf

			chcon -Rt samba_share_t $smb_path
			
			firewall-cmd --add-service=samba --permanent
			firewall-cmd --add-service=samba-client --permanent

			systemctl enable smb.service
			systemctl enable nmb.service

			systemctl start smb.service
			systemctl start nmb.service
			
		else
			echo "Auto Setup SAMBA canceled."
		fi

}

function setup_transmission
{

	echo
	echo "##############################"
	echo "Transmission AutoManager SETUP"
	echo "##############################"
	echo
	echo "Type path for Auto Add:"
	read trsm_path
	echo "Do you want to move files after complete? (y/n)"
	read mv_risp
	if [[ $mv_risp == "y" ]]
	then
		echo "Type path of target folder for completed files:"
		read trsm_complete_path
	fi
	echo
	echo "Are you sure? (y/n)"
	read susp_sure
	echo

		if [[ $susp_sure == "y" ]]
		then
			dnf -y install transmission-daemon transmission-remote-cli
			cd /var/lib/transmission/Downloads
			mkdir complete
			systemctl start transmission-daemon.service
			sleep 2
			systemctl stop transmission-daemon.service	
			sed -i '/    "download-dir": "\/var\/lib\/transmission\/Downloads", /c\    "download-dir": "\/var\/lib\/transmission\/Downloads\/complete", ' /var/lib/transmission/.config/transmission-daemon/settings.json 
			sed -i '/    "incomplete-dir-enabled": false, /c\    "incomplete-dir-enabled": true, ' /var/lib/transmission/.config/transmission-daemon/settings.json 
			sed -i '/    "speed-limit-up": 100, /c\    "speed-limit-up": 10, ' /var/lib/transmission/.config/transmission-daemon/settings.json
			sed -i '/    "speed-limit-up-enabled": false, /c\    "speed-limit-up-enabled": true, ' /var/lib/transmission/.config/transmission-daemon/settings.json 

			chgrp transmission -R /var/lib/transmission/Downloads/complete
			chown transmission -R /var/lib/transmission/Downloads/complete

			systemctl enable transmission-daemon.service
			systemctl start transmission-daemon.service

			#Salvataggio dello script

			echo "for torrentid in `transmission-remote --list | sed -e '1d;$d;s/^ *//' | cut --only-delimited --delimiter=" " --fields=1`" >> auto_add_trsm.sh
			echo "do" >> auto_add_trsm.sh
			echo "if [[ `transmission-remote -t $torrentid --info | grep ""Percent Done: 100%""` != """" ]]" >> auto_add_trsm.sh
			echo "then" >> auto_add_trsm.sh
			echo "transmission-remote -t $torrentid --remove" >> auto_add_trsm.sh
			echo "fi" >> auto_add_trsm.sh
			echo "done" >> auto_add_trsm.sh
			echo "" >> auto_add_trsm.sh
			echo "for file in $trsm_path/*.torrent" >> auto_add_trsm.sh
			echo "do" >> auto_add_trsm.sh
			echo "transmission-remote -a ""$file""" >> auto_add_trsm.sh
			echo "rm -f ""$file""" >> auto_add_trsm.sh
			echo "done" >> auto_add_trsm.sh
			echo "" >> auto_add_trsm.sh
			if [[ $mv_risp == "y" ]]
			then
				echo "mv /var/lib/transmission/Downloads/complete/* $trsm_complete_path/" >> auto_add_trsm.sh
				echo "chcon -Rt samba_share_t $trsm_complete_path" >> auto_add_trsm.sh
				echo "chmod 777 -R $trsm_complete_path" >> auto_add_trsm.sh
			fi

			chmod +x auto_add_trsm.sh

			mv auto_add_trsm.sh /usr/sbin/


			#Creazione del servizio

			if [[ ! -f /etc/systemd/system/auto_add_trsm.service ]]
				then
					touch /etc/systemd/system/auto_add_trsm.service

					echo '[Unit]' >> /etc/systemd/system/auto_add_trsm.service
					echo 'Description=AutoAddTransmissionService' >> /etc/systemd/system/auto_add_trsm.service
					echo ' ' >> /etc/systemd/system/auto_add_trsm.service
					echo '[Service]' >> /etc/systemd/system/auto_add_trsm.service
					echo 'Type=simple' >> /etc/systemd/system/auto_add_trsm.service
					echo "WorkingDirectory=/usr/sbin" >> /etc/systemd/system/auto_add_trsm.service
					echo 'ExecStart=/bin/bash auto_add_trsm.sh' >> /etc/systemd/system/auto_add_trsm.service
					echo ' ' >> /etc/systemd/system/auto_add_trsm.service
					echo '[Install]' >> /etc/systemd/system/auto_add_trsm.service
					echo 'WantedBy=multi-user.target' >> /etc/systemd/system/auto_add_trsm.service


					touch /etc/systemd/system/auto_add_trsm.timer

					echo '[Unit]' >> /etc/systemd/system/auto_add_trsm.timer
					echo 'Description=AutoAddTransmissionTimer' >> /etc/systemd/system/auto_add_trsm.timer
					echo ' ' >> /etc/systemd/system/auto_add_trsm.timer
					echo '[Timer]' >> /etc/systemd/system/auto_add_trsm.timer
					echo 'OnBootSec=5min' >> /etc/systemd/system/auto_add_trsm.timer
					echo "OnCalendar=*:0/15" >> /etc/systemd/system/auto_add_trsm.timer
					echo 'Unit=auto_add_trsm.service' >> /etc/systemd/system/auto_add_trsm.timer
					echo ' ' >> /etc/systemd/system/auto_add_trsm.timer
					echo '[Install]' >> /etc/systemd/system/auto_add_trsm.timer
					echo 'WantedBy=multi-user.target' >> /etc/systemd/system/auto_add_trsm.timer

					systemctl daemon-reload

					sleep 5

					systemctl enable auto_add_trsm.timer
					systemctl start auto_add_trsm.timer
			
			fi
		else
			echo "Auto Setup Transmission Server canceled."
		fi

}

function install_antivirus
{
if [[ $AV_VAL == "1" ]]
then
	if [[ `$INST_C list installed | grep clamav` == "" ]]
		then
		echo "########################"
		echo "Installing Antivirus..."
		echo "########################"

		$INST_C $inst_opt install clamav clamav-update
		sed -i "s%Example%#Example%g" /etc/freshclam.conf
		echo "Updating Antivirus, this could take a while..."
	 	freshclam
	fi
fi
}


function install_skype
{
if [[ $SKYPE_VAL == "1" ]]
then
	if [[ `$INST_C list installed | grep skype` == "" ]]
		then
		echo "########################"
		echo "Installing Skype..."
		echo "########################"
		
		wget -O skype.rpm $SKYPE_URL
		$INST_C $inst_opt --nogpgcheck install skype*.rpm
		rm -r skype*.rpm

	fi
fi
}

function install_team_viewer
{
if [[ $TV_VAL == "1" ]]
then
	echo "########################"
	echo "Installing TeamViewer..."
	echo "########################"

	if [[ `$INST_C list installed | grep teamviewer` == "" ]]
	then
		wget http://download.teamviewer.com/download/teamviewer.i686.rpm
		$INST_C $inst_opt install teamviewer.i686.rpm

		rm -f teamviewer.i686.rpm
	fi
fi
}


function install_office
{

### GOOGLE FONTS ####
if [[ $G_FONTS_VAL == "1" ]]
then
	echo "#########################"
	echo "Installing Google Fonts.."
	echo "#########################"
	
	if [[ ! -f /home/$USER/.fonts/googlefontdirectory/README ]]
	then
		mkdir /home/$USER/.fonts
		hg clone https://googlefontdirectory.googlecode.com/hg/ googlefontdirectory
		mv /home/$USER/googlefontdirectory /home/$USER/.fonts/
		chown $USER -R /home/$USER/.fonts
	fi
fi

### MICROSOFT FONTS ####
if [[ $M_FONTS_VAL == "1" ]]
then
	echo "#############################"
	echo "Installing Microsoft Fonts..."
	echo "#############################"

	wget $MSFONTURL
	$INST_C $inst_opt install msttcore*.rpm
	rm msttcore*.rpm
fi

}

function install_chrome
{
if [[ $CHROME_VAL == "1" ]]
then
	if [[ `$INST_C list installed | grep google-chrome` == "" ]]
		then
			echo "###########################"
			echo "Installing Google Chrome..."
			echo "###########################"

			touch google-chrome.repo
			echo '[google-chrome]' >> google-chrome.repo
			echo 'name=google-chrome - 32-bit' >> google-chrome.repo
			echo 'baseurl=http://dl.google.com/linux/chrome/rpm/stable/i386' >> google-chrome.repo
			echo 'enabled=1' >> google-chrome.repo
			echo 'gpgcheck=1' >> google-chrome.repo
			echo 'gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub' >> google-chrome.repo
			echo '    ' >> google-chrome.repo
			echo '[google-chrome]' >> google-chrome.repo
			echo 'name=google-chrome - 64-bit' >> google-chrome.repo
			echo 'baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64' >> google-chrome.repo
			echo 'enabled=1' >> google-chrome.repo
			echo 'gpgcheck=1' >> google-chrome.repo
			echo 'gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub' >> google-chrome.repo

			cp google-chrome.repo /etc/yum.repos.d/google-chrome.repo
			rm google-chrome.repo
			$INST_C $inst_opt install google-chrome-stable
		fi
fi
}

function install_wine
{
if [[ $WINE_VAL == "1" ]]
then
	if [[ `$INST_C list installed | grep wine` == "" ]]
		then
			echo "########################"
			echo "Installing Wine ..."
			echo "########################"
			
			$INST_C $inst_opt install wine cabextract
		fi

		wget http://winetricks.org/winetricks
		cp winetricks /usr/bin/winetricks
		chmod +x /usr/bin/winetricks
		rm -f winetricks
fi
}

function install_gearth
{
if [[ $GEARTH_VAL == "1" ]]
then
		echo "##########################"
		echo "Installing Google Earth..."
		echo "##########################"
	

			$INST_C $inst_opt install mesa-libGL.i686 bitstream-vera-fonts-common libxml2.i686 libSM.i686 libXi.i686 glib2.i686 libcanberra-gtk2.i686 freetype.i686 libXrender.i686 libXrandr.i686 libXfixes.i686 libXcursor.i686 libXinerama.i686 redhat-lsb.i686

			wget $GEARTH_URL

			rpm -Uvh --force google-earth*.rpm

			rm -f google-earth*.rpm
			
			### FIX DEL BUG SULLE COORDINATE ###
			sed -i "s%LD_LIBRARY_PATH=.:\$LD_LIBRARY_PATH ./googleearth-bin \"\$@\"%export LC_NUMERIC=en_US.UTF-8%g" /opt/google/earth/free/google-earth
			echo "LD_LIBRARY_PATH=.:\$LD_LIBRARY_PATH ./googleearth-bin \"\$@\"" >> /opt/google/earth/free/google-earth

fi
}

function install_vbox
{
if [[ $VBOX_VAL == "1" ]]
then
	if [[ `$INST_C list installed | grep VirtualBox` == "" ]]
	then
		echo "#########################"
		echo "Installing Virtual Box..."
		echo "#########################"
		
		### VIRTUAL BOX FREE ###
		#$INST_C $inst_opt install kernel-devel gcc dkms VirtualBox kmod-VirtualBox
		

		wget http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
		mv virtualbox.repo /etc/yum.repos.d/
		$INST_C $inst_opt install VirtualBox-5.0 kernel-devel kernel-headers gcc dkms
		usermod -a -G vboxusers $USER
	fi
fi
}

function install_pwm
{

### POWERTOP INSTALL AND AUTO TUNE ON BOOT ###
	if [[ $PWT_VAL == "1" ]]
	then

	$INST_C $inst_opt install powertop

		if [[ ! -f /etc/systemd/system/powertop.service ]]
		then
			touch /etc/systemd/system/powertop.service

			echo '[Unit]' >> /etc/systemd/system/powertop.service
			echo 'Description=Powertop tunings' >> /etc/systemd/system/powertop.service
			echo '[Service]' >> /etc/systemd/system/powertop.service
			echo 'Type=oneshot' >> /etc/systemd/system/powertop.service
			echo 'RemainAfterExit=no' >> /etc/systemd/system/powertop.service
			echo 'ExecStart=/usr/sbin/powertop --auto-tune' >> /etc/systemd/system/powertop.service
			echo '#"powertop --auto-tune" still needs a terminal for some reason.' >> /etc/systemd/system/powertop.service
			echo '#Possibly a bug?' >> /etc/systemd/system/powertop.service
			echo 'Environment="TERM=xterm"' >> /etc/systemd/system/powertop.service
			echo '[Install]' >> /etc/systemd/system/powertop.service
			echo 'WantedBy=multi-user.target' >> /etc/systemd/system/powertop.service

			systemctl enable powertop.service
		fi

	fi

}

function script_test
{
	if [ $(id -u) -ne 0 ]
	then
		echo
		echo "To run this script you must be root user."	
		START=0			
	else
		echo
		echo "Checking system configuration..."
		echo
	fi		
}

function welcome
{
if [[ $START == 1 ]]
then
	###PREINSTALLATION APPS###	
	echo
	echo "Preparing installation..."
	echo

	$INST_C $inst_opt install wget figlet screenfetch dialog


###INSTALL RPM FUSION###
	if [[ `$INST_C list installed | grep rpmfusion-free-release` == "" ]] || [[ `$INST_C list installed | grep rpmfusion-nonfree-release` == "" ]]
	then
		$INST_C -y install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

	fi
	echo
	echo "...OK"
	echo

###WELCOME MESSAGE###
	clear
	figlet "$PROGNAME $VERSION"
	echo
echo ",;;:;,"
echo "  ;;;;;"
echo "  ,:;;:;    ,'=."
echo "  ;:;:;' .=\" ,'_\"         $REL"
echo "  ':;:;,/  ,__:=@"
echo "   ';;:;  =./)_"
echo "     \`\"=\_  )_\"\`"
echo "          \`\`'\"\`"
echo
echo
sleep 3
if [[ $GUI_VAL = "1" ]]
then

cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
options=(1 "Update" on    # any option can be set to default to "on"
	 2 "GeneralApps" off
         3 "GnomeApps" off
         4 "Skype" off
         5 "BootPowerTop" off
         6 "Dropbox" off
         7 "Owncloud-client" off
         8 "APM Setup" off
         9 "TeamViewer" off
         10 "Antivirus" off
         11 "GoogleChrome" off
         12 "GoogleEarth" off
         13 "Wine" off
         14 "VirtualBox" off
         15 "TelegramClient" off
         16 "MicrosoftFonts" off
         17 "Google Fonts" off
         18 "PolUtils" off
         19 "DevelTools" off
         20 "ServerTools" off
         21 "ServerPolUtils" off) 
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

clear
for choice in $choices
do
    case $choice in
	1)
		UPDATE_VAL="1"
	;;

	2)
		GEN_APPS="1"
	;;
	
	3)
		GNOME_SW="1"
	;;

	4)
		SKYPE_VAL="1"
	;;

	5)
		PWT_VAL="1"
	;;

	6)
		DBOX_VAL="1"
	;;

	7)
		OWNCL_VAL="1"
	;;

	8)
		APM_CONF="1"
	;;

	9)
		TV_VAL="1"
	;;

	10)
		AV_VAL="1"
	;;

	11)
		CHROME_VAL="1"
	;;

	12)
		GEARTH_VAL="1"
	;;

	13)
		WINE_VAL="1"
	;;

	14)
		VBOX_VAL="1"
	;;

	15)
		TELEGRAM_VAL="1"
	;;

	16)
		M_FONTS_VAL="1"
	;;

	17)
		G_FONTS_VAL="1"
	;;

	18)
		POLUTILS="1"
	;;

	19)
		DEVEL_VAL="1"
	;;

	20)
		SERVER_VAL="1"
	;;

	21)
		SPOL_UTILS="1"
	;;
	esac
done

	echo
	echo "Installation setup completed."
	echo "Are you sure to continue? (y/n)"
	read sure_risp

	if [[ $sure_risp != "y" ]]
	then
		START="0"
		echo "Installation canceled."
	fi
	
fi
fi
}


function inst_prog
{

### SETUP OF STARTUP SCRIPT ###

if [[ ! -f /etc/systemd/system/user-custom-boot.service ]]
then

	touch user-custom-boot.sh
	echo '#!/bin/sh' >> user-custom-boot.sh
	echo '#' >> user-custom-boot.sh
	echo ' ' >> user-custom-boot.sh
	echo '### USER CUSTOM BOOT COMMANDS ###' >> user-custom-boot.sh
	
	mv user-custom-boot.sh /usr/sbin/

	touch user-custom-boot.service
	echo '[Unit]' >> user-custom-boot.service
	echo 'Description=User Custom Boot Service' >> user-custom-boot.service
	echo ' ' >> user-custom-boot.service
	echo '[Service]' >> user-custom-boot.service
	echo 'Type=simple' >> user-custom-boot.service
	echo 'WorkingDirectory=/usr/sbin' >> user-custom-boot.service
	echo 'ExecStart=/bin/bash user-custom-boot.sh' >> user-custom-boot.service
	echo ' ' >> user-custom-boot.service
	echo '[Install]' >> user-custom-boot.service
	echo 'WantedBy=multi-user.target' >> user-custom-boot.service

	mv user-custom-boot.service /etc/systemd/system/

	systemctl enable user-custom-boot.service

fi

###ADOBE FLASH###
if [[ $FLASH_VAL == "1" ]]
then
install_flash
fi

###GOOGLE CHROME###
install_chrome

#############APPS#################

if [[ $GEN_APPS == "1" ]]
then
echo
echo "####################################"
echo "# Intalling general applications...#"
echo "####################################"

	$INST_C $inst_opt install $APPS
fi

if [[ $GNOME_SW == "1" ]]
then
echo
echo "####################################"
echo "# Intalling GNOME applications...  #"
echo "####################################"

	$INST_C $inst_opt install $GNOME_APPS
fi

if [[ $DEVEL_VAL == "1" ]]
then
echo
echo "####################################"
echo "# Intalling DEVEL applications...  #"
echo "####################################"

	$INST_C $inst_opt install $DEVEL_TOOLS
fi

install_office

###SKYPE###
install_skype

###TELEGRAM###
install_telegram

###WINE###
install_wine

###GOOGLE EARTH###
install_gearth

###Virtual Box###
install_vbox

###REMOTE DEKSTOP - Team Viewer ###
install_team_viewer

###ANTIVIRUS###
install_antivirus

###Power management tools###
install_pwm

### CUSTOM RPM INSTALLATION ###
echo
echo "#######################################"
echo "# Intalling RPM in letinstall dir...  #"
echo "#######################################"
echo
$INST_C $inst_opt install *.rpm

###DROPBOX###
install_dropbox

###SERVER TOOLS###
if [[ $SERVER_VAL == "1" ]]
then
echo
echo "###################################"
echo "# Installing server tools...      #"
echo "###################################"
echo

	$INST_C $inst_opt install $SERVER_TOOLS
fi

###OWNCLOUD CLIENT###
if [[ $OWNCL_VAL == "1" ]]
then
	$INST_C $inst_opt install owncloud-client owncloud-client-nautilus
fi

###POL UTILS###
install_pol_utils

### APM SETTINGS ###

apm_setup

### SERVER POL UTILS ###
if [[ $SPOL_UTILS == "1" ]]
then
echo
echo "###################################"
echo "# Running SPOL Server setup script#"
echo "###################################"
echo

	### DUCK DNS ###
	setup_duckdns

	### AUTO SSL CERT SETUP ###
	setup_autocert

	### AUTO SUSPEND ###
	setup_autosuspend

	### AUTO BACKUP ###
	setup_autobackup

	### AUTO SAMBA SETUP ###
	setup_samba

	### AUTO TRANSMISSION SETUP ###
	setup_transmission

	### AUTO UPDATE SETUP ###
	setup_autoupdate

fi

### USER COMMANDS SCRIPT ###
echo
echo "############################"
echo "# Running user commands... #"
echo "############################"
echo

user_commands


}


####EXE####
if [[ $1 != "" ]]
then
	echo
	echo "Error. Wrong options."
	echo
	START=0
fi

####STARTING LETINSTALL####


	script_test
	
	welcome

	if [[ $START == 1 ]]
	then
		echo
		echo "##########################################################"
		echo "Starting selected operations..."
		echo "Don't halt your system until all operations are completed."
		echo "##########################################################"
		echo
		sleep 5

		if [[ $UPDATE_VAL == "1" ]]
		then
			echo "###########################"
			echo "Performing system update..."
			echo "###########################"

			$INST_C -y update
		fi		
			inst_prog
		echo
			screenfetch
		echo
		echo "##################################################################"
		echo "To run commands/script on boot, edit /usr/sbin/user-custom-boot.sh"
		echo "Operations completed. Probably a restart is required."
		echo "##################################################################"
		echo
		echo "Quitting..."
	fi
echo
exit $EXIT_SUCCESS
