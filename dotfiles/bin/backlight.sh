#!/bin/sh
# Script to change screen backlight
########################################################################
# Constants
BL_BASE_PATH=/sys/class/backlight/intel_backlight
BL_BRIGHTNESS=${BL_BASE_PATH}/brightness
BL_MAX_BRIGHTNESS=${BL_BASE_PATH}/max_brightness

# Locals
is_increase=false
is_decrease=false
bl_step=10

########################################################################
usage() {
  echo "-h    Shows this help"
  echo "-i    Icrease backlight"
  echo "-d    Decrease backlight"
  echo "-s    Increase / decrease backlight step"
}

########################################################################
get_bl_value() {
  cat ${BL_BRIGHTNESS}
}

########################################################################
set_bl_value() {
  echo ${1} >> ${BL_BRIGHTNESS}
}

########################################################################
get_max_bl_value() {
  cat ${BL_MAX_BRIGHTNESS}
}

########################################################################
increase_bl() {
  bl_value=$(get_bl_value)
  max_bl_value=$(get_max_bl_value)

  bl_value=$((${bl_value} + ${bl_step}))
  if [ ${bl_value} -gt ${max_bl_value} ]
  then
    bl_value=${max_bl_value}
  fi

  set_bl_value ${bl_value}
}

########################################################################
decrease_bl() {
  bl_value=$(get_bl_value)

  bl_value=$((${bl_value} - ${bl_step}))
  if [ ${bl_value} -lt 0 ]
  then
    bl_value=0
  fi

  set_bl_value ${bl_value}
}

########################################################################
while getopts ":hids:" opt
do
  case $opt in
    h)
      usage
      exit 0
      ;;
    i)
      is_increase=true
      ;;
    d)
      is_decrease=true
      ;;
    s)
      bl_step=$OPTARG
      ;;
    \?)
      echo "Unkown argument: $OPTARG"
      usage
      exit 1
      ;;
  esac
done

if ${is_increase} && ${is_decrease}
then
  echo "-i and -d options are exclusive!"
  exit 1
elif ${is_increase}
then
  increase_bl
elif ${is_decrease}
then
  decrease_bl
else
  echo "Specify at least -i or -d option"
fi
