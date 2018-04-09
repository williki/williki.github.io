#!/bin/sh

get_config_repo() {
	echo "Downloading and installing dotfiles..."
	git clone https://github.com/williki/configs.git
	mv -i configs/htoprc ~/.config/htop/htoprc
	mv -i configs/.zshrc ~
	mv -i configs/.vimrc ~
}

# Arch based OS
if [ -f /usr/bin/pacman ]; then
	echo "Arch based OS detected, installing core progs..."
	sudo pacman -Sy --noconfirm binutils curl git htop vim zsh sudo
	# to make pacaur work...
	sudo pacman -S --asdeps --noconfirm fakeroot expac
	# to build C programs
	sudo pacman -S --noconfirm gcc make
	curl -O https://raw.githubusercontent.com/rmarquis/pacaur/master/pacaur	
	chmod a+x pacaur
	./pacaur -S --noconfirm pacaur
	rm pacaur
fi

# Debian based OS
if [ -f /usr/bin/apt-get ]; then
	echo "Debian based OS detected, installing core progs..."
	sudo apt-get -y update
	sudo apt-get -y install git htop vim zsh
fi

# Redhat based OS
if [ -f /usr/bin/dnf ]; then
	echo "Redhat based OS detected, installing core progs..."
	sudo dnf install git htop vim zsh
fi

get_config_repo

echo "All done, have a nice day!"

