add_llvm_library(LLVMTestingSupport
  Annotations.cpp
  Error.cpp
  SupportHelpers.cpp

  BUILDTREE_ONLY

  ADDITIONAL_HEADER_DIRS
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/Testing/Support

  LINK_COMPONENTS
  Support
  )

if(HUNTER_ENABLED)
  hunter_add_package(GTest)
  find_package(GTest CONFIG REQUIRED)
  target_link_libraries(LLVMTestingSupport PRIVATE GTest::gtest)
else()

target_link_libraries(LLVMTestingSupport PRIVATE gtest)

endif()
