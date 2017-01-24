cmake_minimum_required( VERSION 2.8 )

# Mark the project as C so that CMake doesn't try to test the compiler for C++
project( myOS C ASM )

# add a place for additional modules
LIST( APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake" )

# include some things that aren't modules
include( "${CMAKE_CURRENT_SOURCE_DIR}/cmake/objcopy_file.cmake" )

# We had to adjust the CMAKE_C_FLAGS variable in the toolchain file to make sure
# the compiler would work with CMake's simple program compilation test. So unset
# it explicitly before re-setting it correctly for our system

# enable some warnings
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O2" )
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g" )

# use some non-unix conventions for the linker
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wl,--sort-common" )
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wl,--warn-common" )

add_subdirectory (boot)
