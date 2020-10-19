FROM 0x01be/lens:build as build

FROM 0x01be/xpra

COPY --from=build /lens/dist/linux-unpacked/ /opt/lens/

USER root
RUN apk add --no-cache --virtual lens-runtime-dependencies \
    nodejs

RUN mkdir -p /tmp/.X11-unix
RUN chmod 1777 /tmp/.X11-unix

USER xpra

ENV PATH ${PATH}:/opt/lens/

ENV COMMAND kontena-lens

