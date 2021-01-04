cmake_minimum_required(VERSION 3.5)
project(Test)

# Download CMakeCM
set(
  CMAKECM_BASE_URL "https://raw.githubusercontent.com/flagarde/CMakeCM/master" 
  CACHE STRING "URL of the CMakeCM package"
  )
set(
  CMAKECM_SHA256 "a5739917401b3bddbd8a32e280008ed98aa1311cf1f217ac78490c800ed2ff9a" 
  CACHE STRING "SHA256 of CMakeCM"
  )
set(
  CMAKECM_INSTALL_DIR "${CMAKE_BINARY_DIR}/cmake/CMakeCM" 
  CACHE STRING "Path where to install CMakeCM"
  )
set(CMAKECM_MODULES_DIR "${CMAKECM_INSTALL_DIR}/Modules")
file(
  DOWNLOAD "${CMAKECM_BASE_URL}/CMakeCM.cmake" "${CMAKECM_INSTALL_DIR}/CMakeCM.cmake" 
  INACTIVITY_TIMEOUT 5 
  TIMEOUT 5 
  EXPECTED_HASH SHA256=${CMAKECM_SHA256}
  )
include("${CMAKECM_INSTALL_DIR}/CMakeCM.cmake")
