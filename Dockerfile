FROM nuagebec/ubuntu
MAINTAINER David Tremblay <david@nuagebec.ca>

#install memcached
RUN apt-get update && \
    apt-get install -y libevent-dev libsasl2-2 sasl2-bin libsasl2-2 libsasl2-dev libsasl2-modules && \
    apt-get install -y memcached  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD supervisor_memcached.cond /etc/supervisor/conf.d/supervisor-memcached.conf 

EXPOSE 11211
CMD ["/data/run.sh"]



