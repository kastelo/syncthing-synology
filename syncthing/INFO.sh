#!/bin/bash

source /pkgscripts/include/pkg_util.sh

package="syncthing"
version=$(cat INFO_VERSION)
displayname="Syncthing"
maintainer="Syncthing Community"
maintainer_url="https://www.syncthing.net/"
distributor="Kastelo Inc."
distributor_url="https://www.kastelo.net/"
arch="$(pkg_get_unified_platform)"
description="Syncthing is a continuous file synchronization program. It synchronizes files between two or more computers in real time, safely protected from prying eyes. Your data is your data alone and you deserve to choose where it is stored, whether it is shared with some third party, and how it's transmitted over the internet."
# adminport="8384"
adminprotocol=https
adminurl="/syncthing/"
silent_install="yes"
silent_upgrade="yes"
silent_uninstall="yes"
instuninst_restart_services="nginx"

# Probably not required
#package_icon=$(base64 < PACKAGE_ICON.PNG)
#package_icon_256=$(base64 < PACKAGE_ICON_256.PNG)

[ "$(caller)" != "0 NULL" ] && return 0

pkg_dump_info

# Not supported by the dumper
echo support_url="https://docs.kastelo.net/synology/" >> INFO
