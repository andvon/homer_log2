# syntax=docker/dockerfile:1

FROM alpine:3.18.2

ADD ./use_log2_scores.patch /homer/use_log2_scores.patch
ENV PATH=/homer/bin/:$PATH

RUN apk add --no-cache \
	bash \
	gcc \
	g++ \
	make \
	patch \
	perl \
	R \
	wget \
	zip
RUN cd /homer \
	&& wget http://homer.ucsd.edu/homer/configureHomer.pl \
	&& perl configureHomer.pl -install homer -version v4.9.1 \
	&& patch -p0 < use_log2_scores.patch \
	&& cd cpp \
	&& make \
	&& cd ~
