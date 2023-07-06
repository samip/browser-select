#!/bin/sh

# Install:
# install.sh
#
# Uninstall:
# install.sh remove

install_path="/usr/bin/browser-select.sh"
desktop_file_dir="/usr/share/applications/"
desktop_file="browser-select.desktop"

install() {
    cp $desktop_file $desktop_file_dir
    cp browser-select.sh "$install_path"
    update-alternatives \
      --install /usr/bin/x-www-browser x-www-browser "$install_path" 210
    xdg-settings set default-web-browser $desktop_file
}

uninstall() {
    update-alternatives --remove x-www-browser "$install_path"
    # revert xdg-settings (to what)?
    rm "$install_path" 2> /dev/null
    rm "$desktop_file_dir$desktop_file" 2> /dev/null
}

if [ "$1" != "remove" ]
then
    install
else
    uninstall
fi

