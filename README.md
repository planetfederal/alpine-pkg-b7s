# alpine-pkg-b7s
Boundless Alpine packages

### Build

`cd` into the directory/package that you want to build. Request the private key from qa-deployment slack channel.

```bash
docker run -e RSA_PRIVATE_KEY="$(cat ~/.abuild/b7s.rsa)" \
           -e RSA_PRIVATE_KEY_NAME="b7s.rsa" \
           -v "$PWD:/home/builder/package" \
           -v "$PWD/../apk:/packages/builder/x86_64" \
           -v "$HOME/.abuild/b7s.rsa.pub:/etc/apk/keys/b7s.rsa.pub" andyshinn/alpine-abuild:v6
```