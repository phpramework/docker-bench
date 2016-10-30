#!/bin/sh

wrk_version=4.0.2
wrk_tarball_url=https://github.com/wg/wrk/archive/$wrk_version.tar.gz
wrk_download_path=/tmp/wrk_working_dir
wrk_src_path=$wrk_download_path/wrk-$wrk_version

apk add --no-cache  --virtual .wrk-deps \
    build-base \
    ca-certificates \
    curl \
    git \
    libffi-dev \
    openssl-dev \
    perl \
    py-pip \
    python-dev \
    tar

mkdir -p $wrk_download_path
curl -L https://github.com/wg/wrk/archive/$wrk_version.tar.gz > /tmp/$wrk_version.tar.gz
tar zxvf /tmp/$wrk_version.tar.gz -C $wrk_download_path
cd $wrk_src_path
make
cp $wrk_src_path/wrk /usr/local/bin/wrk

rm -rf /tmp/*
apk del --no-cache --purge -r .wrk-deps
