FROM golang:1.8-alpine

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >>/etc/apk/repositories
RUN apk add --update --no-cache build-base linux-headers git cmake bash
RUN apk add --update --no-cache zlib zlib-dev bzip2 bzip2-dev snappy snappy-dev lz4 lz4-dev zstd@testing zstd-dev@testing jemalloc jemalloc-dev libtbb-dev@testing libtbb@testing

RUN git clone https://github.com/facebook/rocksdb.git --branch v6.1.2
WORKDIR /tmp/rocksdb
RUN make shared_lib INSTALL_PATH=/usr
RUN make install-shared
RUN rm -rf /tmp/rocksdb

ENV CGO_CFLAGS  "-I/usr/local/include"
ENV CGO_LDFLAGS "-L/usr/local/lib -lrocksdb -lstdc++ -lm -lz -lbz2 -lsnappy"
ENV LD_LIBRARY_PATH="/usr/local/lib"
