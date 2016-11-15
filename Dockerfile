FROM alpine:3.3

ENV GOPATH /home/go
ENV PACKAGE github.com/sammy007/ether-proxy

RUN apk --update add -ut build-deps \
    go \
    git \
    g++

RUN git clone https://$PACKAGE.git $GOPATH/src/$PACKAGE && \
    cd $GOPATH/src/$PACKAGE && \
    go get; exit 0 && \
    go build -o /bin/ether-proxy -ldflags "-s" main.go

RUN rm -rf $GOPATH && \
    apk del --purge build-deps

# Metadata params
ARG BUILD_DATE
ARG VERSION
ARG VCS_URL
ARG VCS_REF
# Metadata
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="ether-proxy" \
      org.label-schema.description="Running ether-proxy in docker container" \
      org.label-schema.url="https://etherchain.org/" \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vendor="AnyBucket" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0" \
      com.microscaling.docker.dockerfile="/Dockerfile"
      
ENTRYPOINT ["/docker-entrypoint.sh"]
