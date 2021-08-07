FROM kalilinux/kali

ARG S6_OVERLAY_VERSION="2.2.0.3"
ARG S6_ARCHITECTURE="amd64"

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="wowmuchname/kalitainer-base"
LABEL org.label-schema.description="Base-Image for kalitainer"
LABEL org.label-schema.url="https://github.com/WowMuchName/kalitainer"
LABEL org.label-schema.vcs-url="https://github.com/WowMuchName/kalitainer"

LABEL net.pbforge.kalitainer.s6=${S6_OVERLAY_VERSION}

EXPOSE 5900
EXPOSE 6080
VOLUME /home/kali/

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt update \
 && apt install -yq x11vnc xvfb dbus-x11 curl novnc \
 && apt-get clean \
 && useradd --create-home --shell /bin/bash --user-group --groups sudo kali

RUN curl -L -o /tmp/s6-overlay-${S6_ARCHITECTURE}.tar.gz https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${S6_ARCHITECTURE}.tar.gz \
 && tar xzf /tmp/s6-overlay-amd64.tar.gz -C / --exclude="./bin" \
 && tar xzf /tmp/s6-overlay-amd64.tar.gz -C /usr ./bin \
 && rm /tmp/s6-overlay-${S6_ARCHITECTURE}.tar.gz \
 && cp /usr/share/novnc/vnc.html /usr/share/novnc/index.html

ENTRYPOINT ["/init"]
COPY etc/ /etc
WORKDIR /home/kali
