#!/bin/bash
set -euo pipefail

collect_logs() {
    popd >/dev/null 2>/dev/null || true
    for d in /toolkit/build_env/* ; do
        base=$(basename $d)
        mkdir -p logs/$base
        cp $d/logs.* logs/$base || true
    done
}
trap collect_logs EXIT

mkdir -p /toolkit/source
cp -r syncthing /toolkit/source

for d in /toolkit/build_env/* ; do
    cp /signing-key.asc "$d"
    chroot "$d" gpg --batch --import /signing-key.asc
done

pushd /toolkit >/dev/null
./pkgscripts-ng/PkgCreate.py -c syncthing
popd >/dev/null

mkdir -p packages
for d in /toolkit/build_env/* ; do
    rm -f $d/image/packages/*debug.spk
    cp $d/image/packages/* packages
done
