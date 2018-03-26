# alpine-pkg-b7s
Boundless Alpine packages

- [gdal](gdal/APKBUILD)
- [geos](geos/APKBUILD)
- [libecwj2](libecwj2/APKBUILD)
- [libkml](libkml/APKBUILD)
- [openjpeg](openjpeg/APKBUILD)
- [proj](proj/APKBUILD)

### Build

`cd` into the directory/package that you want to build. Request the private key from qa-deployment slack channel.

```bash
docker build -t b7s-abuild-bash .
```

The above will also apk add any .apk files in the `apk` directory. This is needed when building gdal,
 since you will need to build all the other packages first.

```bash
docker run -e RSA_PRIVATE_KEY="$(cat ~/.abuild/b7s.rsa)" \
           -e RSA_PRIVATE_KEY_NAME="b7s.rsa" \
           -v "$PWD:/home/builder/package" \
           -v "$PWD/../apk:/packages/builder/x86_64" \
           -v "$HOME/.abuild/b7s.rsa.pub:/etc/apk/keys/b7s.rsa.pub" b7s-abuild-bash
```