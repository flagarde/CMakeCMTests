include_guard(GLOBAL)

# Tools and Utilities
cmcm_module(Colors.cmake LOCAL modules/Colors.cmake VERSION 1)
cmcm_module(Messages.cmake LOCAL modules/Messages.cmake VERSION 1)
cmcm_module(Standards.cmake LOCAL modules/Standards.cmake VERSION 1)
cmcm_module(DefaultInstallPrefix.cmake LOCAL modules/DefaultInstallPrefix.cmake VERSION 1)
cmcm_module(ClangFormat.cmake LOCAL modules/ClangFormat.cmake VERSION 1)
cmcm_module(CMakeFormat.cmake LOCAL modules/CMakeFormat.cmake VERSION 1)
cmcm_module(PreventInSourceBuilds.cmake LOCAL modules/PreventInSourceBuilds.cmake VERSION 1)
cmcm_module(Doxygen.cmake LOCAL modules/Doxygen.cmake VERSION 1)
cmcm_module(GitInfos.cmake LOCAL modules/GitInfos.cmake VERSION 1)
cmcm_module(ConfigurationCheck.cmake LOCAL modules/ConfigurationCheck.cmake VERSION 1)
cmcm_module(CreateConfigurationTypes.cmake LOCAL modules/CreateConfigurationTypes.cmake VERSION 1)
cmcm_module(DefaultConfigurations.cmake LOCAL modules/DefaultConfigurations.cmake VERSION 1)

cmcm_module(FindFilesystem.cmake LOCAL modules/FindFilesystem.cmake VERSION 1)
cmcm_module(CMakeRC.cmake REMOTE https://raw.githubusercontent.com/vector-of-bool/cmrc/master/CMakeRC.cmake VERSION 1)
cmcm_module(C++Concepts.cmake LOCAL modules/C++Concepts.cmake VERSION 1)
cmcm_module(UseLATEX.cmake REMOTE https://gitlab.kitware.com/kmorel/UseLATEX/raw/Version2.7.0/UseLATEX.cmake VERSION 2.7.0)
cmcm_module(codecov.cmake LOCAL modules/codecov.cmake VERSION 1)
cmcm_module(JSONParser.cmake LOCAL modules/JSONParser.cmake VERSION 1)
cmcm_module(libman.cmake REMOTE https://cdn.statically.io/gh/vector-of-bool/libman/85c5d23e700a9ed6b428aa78cfa556f60b925477/cmake/libman.cmake VERSION 1)

# Package doctest_project.cmake need this one
cmcm_module(doctest.cmake REMOTE https://raw.githubusercontent.com/onqtam/doctest/master/scripts/cmake/doctest.cmake VERSION 1)
cmcm_module(doctest_project.cmake LOCAL modules/doctest_project.cmake VERSION 1)
cmcm_module(CLI11_project.cmake LOCAL modules/CLI11_project.cmake VERSION 1)
cmcm_module(LCIO_project.cmake LOCAL modules/LCIO_project.cmake VERSION 1)
cmcm_module(SIO_project.cmake LOCAL modules/SIO_project.cmake VERSION 1)

# Groups
cmcm_module(Common.cmake LOCAL modules/Common.cmake VERSION 1)
cmcm_module(Formatters.cmake LOCAL modules/Formatters.cmake VERSION 1)

# FindPackages
cmcm_module(FindLcov.cmake LOCAL modules/FindLcov.cmake VERSION 1)
cmcm_module(FindBikeshed.cmake LOCAL modules/FindBikeshed.cmake VERSION 1)
cmcm_module(FindGcov.cmake LOCAL modules/FindGcov.cmake VERSION 1)
cmcm_module(FindSphinx.cmake LOCAL modules/FindSphinx.cmake VERSION 1)
cmcm_module(FindBreathe.cmake LOCAL modules/FindBreathe.cmake VERSION 1)
