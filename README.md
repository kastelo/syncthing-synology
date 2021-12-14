Syncthing Synology Package
==========================

Usage
-----

> :warning: :warning: :warning:
>
> This package is deprecated. It does not support DSM 7, and as of the 1st
> of January 2022 it is no longer maintained or updated.
>
> :warning: :warning: :warning:

~~This package is published at the `https://synology.kastelo.net/` package
source. (That's not a website for humans. Don't click it.)~~

There is documentation available at https://docs.kastelo.net/synology/.

Development
-----------

Create the build environment Docker image:

```
docker build -t kastelo/synology-build synology-build
```

Prepare the binaries and metadata:

```
./prepare.sh
```

By default the latest stable version of Syncthing will be downloaded and
built, and the package will get the same version number. This can be
customized before prepare by specifying a version and, optionally, and extra
version component:

```
export syncthing_version=1.3.3
export extra_version=2
./prepare.sh
```

The above will build Syncthing 1.3.3 and the resulting Synology package will
have version 1.3.3.2.

Now create the spk:s. At this point a signing key in PGP export format must
exist in ~/synology-signing-key.asc.

```
./build.sh
```
