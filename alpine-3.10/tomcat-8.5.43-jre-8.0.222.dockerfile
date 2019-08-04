# Build:
# docker build -t devstudy/tomcat:8.5.43 -t devstudy/tomcat:8 -f ./tomcat-8.5.43-jre-8.0.222.dockerfile .
#
# Push:
# docker push devstudy/tomcat:8.5.43
# docker push devstudy/tomcat:8
#
# Versions:
# ----------------------------------------------------------------------------------------------------------------
ARG TOMCAT8_VERSION=8.5.43
ARG JRE_VERSION=8.0.222
# ----------------------------------------------------------------------------------------------------------------
FROM devstudy/jre:${JRE_VERSION}

MAINTAINER devstudy.net

ARG TOMCAT8_VERSION
ARG TOMCAT8_FOLDER=apache-tomcat-${TOMCAT8_VERSION}
ARG TOMCAT8_TAR_GZ=${TOMCAT8_FOLDER}.tar.gz
ARG TOMCAT8_DOWNLOAD_LINK=https://www-eu.apache.org/dist/tomcat/tomcat-8/v${TOMCAT8_VERSION}/bin/${TOMCAT8_TAR_GZ}

RUN mkdir /opt/install && \
    cd /opt/install && \
    # Display download link
    echo Download from ${TOMCAT8_DOWNLOAD_LINK} && \
    wget ${TOMCAT8_DOWNLOAD_LINK} && \
    # Display tar file size
    echo ${TOMCAT8_TAR_GZ} file size: && \
    ls -lh && \
    tar -xzf ${TOMCAT8_TAR_GZ} && \
    mv /opt/install/${TOMCAT8_FOLDER} /opt/tomcat && \
    # Remove redundant folders and files
    rm -rf /opt/install && \
    rm -rf /opt/tomcat/webapps/docs && \
    rm -rf /opt/tomcat/webapps/examples && \
    rm -rf /opt/tomcat/webapps/host-manager && \
    rm -rf /opt/tomcat/webapps/manager && \
    rm -rf /opt/tomcat/logs && \
    busybox find /opt/tomcat/bin -type f -name "*.bat" -delete && \
    # Redirect tomcat logs to /var/log
    rm -rf /var/log && \
    ln -s /opt/tomcat/logs /var && \
    mv /var/logs /var/log 

# Customize tomcat server
ADD ./tomcat-${TOMCAT8_VERSION}-conf/server.xml            /opt/tomcat/conf
ADD ./tomcat-${TOMCAT8_VERSION}-conf/logging.properties    /opt/tomcat/conf

ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

EXPOSE 8080
CMD ["catalina.sh", "run"]