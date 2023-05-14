#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# if DISPLAY is an empty string and the virtual terminal number is equal to one
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
		exec startx
fi
