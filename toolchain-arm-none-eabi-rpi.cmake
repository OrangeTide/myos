# A CMake toolchain file so we can cross-compile for the Rapsberry-Pi bare-metal

include(CMakeForceCompiler)

# usage
# cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain-arm-none-eabi.cmake ../

# The Generic system name is used for embedded targets (targets without OS) in
# CMake
set( CMAKE_SYSTEM_NAME          Generic )
set( CMAKE_SYSTEM_PROCESSOR     BCM2835 )

# Set a toolchain path. You only need to set this if the toolchain isn't in
# your system path. Don't forget a trailing path separator!
set( TC_PATH "${CMAKE_SOURCE_DIR}/tools/gcc-arm-none-eabi-5_4-2016q3/bin/" )

# The toolchain prefix for all toolchain executables
set( CROSS_COMPILE arm-none-eabi- )

# specify the cross compiler. We force the compiler so that CMake doesn't
# attempt to build a simple test program as this will fail without us using
# the -nostartfiles option on the command line
CMAKE_FORCE_C_COMPILER( ${TC_PATH}${CROSS_COMPILE}gcc GNU )

# We must set the OBJCOPY setting into cache so that it's available to the
# whole project. Otherwise, this does not get set into the CACHE and therefore
# the build doesn't know what the OBJCOPY filepath is
set( CMAKE_OBJCOPY ${TC_PATH}${CROSS_COMPILE}objcopy
    CACHE FILEPATH "The toolchain objcopy command " FORCE )

#TODO: if(CMAKE_COMPILER_IS_GNUCXX)

set( LINKER_SCRIPT_DIR "${CMAKE_SOURCE_DIR}/ldscripts/arm-none-eabi-rpi" )
message( STATUS "Linker script directory: " ${LINKER_SCRIPT_DIR} )

set( LINKER_SCRIPT "default.lds" )
set( MY_C_LINK_FLAGS "${MY_C_LINK_FLAGS} -T ${LINKER_SCRIPT_DIR}/${LINKER_SCRIPT}" )

# Set the CMAKE C flags (which should also be used by the assembler!
set( MY_C_FLAGS "${MY_C_FLAGS} -mfpu=vfp" )
set( MY_C_FLAGS "${MY_C_FLAGS} -mfloat-abi=hard" )
set( MY_C_FLAGS "${MY_C_FLAGS} -march=armv6zk" )
set( MY_C_FLAGS "${MY_C_FLAGS} -mtune=arm1176jzf-s" )

# embedded system & kernel development
set( MY_C_FLAGS "${MY_C_FLAGS} -nostartfiles" )

# usually a good idea to use libgcc
set( MY_C_FLAGS "${MY_C_FLAGS} -lgcc" )

set( CMAKE_C_FLAGS "${MY_C_FLAGS}" CACHE STRING "" )
set( CMAKE_C_LINK_FLAGS "${MY_C_LINK_FLAGS}" CACHE STRING "" )
set( CMAKE_ASM_FLAGS "${MY_C_FLAGS}" CACHE STRING "" )
set( CMAKE_ASM_LINK_FLAGS "${MY_C_LINK_FLAGS}" CACHE STRING "" )

