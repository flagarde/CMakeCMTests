include(Messages)

if(NOT DEFINED BREATHE_VERSION)
  set(BREATHE_VERSION "4.25.1" CACHE INTERNAL "Breathe version." )
endif()

if(NOT DEFINED SPHINX_VERSION)
  set(SPHINX_VERSION "3.3.1" CACHE INTERNAL "Sphinx version.")
endif()

include(Sphinx)

find_package(Breathe ${BREATHE_VERSION} QUIET)

if(BREATHE_FOUND)
  message(NOTE "Found breathe-apidoc : ${BREATHE_EXECUTABLE} (found version \"${BREATHE_VERSION_FOUND}\")")
else()
  include(Pip)
  message(NOTE "Installing breathe ${BREATHE_VERSION}")
  execute_process(COMMAND ${PIP_EXECUTABLE} "install" "Breathe==${BREATHE_VERSION}" "--target=${PIP_PACKAGES_PATH}" "--upgrade")
  find_package(Breathe ${BREATHE_VERSION} QUIET)
  if(BREATHE_FOUND)
    message(NOTE "Found breathe-apidoc : ${BREATHE_EXECUTABLE} (found version \"${BREATHE_VERSION_FOUND}\")")
  endif()
endif()

