#FindExternalProjectZmijModules.cmake
# Created on: Dec 2, 2018
#     Author: ser-fedorov
include(ExternalProject)

if (TARGET libzmijcmake)
    return()
endif()

ExternalProject_Add(
        zmij-cmake
        GIT_REPOSITORY https://github.com/zmij/cmake-scripts.git
        GIT_TAG develop
        TIMEOUT 10
        PREFIX ${CMAKE_CURRENT_BINARY_DIR}
        CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
                -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
                -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
        # Disable install step
        INSTALL_COMMAND git pull
        # Disable update command, since we use predefined stable version
        UPDATE_COMMAND ""
        # Wrap download, configure and build steps in a script to log output
        LOG_DOWNLOAD ON
        LOG_CONFIGURE ON
        LOG_BUILD ON)

ExternalProject_Get_Property(zmij-cmake source_dir)

add_library(libzmijcmake IMPORTED INTERFACE)
include(${source_dir}/CMakeLists.txt)
