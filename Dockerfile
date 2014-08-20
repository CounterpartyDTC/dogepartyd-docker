FROM ubuntu:14.04
MAINTAINER Lars Kluge <l@larskluge.com>

RUN apt-get update
RUN dpkg-reconfigure locales && locale-gen en_US.UTF-8 && /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get -y install git-core python3 vim sudo

RUN adduser --disabled-password --home /dogeparty --gecos "" dogeparty
RUN echo "dogeparty ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER dogeparty
ENV HOME /dogeparty

WORKDIR /dogeparty
RUN git clone https://github.com/CounterpartyXCP/counterpartyd_build
RUN mkdir data

WORKDIR /dogeparty/counterpartyd_build
RUN git clone https://github.com/Dogeparty/dogepartyd.git dist/counterpartyd
# RUN git checkout develop

RUN yes | sudo python3 setup.py

WORKDIR /dogeparty

COPY dogepartyd.conf /dogeparty/.config/dogepartyd/dogepartyd.conf
RUN sudo chown -R dogeparty:dogeparty .config

VOLUME /dogeparty/data

EXPOSE 4000

