ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_FRONTEND teletype
RUN apt-get update -y && apt-get install -y --no-install-recommends apt-utils
RUN apt-get upgrade -y gcc
RUN apt-get install libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev -y

RUN git clone https://github.com/facebook/rocksdb.git --branch v6.1.2
WORKDIR /tmp/rocksdb
RUN make shared_lib INSTALL_PATH=/usr
RUN make install-shared
RUN rm -rf /tmp/rocksdb

ENV CGO_CFLAGS  "-I/usr/local/include"
ENV CGO_LDFLAGS "-L/usr/local/lib -lrocksdb -lstdc++ -lm -lz -lbz2 -lsnappy"
ENV LD_LIBRARY_PATH="/usr/local/lib"
