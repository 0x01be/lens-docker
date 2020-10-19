FROM 0x01be/lend:build as build

FROM 0x01be/xpra

COPY --from=build /opt/lens/ /opt/lens/

USER root
RUN apk add --no-cache --virtual lens-runtime-dependencies \
    nodejs

USER xpra

ENV PATH ${PATH}:/opt/lens/bin/

ENV COMMAND lens

