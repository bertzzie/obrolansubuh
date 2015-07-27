FROM ubuntu:trusty

MAINTAINER Alex Xandra Albert Sim "bertzzie@gmail.com"

RUN apt-get -y update && apt-get install -y \
    git \
    mercurial \
    bzr \
    curl \
    build-essential \
    ca-certificates \
    nodejs \
    npm

# Install golang
RUN mkdir /goroot && \
    curl https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | \
    tar xvzf - -C /goroot --strip-components=1
RUN mkdir /gopath

ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

# Create working dir
RUN mkdir -p /gopath/src/obrolansubuh.com
WORKDIR /gopath/src/obrolansubuh.com

COPY . /gopath/src/obrolansubuh.com/

# Symlink backend's satic file
RUN ln -s ../static backend/public

# Install dependencies
RUN go get github.com/revel/revel
RUN go get github.com/revel/cmd/revel

# Run obrolansubuh.com
ENTRYPOINT revel run obrolansubuh.com/backend prod 9000

EXPOSE 9000
