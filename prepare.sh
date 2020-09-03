#!/bin/bash
set -euo pipefail

if [[ -z ${syncthing_version:-} ]] ; then
    syncthing_version=$(curl -s https://api.github.com/repos/syncthing/syncthing/releases/latest \
        | grep tag_name \
        | awk '{print $2}' \
        | tr -d \",v)
fi

if [[ -z ${go_version:-} ]] ; then
	go_version=latest
fi

ver="${syncthing_version}"
if [[ ! -z ${extra_version:-} ]] ; then
    ver="$syncthing_version.$extra_version"
else
    rels=$(curl -s https://synology.kastelo.net/v1/packages)
    i=1
    while echo "$rels" | grep -q -- "-$ver.spk" ; do
        ver="$syncthing_version.$i"
        i=$((i + 1))
    done
fi

echo "Version $ver"
echo -n "$ver" > syncthing/INFO_VERSION

rm -rf build
mkdir -p build
pushd build

curl -skL "https://github.com/syncthing/syncthing/releases/download/v${syncthing_version}/syncthing-source-v${syncthing_version}.tar.gz" | tar zxf -

pushd syncthing

dst=../../syncthing
mkdir -p "$dst/bin"
mkdir -p "$dst/doc"

build() {
    goos=$1
    goarch=$2
    goarm=${3:-}
    echo Build "$goos-$goarch $goarm" using "golang:$go_version"
    docker run --rm \
        -v $(pwd):/syncthing \
        -v /tmp/syncthing-gopath:/go \
        -v /tmp/syncthing-cache:/root/.cache \
        -w /syncthing \
        -e BUILD_HOST=kastelo.net \
        -e BUILD_USER=synology \
        "golang:$go_version" \
        go run build.go -no-upgrade -goos $goos -goarch $goarch build
    mv syncthing "$dst/bin/syncthing-$goos-$goarch$goarm"
}

build linux amd64
build linux 386
GOARM=7 build linux arm v7
GOARM=8 build linux arm v8

cp README.md LICENSE AUTHORS CONTRIBUTING.md CONDUCT.md GOALS.md "$dst/doc"

popd
popd

rm -rf build
