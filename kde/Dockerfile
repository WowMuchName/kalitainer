FROM wowmuchname/kalitainer-base

LABEL org.label-schema.name="wowmuchname/kalitainer-kde"
LABEL org.label-schema.description="Base-Image for kalitainer using the kde desktop environment"

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt install -yq kali-desktop-kde \
 && apt remove -yq bluedevil \
 && apt autoremove -yq \
 && apt-get clean

COPY services.d/ /etc/services.d
