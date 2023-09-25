# Install script for directory: /home/di/Projects/kagome-llvm/llvm/lib/Target

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

if(CMAKE_INSTALL_COMPONENT STREQUAL "LLVMTarget" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/libLLVMTarget.a")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/AArch64/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/AMDGPU/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/ARM/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/AVR/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/BPF/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/Hexagon/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/Lanai/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/LoongArch/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/Mips/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/MSP430/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/NVPTX/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/PowerPC/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/RISCV/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/Sparc/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/SystemZ/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/VE/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/WebAssembly/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/X86/cmake_install.cmake")
  include("/home/di/Projects/kagome-llvm/cmake-build-debug/llvm/lib/Target/XCore/cmake_install.cmake")

endif()

