FROM  winhong/prometheus-rancher-exporter:base
#gliderlabs/alpine:3.4
MAINTAINER winhong

EXPOSE 9173

#RUN addgroup exporter \
# && adduser -S -G exporter exporter
USER root 
#COPY . /go/src/github.com/winhong/prometheus-rancher-exporter

#RUN apk --update add ca-certificates \
# && apk --update add --virtual build-deps go git 


COPY . /go/src/github.com/winhong/prometheus-rancher-exporter

RUN cd /go/src/github.com/winhong/prometheus-rancher-exporter \
 && GOPATH=/go go get \
 && GOPATH=/go go build -o /bin/rancher_exporter 

# && apk del --purge build-deps 
# && rm -rf /go/bin /go/pkg /var/cache/apk/*

USER exporter

ENTRYPOINT [ "/bin/rancher_exporter" ]
