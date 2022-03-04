FROM ubuntu:21.04

RUN DEBIAN_FRONTEND=noninteractive

RUN sudo apt update && sudo apt upgrade

RUN sudo apt install -y \
   software-properties-common \
   cmake \
   libboost-all-dev

RUN sudo apt install -y \
   llvm-12-dev \
   liblld-12-dev


RUN sudo apt install -y gcc g++ && sudo apt install -y clang-12

RUN sudo apt install iwyu -y

RUN mkdir /root/test/ -p
WORKDIR /root/test/

RUN git clone https://github.com/WasmEdge/WasmEdge.git .

RUN cd WasmEdge

RUN mkdir build && \
    cd build && \
    cmake -DCMAKE_CXX_INCLUDE_WHAT_YOU_USE="include-what-you-use;-w;-Xiwyu;--verbose=7" -DCMAKE_BUILD_TYPE=Debug .. \
    && echo -e "\nStarting build with IWYU:\n" \
    && make -j \
    echo -e "\nDone\n"
