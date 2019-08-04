# Build:
# docker build -t devstudy/git -f ./git-latest.dockerfile .
#
# Push:
# docker push devstudy/git
#
# Usage:
# cd ~/my-project
# docker run -it --rm -u 1000 -v "$PWD":/opt/src/ -w /opt/src devstudy/git git clone "https://github.com/devstudy-net/docker"
#
# Versions:
# ----------------------------------------------------------------------------------------------------------------
ARG ALPINE_VERSION=3.10
# ----------------------------------------------------------------------------------------------------------------
FROM alpine:${ALPINE_VERSION}

MAINTAINER devstudy.net

RUN apk update && \
    apk upgrade && \
    apk add --no-cache git && \
    rm -rf /var/cache/apk/* && \
    git --version