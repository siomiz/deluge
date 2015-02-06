FROM ubuntu:14.04

MAINTAINER Tomohisa Kusano <siomiz@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get install -y software-properties-common \
	&& add-apt-repository -y ppa:deluge-team/ppa \
	&& apt-get update \
	&& apt-get install -y deluged deluge-web \
	&& apt-get purge -y software-properties-common \
	&& apt-get autoremove -y --purge \
	&& apt-get clean

RUN deluged --config /opt/deluged.conf.d && sleep 3 && pkill deluged
RUN deluge-web --fork --config /opt/deluge-web.conf.d && sleep 3 && pkill deluge-web

VOLUME ["/opt/deluge-web.conf.d"]

EXPOSE 8112 58846

CMD ["deluge-web", "--config", "/opt/deluge-web.conf.d", "--base", "/deluge/"]
