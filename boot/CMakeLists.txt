add_executable( kernel
    kernel.c
    boot.S )

objcopy_file(kernel)
