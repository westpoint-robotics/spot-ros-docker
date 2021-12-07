# spot_ros docker

This container runs ClearPathRobotics' spot_ros driver.
It simply listens for `cmd_vel` and drives the motors.

Run it using parameters like so:

```bash
docker run \
    -e username=username \
    -e password=password \
    -e hostname=hostip \
    --net host \
    --name spot_ros \
    westpointrobotics/spot_ros:noetic
```

To override default config, mount files into `/spot/config`.
The startup script launches `/spot/config/driver.launch`
which in turn expects `/spot/config/spot_ros.yaml`.

Add whatever you'd like, but name the starting launch file `driver.launch`.

example arg to mount a config volume:
```bash
 -v `pwd`/config:/spot/config

 # or just the yaml file
 -v `pwd`/my.yaml:/spot/config/spot_ros.yaml
```

### Build
If you want to build this container locally, rather than pulling from Docker Hub:

```bash
git clone https://github.com/westpoint-robotics/spot-ros-docker.git
cd spot_ros
docker build --tag spot_ros .
```

### Bootstrapping persistence

If you want to extract files to use persistently, you could do something like this:

```bash
mkdir ~/spot-work
cd ~/spot-work
docker run --rm -it -v `pwd`:/work --entrypoint bash westpointrobotics/spot_ros:noetic
# either 
$ cp /spot/config/* /work
# or for the original clearpath configs
$ cp /spot/src/spot_ros/config/* /work
$ exit

# edit files in current directory as desired
# then mount your current directory into container over /spot/config
docker run -e hostname=... -v `pwd`:/spot/config --name spottest westpointrobotics/spot_ros:noetic

```