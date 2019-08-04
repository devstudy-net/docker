# Build:
# docker build -t devstudy/jdk:11.0.4 -t devstudy/jdk:11 -t devstudy/jdk -f ./jdk-11.0.4.dockerfile .
#
# Push:
# docker push devstudy/jdk:11.0.4
# docker push devstudy/jdk:11
# docker push devstudy/jdk
#
# Versions:
# ----------------------------------------------------------------------------------------------------------------
ARG ALPINE_VERSION=3.10
ARG ZULU_JDK_VERSION=zulu11.33.15-ca-jdk11.0.4-linux_musl_x64
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
    mv ${ZULU_JDK_VERSION} /opt/jdk11 && \
    rm -rf /opt/install && \
    # Remove redundant folder and files
    rm -rf /opt/jdk11/demo && \
    rm -rf /opt/jdk11/man && \
    rm -f /opt/jdk11/lib/src.zip && \
    rm -rf /opt/jdk11/readme.txt && \
    rm -rf /opt/jdk11/Welcome.html

ENV JAVA_HOME=/opt/jdk11
ENV PATH $JAVA_HOME/bin:$PATH

CMD ["jshell"]