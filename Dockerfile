FROM williamyeh/wrk

MAINTAINER phpramework <phpramework@gmail.com>

RUN apk add --no-cache \
        su-exec

ENV FRAMEWORK=unknown \
    URI_JSON=/json \
    URI_DB=/db \
    URI_QUERIES=/queries/ \
    URI_UPDATES=/updates/ \
    URI_FORTUNES=/fortunes \
    URI_PLAINTEXT=/plaintext \
    BENCHMARK_CORES=1

RUN mkdir -p /result
VOLUME /result

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY benchmark-plaintext.sh /usr/local/bin/benchmark-plaintext.sh

ENTRYPOINT ["entrypoint.sh"]
