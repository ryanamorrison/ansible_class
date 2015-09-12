# creates a container with sshd and apache2
# Version 1.1
FROM ubuntu:15.04
MAINTAINER Ryan A. Morrison <rmorrison@taos.com>
ENV REFRESHED_AT 07-04-2015 17:00

#Configure Environment
RUN echo 'root:tower' | /usr/sbin/chpasswd
RUN apt-get update

#Ansible needs this on the client
#Ensure it is available from within this
#container
RUN apt-get install -y python-simplejson

#Install/Configure OpenSSH
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed 's/session\s*required\s*pam_loginuid.so/session optional pam_loginuid.so/g' -i /etc/pam.d/sshd

#Install/Configure Apache2
RUN apt-get install -y apache2
RUN mkdir -p /var/lock/apache2 /var/run/apache2

#Install/Configure Supervisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#Allow access
EXPOSE 22 80

#Start supervisor (and other processes)
CMD ["/usr/bin/supervisord"]
