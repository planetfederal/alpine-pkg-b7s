# docker build -t b7s-abuild .
FROM alpine:3.7

RUN apk --no-cache add alpine-sdk bash coreutils cmake \
  && adduser -G abuild -g "Alpine Package Builder" -s /bin/ash -D builder \
  && echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  && mkdir /packages \
  && chown builder:abuild /packages

COPY abuilder /bin/
COPY apk /tmp
COPY apk/b7s.rsa.pub /etc/apk/keys/

RUN apk --no-cache add /tmp/*.apk

USER builder

ENTRYPOINT ["abuilder", "-r"]

WORKDIR /home/builder/package

ENV RSA_PRIVATE_KEY_NAME ssh.rsa
ENV PACKAGER_PRIVKEY /home/builder/${RSA_PRIVATE_KEY_NAME}
ENV REPODEST /packages

VOLUME ["/home/builder/package"]
