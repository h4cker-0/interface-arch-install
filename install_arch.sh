#!/bin/bash

function ctrl_c(){

	echo -e "\n\e[31mSaliendo\n\e[31m"
	exit 1
}

trap ctrl_c INT


function install_arch(){
	
	echo -e "\e[32m[*]\e[0m\e[33mBienvenido al instalador de arch\n\e[0m"
	echo -e "\e[32m[*]\e[0m\e[32\n\nInstalando paru \e[0m"
	mkdir ~/repos >/dev/null 2>/dev/null
        mkdir ~/local/bin >/dev/null 2>/dev/null
	mkdir ~/.config/kitty/ 2>/dev/null >/dev/null 
        sudo mkdir /usr/share/zsh >/dev/null 2>/dev/null
        cd ~/repos/ && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si && yay -S paru && clear
	echo -e "\e[32m[*]\n\n\e[0m\e[32mInstalando algunas fuentes.\e[0m"
	echo -e "\n\e[32m[-]\e[0m\e[34mPor favor acepte las descargas.\e[0m"
	echo -e "\n\e[35m[*]\e[0m\e[32mInstalando : wget, p7zip, xclip\e[0m"
	sudo pacman -Sy p7zip wget xclip 
	cd /usr/share/fonts/ && sudo wget http://fontlot.com/downfile/5baeb08d06494fc884dbe36210f6f0ad5.105610 && sudo mv 5baeb08d06494fc884dbe36210f6f0ad5.105610 comprimido.zip && sudo 7z x comprimido.zip && for x in $(find . | grep ".ttf$" ); do sudo cp -r $x . ; done && sudo rm -rf ./iosevka-2.2.1 ./iosevka-slab-2.2.1
	cd ~/repos/ && git clone https://github.com/murcielago444/interface-arch-install.git && cd interface-arch-install && sudo mv icoomon.zip /usr/share/fonts/ && cd /usr/share/fonts/ && sudo 7z x icoomon.zip && sudo rm -rf icoomon.zip
	echo -e "\e[32m[-]\e[0m\e[33mPor favor acepte la instalacion de las fuentes.\e[0m"
	paru -S nerd-fonts-jetbrains-mono ttf-font-awesome ttf-material-design-icons
	cd ~/repos/ && git clone https://github.com/rxyhn/dotfiles && cd dotfiles && git checkout $(git log | grep -i "commit" | grep -i "c1e2eef2baa91aebd37324891cb282666beae04f"  | awk 'NF{print $2}' FS=' ')  
	cp -r config/* ~/.config/ && cp -r bin/* ~/.local/bin/ && cp -r misc/. ~/
	echo -e "\e[32m[*]\e[0m\e[32m\n\nConfigurando el sistema de arranque porfavor ingrese la contra.... si es requerida.\e[0m"
	systemctl --user enable mpd.service && systemctl --user start mpd.service && sudo systemctl enable acpid.service && sudo systemctl start acpid.service
	echo -e "\e[32m[*]\e[0m\e[32m\n\nInstalando paquetes necesarios para awesome.\e[0m"
	paru -S awesome-git picom-git alacritty rofi todo-bin acpi acpid \ wireless_tools jq inotify-tools polkit-gnome xdotool maim \ brightnessctl alsa-utils alsa-tools pulseaudio lm_sensors \ mpd mpc mpdris2 ncmpcpp playerctl --needed
	echo -e "\e[32m[*]\e[0m\e[33m\n\nConfigurando zshrc y nano.\e[0m"
	cd ~/repos/interface-arch-install/ && cp ./zshrc ~/.zshrc && cp ./p10k.zsh ~/.p10k.zsh && 7z x nano.zip && cp -r ./nano ~/.nano/ && cp ./nanorc ./.nanorc && sudo mkdir /usr/share/zsh/zsh-sudo/ && sudo mv ./sudo.plugin.zsh /usr/share/zsh/zsh-sudo/
	echo -e "\e[32m[*]\e[0m\e[33mConfigurando kitty\e[0m"
	cd ~/.config/kitty/ && mv ~/repos/interface-arch-install/kitty.conf . && mv ~/repos/interface-arch-install/color.ini . && sudo cp ~/repos/interface-arch-install/rc.lua ~/.config/awesome/ && sudo cp ~/repos/interface-arch-install/init.lua ~/.config/awesome/ui/decorations/init.lua
	echo -e "\e[32m[*]\e[0m\e[33mInstalando algunas herramientas de pentesting\e[0m"
	paru -S nmap burpsuite python-pip python3 python2 wfuzz apache
	echo -e "\n\n\e[35m			Terminado!!\e[0m"	
		
}
install_arch
