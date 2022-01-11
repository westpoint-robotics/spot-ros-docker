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
    git clone https://github.com/clearpathrobotics/spot_ros.git --depth 1 && \
    catkin build --continue-on-failure

ENTRYPOINT [ "bash", "/spot/spot_entrypoint.sh" ]

