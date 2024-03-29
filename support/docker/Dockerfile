FROM debian:bullseye

#LABEL maintainer="Buildroot mailing list <buildroot@buildroot.org>" \
#      vendor="Buildroot" \
#description="Container with everything needed to run Buildroot"

# Setup environment
ENV DEBIAN_FRONTEND noninteractive

# The container has no package lists, so need to update first
RUN dpkg --add-architecture i386 && \
    apt-get update -y
RUN apt-get install -y --no-install-recommends \
        bc \
        build-essential \
        bzr \
        ca-certificates \
        cmake \
        cpio \
        cvs \
        file \
        g++-multilib \
        git \
        libc6:i386 \
        libncurses5-dev \
        locales \
        mercurial \
        openssh-server \
        python3 \
        python3-flake8 \
        python3-magic \
        python3-nose2 \
        python3-pexpect \
        python3-pytest \
        qemu-system-arm \
        qemu-system-x86 \
        rsync \
        shellcheck \
        subversion \
        unzip \
        wget \
        && \
    apt-get -y autoremove && \
    apt-get -y clean

# To be able to generate a toolchain with locales, enable one UTF-8 locale
RUN sed -i 's/# \(en_US.UTF-8\)/\1/' /etc/locale.gen && \
    /usr/sbin/locale-gen

RUN useradd -ms /bin/bash br-user && \
    mkdir -p /home/br-user/.buildroot-ccache && \
    chown -R br-user:br-user /home/br-user

# Persist the build cache between builds
VOLUME ["/home/br-user/.buildroot-ccache"]

USER br-user
WORKDIR /home/br-user
ENV HOME /home/br-user
ENV LC_ALL en_US.UTF-8
