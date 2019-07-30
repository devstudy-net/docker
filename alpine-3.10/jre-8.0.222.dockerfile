# Build:
# docker build -t devstudy/jre:8.0.222 -t devstudy/jre:8 -f ./jre-8.0.222.dockerfile .
#
# Versions:
# ----------------------------------------------------------------------------------------------------------------
ARG ALPINE_VERSION=3.10
ARG ZULU_JRE_VERSION=zulu8.40.0.25-ca-jre8.0.222-linux_musl_x64
# ----------------------------------------------------------------------------------------------------------------
FROM alpine:${ALPINE_VERSION}

MAINTAINER devstudy.net

ARG ZULU_JRE_VERSION
ARG JRE_DOWNLOAD_LINK=https://cdn.azul.com/zulu/bin/${ZULU_JRE_VERSION}.tar.gz

RUN mkdir /opt/install && \
    cd /opt/install && \
    wget ${JRE_DOWNLOAD_LINK} && \
    tar -xzf ${ZULU_JRE_VERSION}.tar.gz && \
    mv ${ZULU_JRE_VERSION} /opt/jre8 && \
    rm -rf /opt/install && \
    rm -rf /opt/jre8/man && \
    rm -f /opt/jre8/readme.txt && \
    rm -f /opt/jre8/Welcome.html

ENV JRE_HOME=/opt/jre8
ENV PATH $JRE_HOME/bin:$PATH