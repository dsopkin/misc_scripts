#!/bin/bash

# Author: David Sopkin (sopkin.sf@gmail.com)
# This script will update and upgrade the system as well as autoremove and clean packages. 

intro () {
	echo ""
	echo ""
	echo ""
	echo "Welcome to the install script!"
	echo ""
	echo ""
	echo ""

	sleep 1

	echo ""
	echo ""
	echo ""
	echo "Buckle up buckaroo...."
	echo ""
	echo ""
	echo ""
	sleep 1
}

installdeps () {
#virtualbox	
	get http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo /etc/yum.repos.d/

#kernel
	echo ""
	echo "Do these kernel versions match?"
	sleep 1
	echo ""
	rpm -qa kernel |sort -V |tail -n 1
	uname -r
	echo ""
	echo "If they match, please hit ENTER to continue."
	echo ""
	read -p "Otherwise, hit ctrl+c to exit and update the kernel."
	echo "" 
}

# Install VLC
vlc () {
	rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
	yum info vlc
	yum install vlc
}

# Initial update 
installpackages () {
	sudo yum update
	INSTALL_PKGS="terminator vlc git rsync curl git screen openssh-server tightvncserver unzip wget virtualbox-5.2 yum npm nmon htop iftop ntoping curl john zsh tcpdump fail2ban nmap snort logwatch wireshark libssl-dev libpcap-dev wireshark-gnome"
	for i in $INSTALL_PKGS; do
	  sudo yum install -y $i
	done
}

# Numix icon pack
numix () {
	 wget http://download.opensuse.org/repositories/home:paolorotolo:numix/RedHat_RHEL-6/home:paolorotolo:numix.repo /etc/yum.repos.d
	yum install -y numix-icon-theme-circle
}



# oh-my-zsh
installzsh () {
	sudo yum -y install zsh
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

virtualbox () {
        rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        yum install -y binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms
        yum install VirtualBox-5.2
        service vboxdrv setup
        usermod -a -G vboxusers david
}

sublimetext () {
	sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
	sudo yum-config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
	sudo yum install -y sublime-text 
}

atomtext () {
	wget https://github.com/atom/atom/releases/download/v1.26.1/atom.x86_64.rpm	
	sudo yum localinstall -y atom.x86_64.rpm
}

wedone () {
	echo "Done!"
	sleep 1
	echo "You can reboot if you want."
	sleep 1
	echo "Or not, I don't care."
}

run () {
	intro
	installdeps
	installpackages
	numix
	installzsh
	homebrew
	gitconfigs
	virtualbox
	vlc	
	sublimetext
	atomtext
	wedone
}

run
