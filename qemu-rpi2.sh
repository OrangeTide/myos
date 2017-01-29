cat <<END
To start so that gdb can attach to tcp port 1234 add parameters to qemu: -s -S
Then run gdb, example:
  tools/gcc-arm-none-eabi-5_4-2016q3/bin/arm-none-eabi-gdb build/rpi/boot/kernel-rpi2
  > target remote :1234

C-a h    print this help
C-a x    exit emulator
C-a s    save disk data back to file (if -snapshot)
C-a t    toggle console timestamps
C-a b    send break (magic sysrq)
C-a c    switch between console and monitor
C-a C-a  sends C-a
END

qemu-system-arm -M raspi2 -m 256 -nographic -kernel build/rpi/boot/kernel-rpi2 "$@"

