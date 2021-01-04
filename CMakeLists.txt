cmake_minimum_required(VERSION 3.8)
project(test-cmake VERSION 0.1 LANGUAGES C CXX)

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug CACHE STRING
        "Choose the type of build, options are: Debug Release." FORCE)
endif (NOT CMAKE_BUILD_TYPE)

# Enable clang-tidy
set(CMAKE_CXX_CLANG_TIDY
    clang-tidy;
    -header-filter=.;
    -checks=*;)

# Common
set(CMAKE_C_FLAGS                     "-std=c11 -fstack-protector-all -Wstack-protector")
set(CMAKE_CXX_FLAGS                   "-std=c++11 -fstack-protector-all -Wstack-protector")
set(CMAKE_SHARED_LINKER_FLAGS         "-Wl,--no-as-needed")
set(CMAKE_MODULE_LINKER_FLAGS         "-Wl,--no-as-needed")

# Per target flags
# Debug, CMAKE_C_FLAGS is prepended to CMAKE_C_FLAGS_DEBUG and so on, don't duplicate...
set(CMAKE_C_FLAGS_DEBUG               "-O0 -ggdb3 -DDEBUG -fno-inline -fPIC")
set(CMAKE_CXX_FLAGS_DEBUG             "-O0 -ggdb3 -DDEBUG -fno-inline -fPIC")
set(CMAKE_SHARED_LINKER_FLAGS_DEBUG   "")
set(CMAKE_MODULE_LINKER_FLAGS_DEBUG   "")

# Release
set(CMAKE_C_FLAGS_RELEASE             "-O3 -ggdb3 -DNDEBUG -D_FORTIFY_SOURCE=2")
set(CMAKE_CXX_FLAGS_RELEASE           "-O3 -ggdb3 -DNDEBUG -D_FORTIFY_SOURCE=2")
set(CMAKE_SHARED_LINKER_FLAGS_RELEASE "")
set(CMAKE_MODULE_LINKER_FLAGS_RELEASE "")

set(SRC_LIST main.cpp test.cpp)

add_executable(${PROJECT_NAME} ${SRC_LIST})
