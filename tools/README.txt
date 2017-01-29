= Installing Toolchain =

Download a bare-metal toolchain from http://www.linaro.org/downloads/
It is preferable to have ARMv7 support in the toolchain in order to build for rpi2. An older ARMv5 toolchain can be made to work for rpi1 support.

== Download ==

  wget https://releases.linaro.org/components/toolchain/binaries/latest/arm-eabi/gcc-linaro-6.2.1-2016.11-x86_64_arm-eabi.tar.xz

== Install ==

  cd tools/
  tar axvf gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2

== Configure ==

Modify toolchain-arm-none-eabi-rpi.cmake to point to your toolchain and use the appropriate prefix.

= Alternate Toolchains =

 * https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads

== Direct Links ==

 * https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2
 * https://developer.arm.com/-/media/Files/downloads/gnu-rm/6-2016q4/gcc-arm-none-eabi-6_2-2016q4-20161216-linux.tar.bz2
