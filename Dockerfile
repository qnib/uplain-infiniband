FROM qnib/uplain-init

#  Set MOFED directory, image and working directory
ARG MOFED_DIR=MLNX_OFED_LINUX-4.2-1.0.0.0-ubuntu16.04-x86_64
ARG MOFED_SITE_PLACE=MLNX_OFED-4.2-1.0.0.0
ARG MOFED_IMAGE=MLNX_OFED_LINUX-4.2-1.0.0.0-ubuntu16.04-x86_64.tgz

# Pick up some MOFED dependencies
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        wget \
        net-tools \
        ethtool \
        perl \
        lsb-release \
        iproute2 \
        pciutils \
        libnl-route-3-200 \
        kmod \
        libnuma1 \
        lsof \
        linux-headers-4.4.0-92-generic \
        python-libxml2 \
 # Download and install Mellanox OFED 4.2.1 for Ubuntu 16.04
 && wget http://content.mellanox.com/ofed/${MOFED_SITE_PLACE}/${MOFED_IMAGE} \
 && tar -xzvf ${MOFED_IMAGE} \
 && ${MOFED_DIR}/mlnxofedinstall --user-space-only --without-fw-update --all -q \
 && cd .. \
 && rm -rf ${MOFED_DIR} *.tgz /var/lib/apt/lists/*
