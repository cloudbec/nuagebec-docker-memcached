FROM nuagebec/ubuntu:14.04
MAINTAINER David Tremblay <david@nuagebec.ca>

#install memcached
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y libevent-dev libsasl2-2 sasl2-bin libsasl2-2 libsasl2-dev libsasl2-modules && \
    apt-get install -y memcached  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD supervisor_memcached.conf /etc/supervisor/conf.d/memcached.conf 

RUN mkdir /var/log/memcached/
RUN useradd memcached

EXPOSE 11211
CMD ["/data/run.sh"]

