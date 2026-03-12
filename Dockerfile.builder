FROM ubuntu:24.04

# Install build dependencies
RUN apt-get update && apt-get install -y \
    bc \
    bison \
    build-essential \
    curl \
    flex \
    git \
    libssl-dev \
    make \
    gcc-aarch64-linux-gnu \
    swig \
    python3-dev \
    python3-setuptools \
    python3-pyelftools \
    gnutls-dev

# Set working directory
WORKDIR /build

# Clone U-Boot v2026.01
# RUN git clone --depth 1 --branch v2026.01 https://github.com/u-boot/u-boot .

# Set Cross-Compiler environment
ENV CROSS_COMPILE=aarch64-linux-gnu-
ENV ARCH=arm64

# Copy your local modifications (we will create these next)
# COPY rpi.h include/configs/rpi.h
# COPY bcm2712-rpi-5-b.dts arch/arm/dts/bcm2712-rpi-5-b.dts

CMD ["/bin/bash"]
