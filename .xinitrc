# Update redshift location
~/.bin/init_redshift &

# Redshift
redshift &

# Auto lock screen
xss-lock ~/.bin/lock &

# Vietnamese input method
fcitx &

# Network manager applet
nm-applet &

# Load .Xresources config
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# gnome-keyring
[[ -f /etc/X11/xinit/xinitrc.d/50-systemd-user.sh ]] && . /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# Run windows manager
exec awesome
