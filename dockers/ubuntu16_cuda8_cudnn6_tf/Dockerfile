#cuda8 + cudnn6 base image
FROM nvidia/cuda:8.0-cudnn6-runtime-ubuntu16.04

#maintainer
LABEL maintainer="Erik Perilo <erik.perillo@gmail.com>"

#for nvidia gpus
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
#image was tested in this driver version
ENV NVIDIA_RECOMMENDED_DRIVER_VERSION=384.90

#working dir
WORKDIR /app

#some dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        apt-get install -y \
        build-essential \
        cmake \
        git \
        wget \
        unzip \
        yasm \
        pkg-config \
        libswscale-dev \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libjasper-dev \
        libavformat-dev \
        libpq-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#installing pip3
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py

#installing base python packages
ADD requirements.txt /app
RUN pip3 install --trusted-host pypi.python.org -r requirements.txt
RUN rm /app/requirements.txt

#exposing port 6006 for tensorboard
EXPOSE 6006

#default command to run
CMD ["nvidia-smi"]
