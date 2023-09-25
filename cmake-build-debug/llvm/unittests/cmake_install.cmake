# Install script for directory: /home/di/Projects/kagome-llvm/llvm/unittests

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

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/ADT/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/Analysis/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/AsmParser/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/BinaryFormat/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/Bitcode/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/Bitstream/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/CodeGen/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/DebugInfo/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/Debuginfod/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/Demangle/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/DWARFLinkerParallel/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/ExecutionEngine/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/FileCheck/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/Frontend/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/FuzzMutate/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/InterfaceStub/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/IR/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/LineEditor/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/Linker/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/MC/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/MI/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/MIR/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/ObjCopy/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/Object/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/ObjectYAML/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/Option/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/Remarks/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/Passes/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/ProfileData/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/Support/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/TableGen/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/Target/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/TargetParser/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/Testing/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/TextAPI/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/Transforms/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/XRay/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/unittests/tools/cmake_install.cmake")

endif()

