# spot_ros docker

This container runs [ClearPathRobotics' spot_ros driver](https://github.com/clearpathrobotics/spot_ros).

Run it using parameters like so (shown with default values, so you can omit if they match):

```bash
docker run \
    -e username=username \
    -e password=password \
    -e hostname=192.168.50.3 \
    -e vel_topic=/cmd_vel \
    -e enable_mux=false \
    -e launch_file=/spot/config/driver.launch
    --net host \
    --name spot_ros \
    westpointrobotics/spot_ros:noetic

## or with command line
docker run --name spot_ros --net host \
    roslaunch /spot/config/driver.launch username:=user password:=pass #etc.

```

To override default config, mount files into `/spot/config` (or anywhere you choose, really).
By default, the startup script launches `/spot/config/driver.launch`
which in turn expects `/spot/config/spot_ros.yaml`.
If you mount files in elsewhere, be sure to pass a `launch_file` env arg to specify the path (or specify in the command).

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
cd spot-ros-docker
docker build --tag spot_ros .
```

### Bootstrapping persistence

If you want to extract files to use persistently, you could do something like this:

```bash
# pull configs
docker run --rm -v `pwd`:/here westpointrobotics/spot_ros:noetic cp -r config /here

# or pull src 

docker run --rm -v `pwd`:/here westpointrobotics/spot_ros:noetic cp -r src/spot_ros /here

# then set ownership back to yourself

sudo chown -R <user:user> config

```
