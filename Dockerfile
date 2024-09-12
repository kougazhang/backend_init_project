# Build Stage
FROM golang:1.15.3 AS build-stage

ENV GO111MODULE=on \
    GOPROXY=https://goproxy.cn,direct

ADD . /opt/nexus
WORKDIR /opt/nexus

RUN make build

FROM alpine:3.16
WORKDIR /app

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
&& apk update && apk add vim && apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone \
&& apk del tzdata

COPY etc/zoneinfo.zip /opt/zoneinfo.zip

RUN apk --update add curl \
&& mkdir -pv /etc/pki/tls/certs/ \


ENV PATH=$PATH:
ENV ZONEINFO /opt/zoneinfo.zip
COPY --from=build-stage /opt/nexus/nexus /app/nexus
#
COPY etc/nexus.toml /app/etc/nexus.toml
COPY docker-entrypoint.sh /app
RUN chmod +x docker-entrypoint.sh && chmod +x nexus
RUN echo "hosts: files dns" > /etc/nsswitch.conf
EXPOSE 8080

CMD sh /app/docker-entrypoint.sh start

