FROM williamyeh/wrk

MAINTAINER phpramework <phpramework@gmail.com>

ENV SERVER_HOST=localhost \
    SERVER_PORT=8080 \
    URI_JSON=/json \
    URI_DB=/db \
    URI_QUERIES=/queries/ \
    URI_UPDATES=/updates/ \
    URI_FORTUNES=/fortunes \
    URI_PLAINTEXT=/plaintext

