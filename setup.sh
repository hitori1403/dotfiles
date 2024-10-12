#!/bin/bash

copy_config() {
	sudo cp -r .sysconf/* /
	cp -r .[^.]* ~ && mv ~/.git ~/.dotfiles
	echo 'Configs copied'
}

adjust_touchpad_rules() {
	FILE='/etc/udev/rules.d/01-touchpad.rules'

	echo "Modifying $FILE"
	sudo sed -i "s/user/$USER/g" $FILE
	sudo sed -i "s|address|$DBUS_SESSION_BUS_ADDRESS|g" $FILE # Error: DBUS_SESSION_BUS_ADDRESS is empty when running in chroot
}

handle_acpi_events() {
	FILE='/etc/systemd/logind.conf'

	echo "Modifying $FILE"
	# Suspend when power key is pressed
	sudo sed -i '/^#HandlePowerKey=/s/^#//g' $FILE
	sudo sed -i '/^HandlePowerKey=/s/poweroff/suspend/g' $FILE
}

enable_multilib() {
	FILE='/etc/pacman.conf'

	sudo sed -i '/^#\[multilib]/s/#//g' $FILE
	echo 'Multilib enabled'
}

enable_zram() {
	sudo pacman -S --needed zram-generator
	sudo systemctl daemon-reload
	sudo systemctl start systemd-zram-setup@zram0.service
	echo 'Zram enabled'
}

copy_config

adjust_touchpad_rules
handle_acpi_events

enable_multilib
enable_zram
