FROM nanobox/base

# Install pkgin packages
RUN rm -rf /var/gonano/db/pkgin && /opt/gonano/bin/pkgin -y up && \
    /opt/gonano/bin/pkgin -y in runit narc && \
    rm -rf /var/gonano/db/pkgin

# copy files
ADD files/bin/* /sbin/
ADD scripts/. /var/tmp/

# setup runit
RUN mkdir -p /etc/service
RUN ln -s /etc/service /service

# Install init
RUN /var/tmp/install-init

# Cleanup disk
RUN rm -rf /tmp/* /var/tmp/*

# Run runit automatically
CMD /sbin/my_init