# syntax=docker/dockerfile:1.6

FROM mcr.microsoft.com/playwright/python:latest

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Etc/UTC
ARG PY_VER=3.11

# add deadsnakes repo
RUN apt-get update \
    && apt-get install --no-install-recommends -y dirmngr gpg-agent software-properties-common \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F23C5A6CF475977595C89F51BA6932366A755776 \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# TODO: pin specific version of python (full semver)
# install python
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        python${PY_VER} \
        python${PY_VER}-dev \
        python${PY_VER}-distutils \
        python${PY_VER}-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# set workdir
WORKDIR /root
