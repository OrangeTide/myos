add_library( rpi-common STATIC
    kernel.c
    boot.S
    vector.S
    itoa.c
    strlen.c
 )
set_property( TARGET rpi-common PROPERTY INTERFACE_POSITION_INDEPENDENT_CODE ON )

# rpi2 version of the kernel
add_executable( kernel-rpi2 boot-rpi2.S platform-rpi2.S )
set_property( TARGET kernel-rpi2 PROPERTY POSITION_INDEPENDENT_CODE ON )
target_link_libraries( kernel-rpi2 rpi-common )
objcopy_file( kernel-rpi2 )

# rpi1 version of the kernel
add_executable( kernel-rpi1 boot-rpi1.S platform-rpi1.S )
set_property( TARGET kernel-rpi1 PROPERTY POSITION_INDEPENDENT_CODE ON )
target_link_libraries( kernel-rpi1 rpi-common )
objcopy_file( kernel-rpi1 )
