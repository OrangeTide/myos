Step 0. download and install a toolchain. see tools/README.txt

Step 1. eitehr run go.sh or create build directory and run cmake manually

Step 2. go into the build directory and run make

  make VERBOSE=1

Step 3. Try out boot/kernel.bin on your platform

= Running in emulation =

  $YOURINSTALLLOCATION/bin/qemu-system-arm -kernel build/boot/kernel -m 256 -M raspi2 -serial stdio

Note this is using the ELF file and not the raw binary that we intend to boot on real hardware.
