FROM kalilinux/kali
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt update \
 && apt install -yq kali-desktop-kde novnc x11vnc xvfb
RUN apt install -yq dbus-x11
RUN apt remove -yq bluedevil
RUN useradd --create-home --shell /bin/bash --user-group --groups sudo kali

ARG S6_OVERLAY_VERSION="v2.2.0.3"
ARG S6_ARCHITECTURE="amd64"

ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-${S6_ARCHITECTURE}.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / --exclude="./bin" && \
    tar xzf /tmp/s6-overlay-amd64.tar.gz -C /usr ./bin
ENTRYPOINT ["/init"]
COPY etc/ /etc
