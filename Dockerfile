FROM alpine:3.7

LABEL MAINTAINER="Aurelien PERRIER <a.perrier@gmail.com>"
LABEL APP="chronograf"
LABEL APP_VERSION="1.3.10.0"
LABEL APP_REPOSITORY="https://github.com/influxdata/chronograf/releases"

ENV TIMEZONE Europe/Paris
ENV CHRONOGRAF_VERSION 1.3.10.0

# Installing packages
RUN apk add --no-cache su-exec

# Work path
WORKDIR /scripts

# Download & install Chronograf
ADD https://dl.influxdata.com/chronograf/releases/chronograf-${CHRONOGRAF_VERSION}-static_linux_amd64.tar.gz ./
RUN addgroup chronograf && \
        adduser -s /bin/false -G chronograf -S -D chronograf

# Coping config & scripts
COPY ./scripts/start.sh start.sh

# Installing binaries
RUN tar -C ./ -xzf chronograf-${CHRONOGRAF_VERSION}-static_linux_amd64.tar.gz && \
        rm -f chronograf-*/chronograf.conf && \
        chmod +x chronograf-*/* && \
        cp -a chronograf-*/* /usr/bin/ && \
        rm -rf *.tar.gz* chronograf-*

EXPOSE 8888

VOLUME /var/lib/chronograf

ENTRYPOINT ["./start.sh"]