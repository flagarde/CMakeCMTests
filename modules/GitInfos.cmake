include_guard(GLOBAL)

include(Messages)

if(NOT EXISTS "${CMAKE_SOURCE_DIR}/.git")
  message(WARN "${CMAKE_SOURCE_DIR} doesn't contains .git folder")
else()
  find_package(Git QUIET)
  if(GIT_FOUND)
    set(REPOSITORY_NAME "" CACHE STRING "Name of the repository on the hosting website")
    set(DEPOT_PROVIDER "" CACHE STRING "Depot provider")
    set(HOSTING_BASEURL "" CACHE STRING "Base URL of the hosting company")
    # Get the REPOSITORY_NAME DEPOT_PROVIDER and HOSTING_BASEURL
    execute_process(COMMAND ${GIT_EXECUTABLE} "config" "--get" "remote.origin.url" RESULT_VARIABLE RESULT OUTPUT_VARIABLE OUTPUT)

    # Get REPOSITORY_NAME
    string(FIND ${OUTPUT} "/" REPOSITORY_NAME_START REVERSE)
    math(EXPR REPOSITORY_NAME_START_P1 "${REPOSITORY_NAME_START}+1")
    string(SUBSTRING ${OUTPUT} ${REPOSITORY_NAME_START_P1} 9999 REPOSITORY_NAME)
    string(LENGTH ${REPOSITORY_NAME} REPOSITORY_NAME_SIZE)
    math(EXPR REPOSITORY_NAME_SIZE "${REPOSITORY_NAME_SIZE}-5")
    string(SUBSTRING ${REPOSITORY_NAME} 0 ${REPOSITORY_NAME_SIZE} REPOSITORY_NAME)

    # Get DEPOT_PROVIDER
    string(SUBSTRING ${OUTPUT} 0 ${REPOSITORY_NAME_START} OUTPUT)
    string(FIND ${OUTPUT} "/" DEPOT_PROVIDER_START REVERSE)
    math(EXPR DEPOT_PROVIDER_START_P1 "${DEPOT_PROVIDER_START}+1")
    string(SUBSTRING ${OUTPUT} ${DEPOT_PROVIDER_START_P1} 999 DEPOT_PROVIDER)

    # Get HOSTING_BASEURL
    string(SUBSTRING ${OUTPUT} 0 ${DEPOT_PROVIDER_START} HOSTING_BASEURL)
  else()
    message(WARN "Git program not found !")
  endif()
endif()
