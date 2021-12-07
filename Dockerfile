FROM ros:noetic
WORKDIR /spot
COPY . .

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        git \
        python3-pip \
        python3-catkin-tools \
        ros-noetic-tf2-msgs \
        ros-noetic-tf2-ros \
    && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir cython bosdyn-client bosdyn-mission bosdyn-api bosdyn-core empy

RUN mkdir src && \
    catkin config --init --extend /opt/ros/noetic --install --merge-install --blacklist spot_viz --cmake-args -DCMAKE_BUILD_TYPE=Release  && \
    cd src && \
    git clone https://github.com/clearpathrobotics/spot_ros.git && \
    catkin build --continue-on-failure

ENV USERNAME dummyusername
ENV PASSWORD dummypassword
ENV HOSTNAME 192.168.50.3

CMD [ "bash", "spot_entrypoint.sh" ]
