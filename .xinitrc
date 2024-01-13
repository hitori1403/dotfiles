# Environment variables
export EDITOR=/usr/bin/nvim \
GTK_IM_MODULE=fcitx \
QT_IM_MODULE=fcitx \
XMODIFIERS=@im=fcitx \
SDL_IM_MODULE=fcitx \
QT_QPA_PLATFORMTHEME=qt6ct \
_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on' \
XDG_CURRENT_DESKTOP=gnome \
GROFF_NO_SGR=1

# Redshift
~/.scripts/redshift_init &

# Auto lock screen
xss-lock ~/.scripts/lock &

# Vietnamese input method
fcitx5 &

# Network manager applet
nm-applet &

# Load .Xresources config
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &

# gnome-keyring
[[ -f /etc/X11/xinit/xinitrc.d/50-systemd-user.sh ]] && . /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# polkit-gnome
[[ -f /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 ]] && /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Run windows manager
exec awesome
