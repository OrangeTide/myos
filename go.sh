#!/bin/sh -x

#
# Run this script to setup a build directory
#

die()
{
	echo "Something broke" >&2
	exit 1
}

SRC=${PWD}
BUILD=build/
# T=toolchain-armv7.txt
T=toolchain-arm-none-eabi-rpi.cmake

mkdir -p ${BUILD} || die
cd ${BUILD} || die
cmake ${SRC} -DCMAKE_TOOLCHAIN_FILE=${T} || die
