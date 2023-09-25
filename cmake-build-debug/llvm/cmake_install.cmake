# Install script for directory: /home/di/Projects/kagome-llvm/llvm

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "llvm-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES
    "/home/di/Projects/kagome-llvm/llvm/include/llvm"
    "/home/di/Projects/kagome-llvm/llvm/include/llvm-c"
    FILES_MATCHING REGEX "/[^/]*\\.def$" REGEX "/[^/]*\\.h$" REGEX "/[^/]*\\.td$" REGEX "/[^/]*\\.inc$" REGEX "/LICENSE\\.TXT$")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "llvm-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES
    "/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/include/llvm"
    "/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/include/llvm-c"
    FILES_MATCHING REGEX "/[^/]*\\.def$" REGEX "/[^/]*\\.h$" REGEX "/[^/]*\\.gen$" REGEX "/[^/]*\\.inc$" REGEX "/CMakeFiles$" EXCLUDE REGEX "/config\\.h$" EXCLUDE)
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "cmake-exports" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/llvm" TYPE FILE FILES "/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/./lib/cmake/llvm/LLVMConfigExtensions.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Demangle/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Support/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/TableGen/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/utils/TableGen/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/include/llvm/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/utils/FileCheck/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/utils/PerfectShuffle/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/utils/count/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/utils/not/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/utils/UnicodeData/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/utils/yaml-bench/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/utils/split-file/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/third-party/unittest/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/projects/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/tools/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/runtimes/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/examples/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/utils/lit/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/test/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/docs/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/cmake/modules/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/utils/llvm-lit/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/third-party/benchmark/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/benchmarks/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/utils/llvm-locstats/cmake_install.cmake")

endif()

