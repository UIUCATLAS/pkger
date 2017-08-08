FROM alpine:latest
MAINTAINER szuta@illinois.edu
RUN apk add --no-cache libxml2-dev \
                       libressl-dev \
                       fts-dev \
                       cpio \
                       libgcc \
                       libstdc++ \
                       bash \
    && apk add --no-cache --virtual builddeps \
                        git \
                        make \
                        g++ \
                        autoconf \ 
    && cd /root \
    && git clone https://github.com/hogliux/bomutils \
    && cd bomutils \
    && make \
    && make install \
    && cd /root \
    && git clone https://github.com/mackyle/xar \
    && cd xar/xar \
    && LDFLAGS="-L/usr/lib" LIBS="-lfts" ./autogen.sh \
    && make \
    && make install \
    && apk del builddeps \
    && rm -rf /root/xar  \
    && rm -rf /root/bomutils \
    && mkdir -p /pkg/scripts \
    && mkdir /pkg/root \
    && mkdir /pkg/base.pkg \
    && ( cd /pkg/root \&\& find . | cpio -o --format odc --owner 0:80 | gzip -c ) > /pkg/base.pkg/Payload \
    && mkbom -u 0 -g 80 /pkg/root /pkg/base.pkg/Bom
COPY ["PackageInfo", "/pkg/base.pkg/PackageInfo"]
COPY ["process.sh", "/usr/local/bin/process.sh"]
VOLUME ["/data"]
ENTRYPOINT ["/usr/local/bin/process.sh"]
