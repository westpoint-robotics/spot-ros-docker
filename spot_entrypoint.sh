#!/bin/bash
set -e

source /spot/install/setup.bash

args=""
for e in username password hostname estop_timeout; do
   if [ -n "${!e}" ]; then args="$args ${e}:=${!e}"; fi
done

roslaunch /spot/config/driver.launch $args
