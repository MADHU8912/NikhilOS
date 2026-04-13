FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    gcc-multilib \
    binutils \
    nasm \
    qemu-system-x86 \
    make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace