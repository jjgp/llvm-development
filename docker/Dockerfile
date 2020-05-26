FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

ADD ./install_base.sh install_base.sh
RUN bash ./install_base.sh && rm install_base.sh

ARG LLVMDEV=yes
ARG CLANG_VERSION=8
ADD ./install_clang.sh install_clang.sh
RUN bash ./install_clang.sh && rm install_clang.sh

ARG LLVM_VERSION=8.0.1
ADD ./install_llvm.sh install_llvm.sh 
RUN bash ./install_llvm.sh