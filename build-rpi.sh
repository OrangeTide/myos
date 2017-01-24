#!/bin/sh -x

#
# Run this script to setup a build directory for RPi1 & RPi2
#

die()
{
	echo "Something broke" >&2
	exit 1
}

SRC=${PWD}
BUILD=build/rpi
T=toolchain-arm-none-eabi-rpi.cmake

if [ ! -d "${BUILD}" ]; then
	cmake -E make_directory "${BUILD}" || die
	cmake -E chdir "${BUILD}" cmake ${SRC} -DCMAKE_TOOLCHAIN_FILE=${T} || die
fi
cmake --build ${BUILD}
