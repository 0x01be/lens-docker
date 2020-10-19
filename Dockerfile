FROM alpine as build

RUN apk add --no-cache --virtual lens-build-dependencies \
    git \
    build-base \
    python3-dev \
    npm \
    yarn

ENV LENS_REVISION master
RUN git clone --depth 1 --branch ${LENS_REVISION} https://github.com/lensapp/lens.git /lens

WORKDIR /lens

RUN apk add p7zip
RUN mkdir -p /lens/node_modules/7zip-bin/linux/x64/
RUN ln -s /usr/bin/7za /lens/node_modules/7zip-bin/linux/x64/7za

RUN make build || $(apk add squashfs-tools && rm /root/.cache/electron-builder/appimage/appimage-12.0.1/linux-x64/mksquashfs && ln -s /sbin/mksquashfs /root/.cache/electron-builder/appimage/appimage-12.0.1/linux-x64/mksquashfs && yarn dist)

