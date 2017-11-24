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

#install some dependencies
RUN apt-get update && apt-get install -y \
		bc \
		build-essential \
		cmake \
		curl \
		g++ \
		gfortran \
		git \
		libffi-dev \
		libfreetype6-dev \
		libhdf5-dev \
		libjpeg-dev \
		liblcms2-dev \
		libopenblas-dev \
		liblapack-dev \
		libpng12-dev \
		libssl-dev \
		libtiff5-dev \
		libwebp-dev \
		libzmq3-dev \
		pkg-config \
		software-properties-common \
		unzip \
		vim \
		wget \
		zlib1g-dev \
		qt5-default \
		libvtk6-dev \
		zlib1g-dev \
		libjpeg-dev \
		libwebp-dev \
		libpng-dev \
		libtiff5-dev \
		libjasper-dev \
		libopenexr-dev \
		libgdal-dev \
		libdc1394-22-dev \
		libavcodec-dev \
		libavformat-dev \
		libswscale-dev \
		libtheora-dev \
		libvorbis-dev \
		libxvidcore-dev \
		libx264-dev \
		yasm \
		libopencore-amrnb-dev \
		libopencore-amrwb-dev \
		libv4l-dev \
		libxine2-dev \
		libtbb-dev \
		libeigen3-dev \
        python3 \
		python3-dev \
		ant \
		&& \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/* && \
	update-alternatives --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3
    #linking BLAS library to use OpenBLAS using the alternatives mechanism
    #(https://www.scipy.org/scipylib/building/linux.html#debian-ubuntu)

#install pip
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
	python3 get-pip.py && \
	rm get-pip.py

#add SNI support to python
RUN pip3 --no-cache-dir install \
		pyopenssl \
		ndg-httpsclient \
		pyasn1

#installing base python packages
ADD requirements.txt /app
RUN pip3 install --trusted-host pypi.python.org -r /app/requirements.txt
RUN rm /app/requirements.txt

#installing opencv
RUN git clone --depth 1 https://github.com/opencv/opencv.git /root/opencv && \
	cd /root/opencv && \
	mkdir build && \
	cd build && \
	cmake \
    -DWITH_QT=ON \
    -DWITH_OPENGL=ON \
    -DFORCE_VTK=ON \
    -DWITH_TBB=ON \
    -DWITH_GDAL=ON \
    -DWITH_CUDA=ON \
    -DWITH_XINE=ON \
    -DBUILD_EXAMPLES=ON \
    .. && \
	make -j"$(nproc)"  && \
	make install && \
	ldconfig && \
	echo 'ln /dev/null /dev/raw1394' >> ~/.bashrc

#exposing ports for tensorboard
EXPOSE 6006

#default command
CMD ["/bin/bash"]
