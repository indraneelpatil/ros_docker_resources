FROM ros:kinetic-ros-core-xenial

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO

#install ros packages
RUN apt-get update && apt-get install -y \
      ros-kinetic-tf \
      ros-kinetic-robot-localization \
      ros-kinetic-realtime-tools \
      ros-kinetic-navigation \
      ros-kinetic-teb-local-planner \
      ros-kinetic-tf2 && \
    rm -rf /var/lib/apt/lists/*

# Dependencies 
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
	git \
        build-essential \
        libtool \
        autoconf \
        automake \
        pkg-config \
        unzip \
        libkrb5-dev \
	libzmq3-dev \
        libpthread-stubs0-dev \
	libboost-dev 

#build and install zeromq (used by behaviour trees)
RUN cd /tmp && git clone git://github.com/jedisct1/libsodium.git && cd libsodium && git checkout e2a30a && ./autogen.sh && ./configure && make check && make install && ldconfig 
RUN cd /tmp && git clone --depth 1 git://github.com/zeromq/libzmq.git && cd libzmq && ./autogen.sh && ./configure && \
    make && make install && ldconfig && \
    rm -rf /tmp/*

#build and install spdlog
RUN cd /tmp && \
	git clone --recursive https://github.com/gabime/spdlog.git && \
	mkdir -p spdlog/build && cd spdlog/build && \
	cmake .. && make -j$(nproc) install && \
	rm -rf /tmp/*

#build and install Behaviour Trees
RUN cd /tmp && \
        git clone --recursive https://github.com/BehaviorTree/BehaviorTree.CPP.git && \
        mkdir -p BehaviorTree.CPP/build && cd BehaviorTree.CPP/build && \
        cmake .. && make -j$(nproc) install && \
        rm -rf /tmp/*


# launch ros package
#CMD ["ros2", "launch", "demo_nodes_cpp", "talker_listener.launch.py"]


# setup entrypoint
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"] 
#arm64 

