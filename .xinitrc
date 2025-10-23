# Environment variables
export XDG_CURRENT_DESKTOP=gnome
export SSH_ASKPASS=xaskpass

# Load .Xresources and apply DPI
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xrandr --dpi $(xrdb -query | awk '/Xft.dpi/ {print $2}')

# Redshift
~/.local/bin/redshiftrc &

# Screen lock settings
xset s 600 5
export XSECURELOCK_SAVER=~/.local/bin/xsecurelock_bg
export XSECURELOCK_SHOW_KEYBOARD_LAYOUT=0
export XSECURELOCK_SHOW_DATETIME=1
xss-lock xsecurelock &

# Prevent sleep
caffeine &

# Input method
fcitx5 &

# Network manager applet
nm-applet &

# GNOME keyring
[[ -f /etc/X11/xinit/xinitrc.d/50-systemd-user.sh ]] && . /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# Polkit agent
[[ -f /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 ]] && /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Start windows manager
exec awesome

# vim: ft=sh
