# DOCKER-VERSION 1.0.0
FROM    centos:6.6
# Enable EPEL for Node.js
RUN     rpm -Uvh  http://ftp.cica.es/epel//6/x86_64/epel-release-6-8.noarch.rpm
# Install Node.js and npm
RUN     yum install -y npm
#Bundle app src
ADD . /src

# Install app dependencies
RUN cd /src; npm install

EXPOSE  8888

CMD ["npm", "start"]