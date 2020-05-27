FROM ubuntu:18.04
MAINTAINER Jason Prasad <jasongprasad@gmail.com>

ARG LLVM_VERSION=8.0.1
COPY install_llvm.sh .
RUN bash install_llvm.sh && \
    rm install_llvm.sh