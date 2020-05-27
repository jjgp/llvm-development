FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    automake \
    build-essential \
    ca-certificates \
    cmake \
    gdb \
    git \
    libedit-dev \
    libncurses5-dev \
    python \
    python-dev \
    python-setuptools \
    python-wheel \
    software-properties-common \
    sudo \
    swig \
    wget \
    valgrind \
    vim && \
    rm -rf /var/lib/apt/lists/*

ARG LLVM_VERSION=8.0.1
ADD ./install_llvm.sh install_llvm.sh 
RUN bash ./install_llvm.sh