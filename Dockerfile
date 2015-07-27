FROM nanobox/base

# Install pkgin packages
RUN rm -rf /var/gonano/db/pkgin && /opt/gonano/bin/pkgin -y up && \
    /opt/gonano/bin/pkgin -y in nanoinit runit narc && \
    rm -rf /var/gonano/db/pkgin

# copy files
ADD scripts/. /var/tmp/

# setup runit
RUN mkdir -p /etc/service
RUN ln -s /etc/service /service

# prepare docker init process
RUN /var/tmp/prepare-docker-init

# Cleanup disk
RUN rm -rf /tmp/* /var/tmp/*

# Run runit automatically
CMD /opt/gonano/bin/nanoinit
