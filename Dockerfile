FROM nanobox/base:feature_release-2017-11

# Install pkgin packages
RUN rm -rf /var/gonano/db/pkgin && /opt/gonano/bin/pkgin -y up && \
    /opt/gonano/bin/pkgin -y in nanoinit runit narc openssh && \
    rm -rf /var/gonano/db/pkgin/cache

# copy files
ADD scripts/. /var/tmp/

# setup runit
RUN mkdir -p /etc/service
RUN ln -s /etc/service /service

# prepare docker init process
RUN /var/tmp/prepare-docker-init

# Cleanup disk
RUN docker_prepare

# Run runit automatically
CMD /opt/gonano/bin/nanoinit
