#!/bin/bash
set -e

source /spot/install/setup.bash

args=""
for e in username password hostname estop_timeout vel_topic enable_mux; do
  if [ -n "${!e}" ]; then args="$args ${e}:=${!e}"; fi
done

# if no command, process env vars
if [ -z "$*" ]; then

    launch_file=${launch_file:-/spot/config/driver.launch}
    exec roslaunch $launch_file $args

else

    # run provided command
    exec $@

fi
