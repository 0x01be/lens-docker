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

RUN make build

