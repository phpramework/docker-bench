FROM phpramework/composer

MAINTAINER phpramework <phpramework@gmail.com>

ENV FRAMEWORK=unknown \
    URI_JSON=/json \
    URI_DB=/db \
    URI_QUERIES=/queries/ \
    URI_UPDATES=/updates/ \
    URI_FORTUNES=/fortunes \
    URI_PLAINTEXT=/plaintext \
    BENCHMARK_CORES=1

RUN curl -L https://github.com/consolidation/Robo/releases/download/1.0.0-RC3/robo.phar > /usr/local/bin/robo \
    && chmod +x /usr/local/bin/robo

RUN apk add --no-cache \
        libgcc

ADD install-wrk.sh /
RUN /install-wrk.sh

RUN mkdir -p /result
VOLUME /result

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY RoboFile.php /project/RoboFile.php

ENTRYPOINT ["entrypoint.sh", "robo"]
#CMD ["wrk"]
