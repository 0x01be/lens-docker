FROM alpine as build

RUN apk add --no-cache --virtual lens-build-dependencies \
    git \
    build-base \
    python3-dev \
    npm \
    yarn \
    p7zip \
    squashfs-tools 

ENV LENS_REVISION master
RUN git clone --depth 1 --branch ${LENS_REVISION} https://github.com/lensapp/lens.git /lens

WORKDIR /lens

RUN mkdir -p /lens/node_modules/7zip-bin/linux/x64/
RUN ln -s /usr/bin/7za /lens/node_modules/7zip-bin/linux/x64/7za

RUN yarn install
RUN yarn download-bins
RUN yarn compile:main
RUN yarn compile:renderer
RUN yarn build:linux 

