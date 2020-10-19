FROM alpine as build

RUN apk add --no-cache --virtual lens-build-dependencies \
    git \
    build-base \
    npm \
    yarn \
    p7zip \
    squashfs-tools \
    python3

ENV LENS_REVISION master
RUN git clone --depth 1 --branch ${LENS_REVISION} https://github.com/lensapp/lens.git /lens

WORKDIR /lens

RUN mkdir -p /lens/node_modules/7zip-bin/linux/x64/
RUN ln -s /usr/bin/7za /lens/node_modules/7zip-bin/linux/x64/7za

RUN yarn install
RUN yarn download-bins
RUN yarn compile:main
RUN yarn compile:renderer

RUN mkdir -p /root/.cache/electron-builder/appimage/appimage-12.0.1/linux-x64/
RUN ln -s /sbin/mksquashfs /root/.cache/electron-builder/appimage/appimage-12.0.1/linux-x64/mksquashfs

RUN yarn build:linux
RUN yarn dist

