#!/bin/bash

source /pkgscripts/include/pkg_util.sh

case "$(pkg_get_platform_family)" in
    x86_64)
        bin=syncthing-linux-amd64
        ;;
    i686)
        bin=syncthing-linux-386
        ;;
    armv8)
        bin=syncthing-linux-armv8
        ;;
    armv7)
        bin=syncthing-linux-armv7
        ;;
    *)
        echo "Unknown architecture: $(pkg_get_platform_family)"
        exit 1
        ;;
esac

mkdir -p "${DESTDIR}/bin"
cp "bin/$bin" "$DESTDIR/bin/syncthing"

cp -r doc "$DESTDIR"
mv "$DESTDIR/doc/LICENSE" "$DESTDIR"
mv "$DESTDIR/doc/AUTHORS" "$DESTDIR"
mv "$DESTDIR/doc/README.md" "$DESTDIR/README.txt"
