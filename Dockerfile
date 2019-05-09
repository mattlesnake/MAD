# Basic docker image
# Usage:
#   docker build -t pogomad .             # Build the docker Image
#   docker run -d pogomad start.py        # Launch Server

#FROM python:3.7.1-slim
FROM ubuntu
RUN apt-get update && apt-get -y upgrade

#Suppress install dialog
ENV DEBIAN_FRONTEND=noninteractive

#Install utils and python 3
RUN apt-get install -y apt-utils
RUN apt-get update && apt-get install -y vim
RUN apt-get update && apt-get install -y git net-tools iputils-ping
RUN apt-get update && apt-get -y install python3 python3-pip
RUN apt-get install -y software-properties-common

# Default ports for PogoDroid, RGC and MAdmin
EXPOSE 8080 8000 5000

# Working directory for the application
WORKDIR /usr/src/app

# Set Entrypoint with hard-coded options
#ENTRYPOINT ["python"]
#CMD ["./start.py"]
#CMD /bin/bash

# Install required system packages
RUN apt-get update && apt-get install -y --no-install-recommends libgeos-dev build-essential
RUN apt-get update && apt-get -y install libglib2.0-0 default-libmysqlclient-dev
RUN apt-get update && apt-get -y install tesseract-ocr libtesseract-dev

#RUN export DEBIAN_FRONTEND=noninteractive
#RUN apt-get update && apt-get -y install tzdata
#RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime 
#RUN dpkg-reconfigure --frontend noninteractive tzdata

#RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update && apt-get -y install tk
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

RUN apt-get update

COPY requirements.txt /usr/src/app/
COPY requirements_ocr.txt /usr/src/app/

#RUN apt-get update && apt-get install -y git && pip install -r requirements.txt
#RUN apt-get update && apt-get install -y git && pip install -r requirements_ocr.txt

# Copy everything to the working directory (Python files, templates, config) in one go.
COPY . /usr/src/app/

