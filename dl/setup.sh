#!/bin/sh

check_root() {
	if [[ $EUID -eq 0 ]]; then
		echo "This script must *not* be run as root!"
		exit 1
	fi
}

get_config_repo() {
	echo "Downloading and installing dotfiles..."
	git clone https://github.com/williki/configs.git
	mkdir -p ~/.config/htop
	mv -i configs/.config/htop/htoprc ~/.config/htop/htoprc
	mv -i configs/.zshrc ~
	mv -i configs/.zsh ~
	mv -i configs/.vimrc ~
	rm -rf configs
}

install_core_progs() {

	# Arch based OS
	if [ -f /usr/bin/pacman ]; then
		echo "Arch based OS detected, installing core progs..."
		sudo pacman -Syu --noconfirm binutils curl git htop vim zsh zsh-autosuggestions zsh-syntax-highlighting base-devel
		# On Manjaro yay is in com,unity repo
		if [ -f /.manjaro-tools ]; then
			sudo pacman -S yay
		else
			git clone https://aur.archlinux.org/yay.git
			cd yay
			yes | makepkg -si
			cd ..
			rm -rf yay
		fi
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
		sudo dnf update
		sudo dnf install git htop vim zsh
	fi
}

# BEGIN
check_root
install_core_progs
get_config_repo

echo "All done, have a nice day!"

