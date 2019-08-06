# Build:
# docker build -t devstudy/wildfly:10.1.0 -f ./wildfly-10.1.0-jre-8.0.222.dockerfile .
#
# Push:
# docker push devstudy/wildfly:10.1.0
#
# Run:
# docker run -it --rm -p 80:8080 -p 9990:9990 devstudy/wildfly:10.1.0 standalone.sh -bmanagement 0.0.0.0 -b 0.0.0.0
#
# Versions:
# ----------------------------------------------------------------------------------------------------------------
ARG WILDFLY_VERSION=10.1.0.Final
ARG JRE_VERSION=8.0.222
# ----------------------------------------------------------------------------------------------------------------
FROM devstudy/jre:${JRE_VERSION}

MAINTAINER devstudy.net

ARG WILDFLY_VERSION
ARG WILDFLY_FOLDER=wildfly-${WILDFLY_VERSION}
ARG WILDFLY_TAR_GZ=${WILDFLY_FOLDER}.tar.gz
ARG WILDFLY_DOWNLOAD_LINK=https://download.jboss.org/wildfly/${WILDFLY_VERSION}/${WILDFLY_TAR_GZ}

ARG WILDFLY_ADMIN=admin
ARG WILDFLY_PASSWORD=password

RUN mkdir /opt/install && \
    cd /opt/install && \
    # Display download link
    echo Download from ${WILDFLY_DOWNLOAD_LINK} && \
    wget ${WILDFLY_DOWNLOAD_LINK} && \
    # Display tar file size
    echo ${WILDFLY_FOLDER} file size: && \
    ls -lh && \
    tar -xzf ${WILDFLY_TAR_GZ} && \
    mv /opt/install/${WILDFLY_FOLDER} /opt/wildfly && \
    # Customize Wildfly
    /opt/wildfly/bin/add-user.sh $WILDFLY_ADMIN $WILDFLY_PASSWORD && \
    # Remove redundant folders and files
    rm -rf /opt/install && \
    rm -rf /opt/wildfly/docs && \
    rm -rf /opt/wildfly/README.txt && \
    busybox find /opt/wildfly/bin -type f -name "*.bat" -delete

ENV WILDFLY_HOME /opt/wildfly
ENV PATH $WILDFLY_HOME/bin:$PATH

EXPOSE 8080
EXPOSE 9990

CMD ["standalone.sh", "-b", "0.0.0.0", "-bmanagment", "0.0.0.0"]