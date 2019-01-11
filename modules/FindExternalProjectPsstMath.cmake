include(ExternalProject)

if (TARGET libpsst-math)
    return()
endif()

ExternalProject_Add(
        psst-math
        GIT_REPOSITORY https://github.com/zmij/math.git
        GIT_TAG develop
        TIMEOUT 10
        PREFIX ${CMAKE_CURRENT_BINARY_DIR}
        CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                -DPSST_MATH_BUILD_TESTS=OFF
                -DPSST_MATH_BUILD_BENCHMARKS=OFF
                -DPSST_MATH_BUILD_EXAMPLES=OFF
                -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
                -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
                -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
        # Disable install step
        INSTALL_COMMAND ""
        # Disable update command, since we use predefined stable version
        UPDATE_COMMAND ""
        # Wrap download, configure and build steps in a script to log output
        LOG_DOWNLOAD ON
        LOG_CONFIGURE ON
        LOG_BUILD ON)

ExternalProject_Get_Property(psst-math source_dir)

set (PSST_MATH_INCLUDE_DIRS ${source_dir}/include)
add_library(libpsst-math IMPORTED INTERFACE)
