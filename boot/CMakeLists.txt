add_executable( kernel
    kernel.c )

objcopy_file(kernel)
#add_custom_command(
#    TARGET kernel POST_BUILD
#    COMMAND ${CMAKE_OBJCOPY} $<TARGET_FILE_NAME:kernel> -O binary ./kernel.img
#    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
#    COMMENT "Convert the ELF output file to a binary image" )
