# Environment variables
export \
XDG_CURRENT_DESKTOP=gnome \
GROFF_NO_SGR=1 \
SSH_ASKPASS=xaskpass

# Redshift
~/.local/bin/redshift_init &

# Auto lock screen
xset s 600 5

XSECURELOCK_SAVER=~/.local/bin/saver_image \
XSECURELOCK_SHOW_KEYBOARD_LAYOUT=0 \
XSECURELOCK_SHOW_DATETIME=1 \
xss-lock xsecurelock &

# Keep potato awake
caffeine &

# Vietnamese input method
fcitx5 &

# Network manager applet
nm-applet &

# gnome-keyring
[[ -f /etc/X11/xinit/xinitrc.d/50-systemd-user.sh ]] && . /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# polkit-gnome
[[ -f /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 ]] && /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Load .Xresources config
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Run windows manager
exec awesome
