make -C build
cd build
sudo mount /dev/sdc1 /mnt ; sudo cp boot/kernel.img /mnt/KERNEL.IMG ; md5sum /mnt/KERNEL.IMG ; sudo umount /mnt
