#!/bin/bash

listdo="1.Change the dnf config.\n2.Enable RPMFusion and Flathub.\n3.Install mediaCodecs.\n4.Setup dnf-automatic.\n5.Install ibus-bamboo.\n6.Setup firmware.\n7.Setup battery life.\n8.H/W Video Decoding with VA-API.\n9.Set hostname.\n10.Install daily apps.\n\n"
title="Fedora setup script (by Harry)\n\n"

endline() {
	echo -e "done"
	read -rp "Press any key to continue" 
	clear
}

echo -ne $title
echo "List what this script do:"
echo -ne $listdo

read -rp "Press any key to continue" 

clear

# update
sudo dnf upgrade --refresh
sudo dnf autoremove -y
clear

echo -ne "1.Change the dnf config...\n"
sudo mv /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak
sudo cp config/dnf/dnf.conf /etc/dnf/dnf.conf
endline

echo -ne "1.Change the dnf config: done\n"
echo -ne "2.Enable RPMFusion and Flathub...\n"
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm -y
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm -y
sudo dnf upgrade --refresh -y
sudo dnf groupupdate core -y
sudo dnf install rpmfusion-free-release-tainted -y
sudo dnf install dnf-plugins-core -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -y
endline

echo -ne "1.Change the dnf config: done\n"
echo -ne "2.Enable RPMFusion and Flathub: done\n"
echo -ne "3.Install mediacodecs...\n"
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf groupupdate sound-and-video -y
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install lame\* --exclude=lame-devel -y
sudo dnf group upgrade --with-optional Multimedia -y
endline

echo -ne "1.Change the dnf config: done\n"
echo -ne "2.Enable RPMFusion and Flathub: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "4.Setup dnf-automatic...\n"
sudo dnf install dnf-automatic -y
sudo systemctl enable --now dnf-automatic.timer
endline

echo -ne "1.Change the dnf config: done\n"
echo -ne "2.Enable RPMFusion and Flathub: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "4.Setup dnf-automatic: done\n"
echo -ne "5.Install ibus-bamboo...\n"
sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:lamlng/Fedora_"$(rpm -E %fedora)"/home:lamlng.repo
sudo dnf install ibus-bamboo -y
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo::Us')]"
gsettings set org.gnome.desktop.interface gtk-im-module 'ibus'
endline

echo -ne "1.Change the dnf config: done\n"
echo -ne "2.Enable RPMFusion and Flathub: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "4.Setup dnf-automatic: done\n"
echo -ne "5.Install ibus-bamboo: done\n"
echo -ne "6.Setup firmware...\n"
sudo fwupdmgr get-devices 
sudo fwupdmgr refresh --force 
sudo fwupdmgr get-updates 
sudo fwupdmgr update
endline

echo -ne "1.Change the dnf config: done\n"
echo -ne "2.Enable RPMFusion and Flathub: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "4.Setup dnf-automatic: done\n"
echo -ne "5.Install ibus-bamboo: done\n"
echo -ne "6.Setup firmware: done\n"
echo -ne "7.Setup battery life...\n"
sudo dnf install tlp tlp-rdw
sudo systemctl mask power-profiles-daemon
sudo dnf install powertop
sudo powertop --auto-tune
endline


echo -ne "1.Change the dnf config: done\n"
echo -ne "2.Enable RPMFusion and Flathub: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "4.Setup dnf-automatic: done\n"
echo -ne "5.Install ibus-bamboo: done\n"
echo -ne "6.Setup firmware: done\n"
echo -ne "7.Setup battery life: done\n"
echo -ne "8.H/W Video Decoding with VA-API...\n"
sudo dnf install ffmpeg ffmpeg-libs libva libva-utils
sudo dnf install intel-media-driver
endline

echo -ne "1.Change the dnf config: done\n"
echo -ne "2.Enable RPMFusion and Flathub: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "4.Setup dnf-automatic: done\n"
echo -ne "5.Install ibus-bamboo: done\n"
echo -ne "6.Setup firmware: done\n"
echo -ne "7.Setup battery life: done\n"
echo -ne "8.H/W Video Decoding with VA-API: done\n"
echo -ne "9.Set hostname...\n"
hostnamectl hostname pc
endline

echo -ne "1.Change the dnf config: done\n"
echo -ne "2.Enable RPMFusion and Flathub: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "4.Setup dnf-automatic: done\n"
echo -ne "5.Install ibus-bamboo: done\n"
echo -ne "6.Setup firmware: done\n"
echo -ne "7.Setup battery life: done\n"
echo -ne "8.H/W Video Decoding with VA-API: done\n"
echo -ne "9.Set hostname: done\n"
echo -ne "10.Install daily apps...\n"

echo -en "This script will install: google-chrome, visual studio code, tweaks, terminal,..."
sudo dnf install neofetch htop neovim unzip wget curl npm nodejs gnome-tweaks git vlc xclip clang cmake ninja-build pkg-config gtk3-devel go -y
endline
echo -ne "Alacritty..."
sudo dnf install alacritty -y
mkdir ~/.config/alacritty
cp config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
cp config/alacritty/colors.yml ~/.config/alacritty/colors.yml
endline
echo -ne "Chrome..."
sudo dnf install fedora-workstation-repositories -y
sudo dnf config-manager --set-enabled google-chrome -y
sudo dnf install google-chrome-stable -y
endline
echo -ne "Code..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update -y
sudo dnf install code -y
endline
echo -ne "SF Mono Fonts..."
cd Downloads && git clone https://github.com/kube/sf-mono-ligaturized.git
cd sf-mono-ligaturized/ligaturized/
sudo mv SFMonoLigaturized-*.ttf /usr/share/fonts/
fc-cache -f -v
cd
endline
echo -ne "Bash config..."
mv ~/.bashrc ~/.bashrc.bak
cp config/bash/bashrc ~/.bashrc
endline

echo -ne "Status\n"
echo -ne "1.Change the dnf config: done\n"
echo -ne "2.Enable RPMFusion and Flathub: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "3.Install mediacodecs: done\n"
echo -ne "4.Setup dnf-automatic: done\n"
echo -ne "5.Install ibus-bamboo: done\n"
echo -ne "6.Setup firmware: done\n"
echo -ne "7.Setup battery life: done\n"
echo -ne "8.H/W Video Decoding with VA-API: done\n"
echo -ne "9.Set hostname: done\n"
echo -ne "10.Install daily apps: done\n"
echo -ne "THANK YOU FOR USING THIS SCRIPT\n"
read -rp "Press any key to reboot" 
reboot

