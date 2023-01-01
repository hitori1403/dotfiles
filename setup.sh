#!/bin/bash

handle_acpi_events() {
	FILE=/etc/systemd/logind.conf

	echo "Modifying $FILE"

	# Suspend when power key is pressed
	sudo sed -i '/#HandlePowerKey=/s/poweroff/suspend/g' $FILE
	sudo sed -i '/#HandlePowerKey=/s/^#//g' $FILE
}

adjust_touchpad_rules() {
	FILE=/etc/udev/rules.d/01-touchpad.rules
	
	echo "Modifying $FILE"

	sudo sed -i "s/user/$USER/g" $FILE
	sudo sed -i "s|address|$DBUS_SESSION_BUS_ADDRESS|g" $FILE
}

copy_config() {
	echo "Copying configs"
	sudo cp -r .sysconf/* /
	cp -r .[^.]* ~ && mv ~/.git ~/.dotfiles
}

copy_config

handle_acpi_events
adjust_touchpad_rules
