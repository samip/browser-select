#!/bin/sh

install_path="/usr/bin/browser-select.sh"
desktop_file_dir="/usr/share/applications/"
desktop_file="browser-select.desktop"

if [ "$1" = "uninstall" ]
then
    update-alternatives --remove x-www-browser "$install_path"
    rm "$install_path" 2> /dev/null
    rm "$desktop_file_dir$desktop_file" 2> /dev/null
else
    cp $desktop_file $desktop_file_dir
    cp browser-select.sh "$install_path"
    sudo update-alternatives \
      --install /usr/bin/x-www-browser x-www-browser "$install_path" 210
    xdg-settings get default-web-browser >> ~/.old_default_browser
    xdg-settings set default-web-browser $desktop_file
fi
