# Load .Xresources config
xrdb -merge ~/.Xresources &

# Update redshift location
~/.bin/init_redshift &

# Redshift
redshift &

# Auto lock screen
xss-lock ~/.bin/lock &

# Vietnamese input method
fcitx &

# Run windows manager
exec awesome
