FROM nuagebec/ubuntu
MAINTAINER David Tremblay <david@nuagebec.ca>

#install memcached
RUN apt-get update && \
    apt-get install -y libevent-dev libsasl2-2 sasl2-bin libsasl2-2 libsasl2-dev libsasl2-modules && \
    apt-get install -y memcached  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# #https://github.com/docker/docker/issues/6103
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# define volume
VOLUME /data/persistent

# Define working directory.
WORKDIR /data

ADD set_root_pw.sh /data/set_root_pw.sh
ADD run.sh /data/run.sh


# As suggested here : http://docs.docker.com/articles/using_supervisord/
ADD supervisord_nuagebec.conf /etc/supervisor/conf.d/supervisord_nuagebec.conf


RUN chmod a+x /data/*.sh

# ## Strangely... docker.io don't want build this image since xterm env..
# # ENV TERM="xterm-color"

EXPOSE 22
EXPOSE 11211
CMD ["/data/run.sh"]



