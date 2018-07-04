#!/bin/bash

# Author: David Sopkin (sopkin.sf@gmail.com)
# This script will update and upgrade the system as well as autoremove and clean packages. 

intro () {
	echo ""
	echo ""
	echo ""
	echo "# Welcome to the install script!"
	echo ""
	echo ""
	echo ""

	sleep 1

	echo ""
	echo ""
	echo ""
	echo "# Buckle up buckaroo...."
	echo ""
	echo ""
	echo ""
}

installdeps () {
# virtualbox
	sudo apt-get remove virtualbox virtualbox-4.*
	sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian '$(lsb_release -cs)' contrib non-free' > /etc/apt/sources.list.d/virtualbox.list"
	wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
	wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
	sudo apt-get update
	sudo apt-get install virtualbox-5.2

# wireshark
	sudo add-apt-repository ppa:wireshark-dev/stable
	sudo apt-get update
	sudo apt-get install wireshark

# vlc
	sudo add-apt-repository ppa:jonathonf/vlc

# terminator
	sudo add-apt-repository ppa:gnome-terminator
}


# Initial update 
installpackages () {
	INSTALL_PKGS="
	terminator vlc git rsync curl git screen openssh-server tightvncserver unzip wget virtualbox-5.2 yum npm nmon htop iftop ntoping curl john zsh tcpdump fail2ban nmap snort logwatch wireshark libssl-dev libpcap-dev
	" 
	sudo apt-get update --fix-missing --force-yes -y

	for i in $INSTALL_PKGS; do
	  sudo apt-get install -y $i
	done
}

# Numix icon pack
numix () {
	sudo add-apt-repository ppa:numix/ppa
	sudo apt-get update -y
	sudo apt-get install numix-gtk-theme -y
	sudo apt-get install numix-icon-theme-circle -y
}

# Sublime Text
sublime () {
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt-get update
	sudo apt-get install sublime-text -y
}

# oh-my-zsh
installzsh () {
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

# linux homebrew
homebrew () {
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
	echo "testing homebrew install"
	test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
	test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
	test -r ~/.bash_profile && echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.bash_profile
	echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.profile
}

# git
gitconfigs () {
	git config --global alias.co checkout
	git config --global alias.br branch
	git config --global alias.ci commit
	git config --global alias.st status
	git config --global alias.unstage 'reset HEAD --'
	git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
	git config --global alias.lol "log --graph --decorate --pretty=oneline --abbrev-commit --all"
	git config --global alias.mylog "log --pretty=format:'%h %s [%an]' --graph"
}

# Update/upgrade one more time
lastupdate () {
	sudo apt-get update --fix-missing --force-yes -y
	sudo apt-get upgrade --fix-missing --force-yes -y
	sudo apt-get dist-upgrade --fix-missing --force-yes -y
	sudo apt-get clean -y
	sudo apt-get autoremove -y 
}

wedone () {
	echo "Done! You can reboot if you want."
}

run () {
	intro
	installdeps
	installpackages
	numix
	sublime
	installzsh
	homebrew
	gitconfigs
	lastupdate
	wedone
}

run
