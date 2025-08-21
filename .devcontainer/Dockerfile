FROM ubuntu:18.04

RUN apt-get update && apt-get -y upgrade && \
    apt-get -f -y install curl python3-pip python-pip && \
    pip3 install --upgrade pip && \
    pip2 install --upgrade pip && \
    pip3 install azure-storage-blob==12.3.0 & \\
    pip3 install azure-cli
