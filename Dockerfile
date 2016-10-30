FROM alpine:3.4

MAINTAINER phpramework <phpramework@gmail.com>

ENV FRAMEWORK=unknown \
    URI_JSON=/json \
    URI_DB=/db \
    URI_QUERIES=/queries/ \
    URI_UPDATES=/updates/ \
    URI_FORTUNES=/fortunes \
    URI_PLAINTEXT=/plaintext \
    BENCHMARK_CORES=1

RUN apk update --no-cache \
    && apk add --no-cache \
        libgcc \
        su-exec

ADD install-wrk.sh /
RUN /install-wrk.sh

RUN mkdir -p /result
VOLUME /result

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY benchmark-plaintext.sh /usr/local/bin/benchmark-plaintext.sh
COPY benchmark-plaintext.sh /usr/local/bin/benchmark-json.sh
COPY benchmark-plaintext.sh /usr/local/bin/benchmark-db.sh
COPY benchmark-plaintext.sh /usr/local/bin/benchmark-queries.sh
COPY benchmark-plaintext.sh /usr/local/bin/benchmark-updates.sh
COPY benchmark-plaintext.sh /usr/local/bin/benchmark-fortunes.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["wrk"]
