FROM ubuntu:20.04
ENV GODEBUG netdns=go

LABEL com.centurylinklabs.watchtower.stop-signal="SIGINT"

RUN apt-get -qq update && \
    apt-get -qq install -y --no-install-recommends ca-certificates curl tzdata && \
    rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
