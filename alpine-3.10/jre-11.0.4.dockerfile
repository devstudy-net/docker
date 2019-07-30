# Build:
# docker build -t devstudy/jre:11.0.4 -t devstudy/jre:11 -t devstudy/jre -f ./jre-11.0.4.dockerfile .
#
# Versions:
# ----------------------------------------------------------------------------------------------------------------
ARG ALPINE_VERSION=3.10
ARG ZULU_JDK_VERSION=zulu11.33.15-ca-jdk11.0.4-linux_musl_x64
# ----------------------------------------------------------------------------------------------------------------
FROM alpine:${ALPINE_VERSION}

MAINTAINER devstudy.net

ARG ZULU_JDK_VERSION
ARG JDK_DOWNLOAD_LINK=https://cdn.azul.com/zulu/bin/${ZULU_JDK_VERSION}.tar.gz
ARG JAVA_MODULES=jdk.jsobject,jdk.internal.opt,jdk.aot,jdk.scripting.nashorn.shell,java.logging,jdk.unsupported.desktop,jdk.rmic,jdk.management.agent,java.xml.crypto,jdk.jdwp.agent,jdk.security.jgss,java.rmi,jdk.net,java.base,java.naming,jdk.jcmd,java.sql.rowset,java.management,jdk.hotspot.agent,jdk.zipfs,java.transaction.xa,java.sql,java.security.sasl,jdk.crypto.cryptoki,java.net.http,jdk.localedata,jdk.naming.dns,jdk.httpserver,java.security.jgss,jdk.attach,jdk.editpad,jdk.unsupported,jdk.xml.dom,jdk.jfr,jdk.management,java.desktop,java.management.rmi,jdk.crypto.ec,java.smartcardio,java.prefs,jdk.scripting.nashorn,jdk.security.auth,jdk.management.jfr,java.se,jdk.jdi,jdk.internal.ed,jdk.naming.rmi,jdk.internal.le,java.scripting,jdk.accessibility,java.datatransfer,java.xml,jdk.sctp,jdk.charsets,java.instrument,jdk.internal.vm.ci

RUN mkdir /opt/install && \
    cd /opt/install && \
    wget ${JDK_DOWNLOAD_LINK} && \
    tar -xzf ${ZULU_JDK_VERSION}.tar.gz && \
    ${ZULU_JDK_VERSION}/bin/jlink -v --add-modules ${JAVA_MODULES} --output /opt/jre11 --no-header-files --no-man-pages --compress 2 && \
    rm -rf /opt/install

ENV JRE_HOME=/opt/jre11
ENV PATH $JRE_HOME/bin:$PATH