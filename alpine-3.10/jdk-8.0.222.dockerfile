# Build:
# docker build -t devstudy/jdk:8.0.222 -t devstudy/jdk:8 -f ./jdk-8.0.222.dockerfile .
#
# Push:
# docker push devstudy/jdk:8.0.222
# docker push devstudy/jdk:8
#
# Versions:
# ----------------------------------------------------------------------------------------------------------------
ARG ALPINE_VERSION=3.10
ARG ZULU_JDK_VERSION=zulu8.40.0.25-ca-jdk8.0.222-linux_musl_x64
# ----------------------------------------------------------------------------------------------------------------
FROM alpine:${ALPINE_VERSION}

MAINTAINER devstudy.net

ARG ZULU_JDK_VERSION
ARG ZULU_JDK_TAR_GZ=${ZULU_JDK_VERSION}.tar.gz
ARG ZULU_JDK_DOWNLOAD_LINK=https://cdn.azul.com/zulu/bin/${ZULU_JDK_TAR_GZ}

RUN mkdir /opt/install && \
    cd /opt/install && \
    # Display download link
    echo Download from ${ZULU_JDK_DOWNLOAD_LINK} && \
    wget ${ZULU_JDK_DOWNLOAD_LINK} && \
    # Display tar file size
    echo ${ZULU_JDK_TAR_GZ} file size: && \
    ls -lh && \
    tar -xzf ${ZULU_JDK_TAR_GZ} && \
    mv ${ZULU_JDK_VERSION} /opt/jdk8 && \
    rm -rf /opt/install && \
    # Remove redundant folder and files
    rm -rf /opt/jdk8/demo && \
    rm -rf /opt/jdk8/sample && \
    rm -rf /opt/jdk8/man && \
    rm -f /opt/jdk8/src.zip && \
    rm -f /opt/jdk8/readme.txt && \
    rm -f /opt/jdk8/Welcome.html

ENV JAVA_HOME=/opt/jdk8
ENV PATH $JAVA_HOME/bin:$PATH