add_executable( kernel
    kernel.c
    boot.S
    vector.S )

objcopy_file(kernel)
