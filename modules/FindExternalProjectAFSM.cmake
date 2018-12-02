include(ExternalProject)

if (TARGET libafsm)
    return()
endif()

find_program(GIT git)

ExternalProject_ADD(
    afsm
    DEPENDS metapushkin
    GIT_REPOSITORY https://github.com/zmij/afsm.git
    GIT_TAG develop
    TIMEOUT 10
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DAFSM_BUILD_TESTS=OFF
        -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
        -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
        -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
    # Disable install step
    INSTALL_COMMAND ""
    # Disable update command, since we use predefined stable version
    UPDATE_COMMAND ${GIT} pull
    # Wrap download, configure and build steps in a script to log output
    LOG_DOWNLOAD ON
    LOG_CONFIGURE ON
    LOG_BUILD ON)

ExternalProject_Get_Property(afsm source_dir binary_dir)
set (AFSM_INCLUDE_DIRS ${source_dir}/include ${METAPUSHKIN_INCLUDE_DIRS})
file (MAKE_DIRECTORY ${AFSM_INCLUDE_DIRS})

add_library(libafsm IMPORTED INTERFACE)
