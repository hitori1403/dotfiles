# Environment variables
export GTK_IM_MODULE=fcitx \
QT_IM_MODULE=fcitx \
XMODIFIERS=@im=fcitx \
SDL_IM_MODULE=fcitx \
QT_QPA_PLATFORMTHEME=xdgdesktopportal \
_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on' \
XDG_CURRENT_DESKTOP=gnome \
GROFF_NO_SGR=1

# Redshift
~/.local/bin/redshift_init &

# Auto lock screen
xss-lock ~/.local/bin/lock &

# Vietnamese input method
fcitx &

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
