# Build:
# docker build -t devstudy/maven:3.6.1 -t devstudy/maven:3 -t devstudy/maven -f ./maven-3.6.1-jdk-11.0.4.dockerfile .
#
# Push:
# docker push devstudy/maven:3.6.1
# docker push devstudy/maven:3
# docker push devstudy/maven
#
# Usage:
# cd ~/my-project
# docker run -v ~/:/home/mvn/ -it --rm -u 1000 -e MAVEN_CONFIG=/home/mvn/.m2 -v "$PWD":/opt/src/ -w /opt/src devstudy/maven mvn -Duser.home=/home/mvn clean install site
#
# Versions:
# ----------------------------------------------------------------------------------------------------------------
ARG MAVEN_VERSION=3.6.1
ARG JDK_VERSION=11.0.4
# ----------------------------------------------------------------------------------------------------------------
FROM devstudy/jdk:${JDK_VERSION}

MAINTAINER devstudy.net

ARG MAVEN_VERSION
ARG MAVEN_FOLDER=apache-maven-${MAVEN_VERSION}
ARG MAVEN_TAR_GZ=${MAVEN_FOLDER}-bin.tar.gz
ARG MAVEN_DOWNLOAD_LINK=http://apache.cp.if.ua/maven/maven-3/${MAVEN_VERSION}/binaries/${MAVEN_TAR_GZ}

RUN mkdir /opt/install && \
    cd /opt/install && \
    # Display download link
    echo Download from ${MAVEN_DOWNLOAD_LINK} && \
    wget ${MAVEN_DOWNLOAD_LINK} && \
    # Display tar file size
    echo ${MAVEN_TAR_GZ} file size: && \
    ls -lh && \
    tar -xzf ${MAVEN_TAR_GZ} && \
    mv /opt/install/${MAVEN_FOLDER} /opt/maven && \
    rm -rf /opt/install && \
    # Remove redundant folder and files
    rm -f /opt/maven/bin/mvn.cmd && \
    rm -f /opt/maven/bin/mvnDebug.cmd

ENV MAVEN_HOME=/opt/maven
ENV PATH $MAVEN_HOME/bin:$PATH

CMD ["mvn"]