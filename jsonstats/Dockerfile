# Build Environment for restfulstatsjson
# Run with 
# curl https://raw.github.com/themurph/dockerize/master/jsonstats/Dockerfile | docker build -rm -t="jsonstats" -

# https://index.docker.io/u/mattdm/fedora/
FROM docker-poc.inception.redhat.com:5000/rhel65

#https://github.com/themurph/dockerize
MAINTAINER Chris Murphy

# We're going to need EPEL and import the keys
RUN rpm -Uvh http://mirror.pnl.gov/epel/6/i386/epel-release-6-8.noarch.rpm
RUN rpm --import https://fedoraproject.org/static/0608B895.txt

# Install Python Modules
RUN yum -y install python python-simplejson PyYAML git facter

# Set up the server
RUN git clone https://github.com/RHInception/jsonstats.git
RUN python /jsonstats/setup.py install

# Open the needful
EXPOSE 8008

# Start up the server
CMD ["/usr/bin/jsonstatsd"]
