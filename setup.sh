#!/bin/bash

check_root() {
	if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
	fi
}

handle_acpi_events() {
	FILE=/etc/systemd/logind.conf

	# Suspend when power key is pressed
	sed -i '/HandlePowerKey=/s/poweroff/suspend/g' $FILE
	sed -i '/HandlePowerKey=/s/^#//g' $FILE
}

adjust_touchpad_rules() {
	FILE=.sysconf/etc/udev/rules.d/01-touchpad.rules
	sed -i "s/user/$USER/g" $FILE
	sed -i "s|address|$DBUS_SESSION_BUS_ADDRESS|g" $FILE
}

copy_config() {
	cp -r .sysconf/* /etc
	su $USER -c 'mv .git .dotfiles && cp -r .[^.]* ~'
}

check_root()
handle_acpi_events()
adjust_touchpad_rules()
copy_config()
