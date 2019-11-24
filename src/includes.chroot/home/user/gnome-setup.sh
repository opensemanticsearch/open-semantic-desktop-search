#!/bin/sh

#
# Initial gnome config
# will be autostarted on first login by ~/.config/autostart/gnome-setup.desktop and deleted after this first initial config
#

# Do not index Documents folder by internal search engine (miner)
gsettings set org.freedesktop.Tracker.Miner.Files index-recursive-directories "['&DESKTOP', '&DOWNLOAD', '&MUSIC', '&PICTURES', '&VIDEOS']"

# Disable screen lock and dimming, since running in VM
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false

# add applications to favorites / application sidebar
gsettings set org.gnome.shell favorite-apps "['alacarte-made.desktop', 'alacarte-made-2.desktop', 'alacarte-made-1.desktop', 'alacarte-made-3.desktop', 'alacarte-made-4.desktop', 'firefox-esr.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop', 'yelp.desktop']"

# Since initial setup done, delete this config script and its autostarter to respect if user changes our defaults
rm ~/gnome-setup.sh
rm ~/.config/autostart/gnome-setup.desktop
