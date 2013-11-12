# Build Environment for restfulstatsjson
# Run with 
# curl https://raw.github.com/themurph/dockerize/master/restfulstatsjson/Dockerfile | docker build -rm -t="restfulstatsjson" -

# https://index.docker.io/u/mattdm/fedora/
FROM mattdm/fedora:f20

#https://github.com/themurph/dockerize
MAINTAINER Chris Murphy

RUN yum -y update

# Install Python Modules
RUN yum -y install python python-wsgiref git

# Open the needful
EXPOSE 8888

# Set up the server
RUN git clone https://github.com/tbielawa/restfulstatsjson.git
RUN cd restfulstatsjson
RUN source ./hacking/setup-env
RUN chmod +x server.py

# Start up the server
CMD ["./server.py"]
