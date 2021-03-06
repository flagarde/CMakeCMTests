find_package(Doxygen OPTIONAL_COMPONENTS dot mscgen dia)
if(NOT DOXYGEN_FOUND)
  message(ERROR "Doxygen is needed to build the documentation ! Skipping docs generation !")
  return()
endif()

set(DOXYFILE_IN ${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in)
set(DOXYFILE ${PROJECT_BINARY_DIR}/docs/Doxyfile)

set(doxy_latex_index_file ${CMAKE_INSTALL_PREFIX}/docs/refman.pdf)

# Options passed to Doxyfile.in
set(DOXYGEN_DOXYFILE_ENCODING "UTF-8")
set(DOXYGEN_PROJECT_LOGO "")
# PROJECT_NAME           = @PROJECT_NAME@ PROJECT_NUMBER         = @PROJECT_VERSION@ PROJECT_BRIEF          = @PROJECT_DESCRIPTION@
set(DOXYGEN_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
set(DOXYGEN_CREATE_SUBDIRS "NO") # Default NO
set(DOXYGEN_ALLOW_UNICODE_NAMES "YES") # Default NO
set(DOXYGEN_OUTPUT_LANGUAGE "English")
set(DOXYGEN_OUTPUT_TEXT_DIRECTION "None")

set(DOXYGEN_BRIEF_MEMBER_DESC "YES")

set(DOXYGEN_GENERATE_LATEX "YES")
set(DOXYGEN_LATEX_OUTPUT "latex")
if(DOXYGEN_GENERATE_LATEX)
  set(DOXYGEN_OUPUTS_LATEX "${CMAKE_CURRENT_BINARY_DIR}/${DOXYGEN_LATEX_OUTPUT}/refman.tex")
endif()

set(DOXYGEN_GENERATE_HTML "YES")
set(DOXYGEN_HTML_OUTPUT "html")
set(DOXYGEN_HTML_FILE_EXTENSION ".html")
if(DOXYGEN_GENERATE_HTML)
  set(DOXYGEN_OUPUTS_HTML "${CMAKE_CURRENT_BINARY_DIR}/${DOXYGEN_HTML_OUTPUT}/index${DOXYGEN_HTML_FILE_EXTENSION}")
endif()

set(DOXYGEN_INPUT ${PROJECT_SOURCE_DIR}/libs)
# SET( doxy_extra_files     ${CMAKE_CURRENT_SOURCE_DIR}/mainpage.dox) # Pasted into Doxyfile.in

if(DOXYGEN_GENERATE_LATEX)
  find_package(LATEX COMPONENTS PDFLATEX)
  if(NOT LATEX_PDFLATEX_FOUND)
    message(ERROR "PdfLaTeX is needed to build the latex documentation.")
    set(DOXYGEN_GENERATE_LATEX "NO")
  else()
    set(DOXYGEN_LATEX_CMD_NAME ${PDFLATEX_COMPILER})
  endif()
endif()

configure_file(${DOXYFILE_IN} ${DOXYFILE} @ONLY)

add_custom_command(
  OUTPUT ${DOXYGEN_OUPUTS_HTML} ${DOXYGEN_OUPUTS_LATEX} ${DOXYFILE}
  COMMAND Doxygen::doxygen ${DOXYFILE}
  BYPRODUCTS ${DOXYFILE}
  MAIN_DEPENDENCY ${DOXYFILE_IN}
  COMMENT "Running Doxygen"
  )
add_custom_target(doc ALL DEPENDS ${DOXYGEN_OUPUTS_HTML} ${DOXYGEN_OUPUTS_LATEX})

if(DOXYGEN_GENERATE_HTML)
  install(DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/html" DESTINATION "${CMAKE_INSTALL_PREFIX}/docs" MESSAGE_NEVER)
endif()

if(DOXYGEN_GENERATE_LATEX)
  add_custom_command(
    OUTPUT ${doxy_latex_index_file}
    COMMAND ${PDFLATEX_COMPILER} -interaction=batchmode -draftmode ${DOXYGEN_OUPUTS_LATEX}
    COMMAND ${PDFLATEX_COMPILER} -interaction=batchmode ${DOXYGEN_OUPUTS_LATEX}
    BYPRODUCTS ${DOXYGEN_OUPUTS_LATEX}
    MAIN_DEPENDENCY ${DOXYGEN_OUPUTS_LATEX}
    DEPENDS doc
    COMMENT "Generating Latex documentation"
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/latex/
    )
  add_custom_target(doc_latex ALL DEPENDS ${doxy_latex_index_file})
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/latex/refman.pdf DESTINATION "${CMAKE_INSTALL_PREFIX}/docs" RENAME ${PROJECT_NAME}Manual.pdf)
endif()
