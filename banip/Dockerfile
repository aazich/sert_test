FROM alpine:3.9
MAINTAINER Karmashkin <vlad@zolotous.com>

RUN apk add --no-cache bash \
                       tzdata \
                       iptables \
                       ipset \
                       iproute2

CMD [ "ping", "localhost" ]
