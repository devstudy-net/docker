# Build:
# docker build -t devstudy/jre:8.0.222 -t devstudy/jre:8 -f ./jre-8.0.222.dockerfile .
#
# Push:
# docker push devstudy/jre:8.0.222
# docker push devstudy/jre:8
#
# Versions:
# ----------------------------------------------------------------------------------------------------------------
ARG ALPINE_VERSION=3.10
ARG ZULU_JRE_VERSION=zulu8.40.0.25-ca-jre8.0.222-linux_musl_x64
# ----------------------------------------------------------------------------------------------------------------
FROM alpine:${ALPINE_VERSION}

MAINTAINER devstudy.net

ARG ZULU_JRE_VERSION
ARG ZULU_JRE_TAR_GZ=${ZULU_JRE_VERSION}.tar.gz
ARG JRE_DOWNLOAD_LINK=https://cdn.azul.com/zulu/bin/${ZULU_JRE_TAR_GZ}

RUN mkdir /opt/install && \
    cd /opt/install && \
    # Display download link
    echo Download from ${JRE_DOWNLOAD_LINK} && \
    wget ${JRE_DOWNLOAD_LINK} && \
    # Display tar file size
    echo ${ZULU_JRE_TAR_GZ} file size: && \
    ls -lh && \
    tar -xzf ${ZULU_JRE_TAR_GZ} && \
    mv ${ZULU_JRE_VERSION} /opt/jre8 && \
    rm -rf /opt/install && \
    # Remove redundant folder and files
    rm -rf /opt/jre8/man && \
    rm -f /opt/jre8/readme.txt && \
    rm -f /opt/jre8/Welcome.html

ENV JRE_HOME=/opt/jre8
ENV PATH $JRE_HOME/bin:$PATH