cat <<END
C-a h    print this help
C-a x    exit emulator
C-a s    save disk data back to file (if -snapshot)
C-a t    toggle console timestamps
C-a b    send break (magic sysrq)
C-a c    switch between console and monitor
C-a C-a  sends C-a
END

qemu-system-arm -nographic -kernel build/rpi/boot/kernel-rpi2 -m 256 -M raspi2

