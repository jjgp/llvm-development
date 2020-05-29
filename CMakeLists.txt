cmake_minimum_required(VERSION 3.10)
project(SamplePass)

find_package(LLVM REQUIRED CONFIG)
add_definitions(${LLVM_DEFINITIONS})
include_directories(${LLVM_INCLUDE_DIRS})
link_directories(${LLVM_LIBRARY_DIRS})

add_llvm_library(SamplePass MODULE 
    src/SamplePass.cpp
)
