# © Michael Bommarito, 2022
# SPDX: MIT
# NB: This is a demo Dockerfile for Ubuntu 22.04 that includes basic setup for the nala "wrapper" around libapt, which
# can substantially speed up build processes involving large numbers of apt/deb package installs.
# Combine with a local mirror or apt proxy cache for maximum impact.
# To learn more about nala, see https://gitlab.com/volian/nala.

# base
FROM ubuntu:22.04

# ubuntu env
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=UTC

# init apt and cleanup locale first
RUN apt-get update -y --fix-missing && \
    apt-get install -y locales locales-all apt-utils
ENV LC_CTYPE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Vendor nala apt source and key in before apt update (in case egress is restricted and can't access volian.org)
# N.B.: These may change/break in the future or vary by OS (e.g., older deb/ubuntu)
COPY volian-archive-scar-unstable.list /etc/apt/sources.list.d/volian-archive-scar-unstable.list
COPY volian-archive-scar-unstable.gpg /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg

# update cache, patch, and install nala
RUN apt-get update -y --fix-missing \
       && \
       apt-get install -y nala

# N.B. - `nala fetch --auto -c US ..` here below optimizes selection of apt mirror(s)  (-c = ISO 2-letter country).
# If you have very "big" images or actually install packages interactively within your container, you might want
# to uncomment the line below (or just try it out on your machine).
# sudo nala fetch -y --auto -c US --https-only

# Pipe apt requirements from file into nala install.
COPY apt-requirements.txt /tmp/apt-requirements.txt
RUN nala install -y `cat /tmp/apt-requirements.txt | xargs`
#RUN apt install -y `cat /tmp/apt-requirements.txt | xargs`

# clone/build/configure whatever you're actually doing in here

# please don't forget to harden your image if it's going somewhere important
# (yes, I know you're starting from ubuntu/deb, but still...)

# cleanup apt packages and temp
RUN apt-get autoremove -y \
       && \
       apt-get clean -y \
       && \
       rm -rf /tmp/* \
       && \
       rm -rf /var/tmp/* \
       && \
       rm -rf /var/log/*

