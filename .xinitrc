# Environment variables
export EDITOR=/usr/bin/nvim \
GTK_IM_MODULE=fcitx \
QT_IM_MODULE=fcitx \
XMODIFIERS=@im=fcitx \
SDL_IM_MODULE=fcitx \
_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

# Update redshift location
~/.scripts/redshift_init &

# Redshift
redshift &

# Auto lock screen
xss-lock ~/.scripts/lock &

# Vietnamese input method
fcitx &

# Network manager applet
nm-applet &

# Load .Xresources config
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &

# gnome-keyring
[[ -f /etc/X11/xinit/xinitrc.d/50-systemd-user.sh ]] && . /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# Run windows manager
exec awesome
