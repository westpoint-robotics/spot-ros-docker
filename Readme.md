# spot_ros docker

This container runs ClearPathRobotics' spot_ros driver.
It simply listens for `cmd_vel` and drives the motors.

Run it using parameters like so:

```bash
docker run -d \
    -e username=username \
    -e password=password \
    -e hostname=hostip \
    -p 11310:11311 \
    --name spot_ros \
    spot_ros:noetic
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

For simple networking with the host,
bind a host port to the container's ros port like `-p 11310:11311`.
Then you can set on the host something like:
```bash
export ROS_MASTER_URL=localhost:11310
export ROS_HOSTNAME=172.17.0.1
```
