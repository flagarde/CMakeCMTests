# Module Descriptions :

# Local

## [Colors.cmake](https://github.com/flagarde/CMakeCM/blob/master/modules/Colors.cmake) : ##
Defines some colors and text styles.

### Example :
      
<table>
 <tr>
  <td>
      
```cmake
include(Colors)
  
message(STATUS "${Bold}Bold${Reset}")
message(STATUS "${Faint}Faint${Reset}")
message(STATUS "${Italic}Italic${Reset}")
message(STATUS "${Underline}Underline${Reset}")
message(STATUS "${SlowBlink}SlowBlink${Reset}")
message(STATUS "${RapidBlink}RapidBlink${Reset}")
message(STATUS "${Negative}Negative${Reset}")
message(STATUS "${Crossed}Crossed${Reset}")
message(STATUS "${Fraktur}Fraktur${Reset}")
message(STATUS "${DoubleUnderline}DoubleUnderline${Reset}")
message(STATUS "${Reveal}Reveal${Reset}")
message(STATUS "${Red}Red${Reset}")
message(STATUS "${Green}Green${Reset}")
message(STATUS "${Yellow}Yellow${Reset}")
message(STATUS "${Blue}Blue${Reset}")
message(STATUS "${Magenta}Magenta${Reset}")
message(STATUS "${Cyan}Cyan${Reset}")
message(STATUS "${BackRed}BackRed${Reset}")
message(STATUS "${BackGreen}BackGreen${Reset}")
message(STATUS "${BackYellow}BackYellow${Reset}")
message(STATUS "${BackBlue}BackBlue${Reset}")
message(STATUS "${BackMagenta}BackMagenta${Reset}")
message(STATUS "${BackCyan}BackCyan${Reset}")
message(STATUS "${Framed}Framed${Reset}")
message(STATUS "${Encercled}Encercled${Reset}")
message(STATUS "${Overlined}Overlined${Reset}")
message(STATUS "${BoldRed}BoldRed${Reset}")
message(STATUS "${BoldGreen}BoldGreen${Reset}")
message(STATUS "${BoldYellow}BoldYellow${Reset}")
message(STATUS "${BoldBlue}BoldBlue${Reset}")
message(STATUS "${BoldMagenta}BoldMagenta${Reset}")
message(STATUS "${BoldCyan}BoldCyan${Reset}")

message(STATUS "${BackGreen}It${BackWhite}${Black}al${BackRed}${White}ia${Reset}")
message(STATUS "${BackBlue}Fr${BackWhite}${Black}an${BackRed}${White}ce${Reset}")
```
  </td>
  <td> 
   <p align="center">
    <img src="https://github.com/flagarde/CMakeCM/blob/master/docs/pictures/Colors.png" alt="Colors" />
   </p> 
  </td>
 </tr>
</table>
  
      
## [Messages.cmake](https://github.com/flagarde/CMakeCM/blob/master/modules/Messages.cmake) : ##
Redefines the `message` command to use personnalized styles. `NOTE` `INFO` `WARN` and `ERROR` are created by defaults.

### Example :

<table>
 <tr>
  <td>
  
```cmake
  include(Messages)
  
  add_message_mode(NAME VERY_IMPORTANT 
                   STYLE BoldRed 
                   APPEND_BEGIN "!!!!!" 
                   APPEND_END "!!!!!" 
                   APPEND_STYLE BoldYellow
                  )
  
  message(STATUS "Normal STATUS")
  message(NOTE "This is a NOTE message")
  message(INFO "This is a INFO message")
  message(WARN "This is a WARN message")
  message(ERROR "This is a ERROR message")
  message(VERY_IMPORTANT "This is an VERY_IMPORTANT message")
```
</td>
  <td> 
   <p align="center">
    <img src="https://github.com/flagarde/CMakeCM/blob/master/docs/pictures/Messages.png" alt="Messages" />
  </p>
  </td>
 </tr>
</table>

## [Standards.cmake](https://github.com/flagarde/CMakeCM/blob/master/modules/Standards.cmake) : ##
Set the `CMAKE_C_STANDARD` or `CMAKE_CXX_STANDARD` to the required standard. `CMAKE_CXX_STANDARD_REQUIRED` is set to `ON`, `CMAKE_CXX_EXTENSIONS` is set to `OFF`.

### Example :

```cmake
include(Standards)
# Use c++17 and C11
cxx_17()
c_11()
```

## [PreventInSourceBuilds.cmake](https://github.com/flagarde/CMakeCM/blob/master/modules/PreventInSourceBuilds.cmake) : ##
Prevents building the project from his source directory.

### Example :

```cmake
include(PreventInSourceBuilds)
prevent_in_source_builds()
```

## [DefaultInstallPrefix.cmake](https://github.com/flagarde/CMakeCM/blob/master/modules/DefaultInstallPrefix.cmake) : ##
Set `CMAKE_INSTALL_PREFIX` if it has not been defined before. 

### Example :

```cmake
include(DefaultInstallPrefix)
default_install_prefix(bin)
```

## [Doctest.cmake](https://github.com/flagarde/CMakeCM/blob/master/modules/Doctest.cmake) : ##
Use `CPM` to setup doctest. Use `DOCTEST_REPOSITORY` to select the repository (`onqtam/doctest`) and `DOCTEST_VERSION` to change the version (`master`)

### Example :

```cmake
set(DOCTEST_REPOSITORY "onqtam/doctest")
set(DOCTEST_VERSION "2.4.1")
include(Doctest)
```

## [Testings.cmake](https://github.com/flagarde/CMakeCM/blob/master/modules/Testings.cmake) : ##
Some `CMake` functions to perform some tests in `CMake files`.

### Example :

```cmake
include(Testings)
ASSERT_EQUAL("1" "0")
ASSERT_NOT_EQUAL("0" "0")
ASSERT_NOT_EMPTY(${EMPTY})
set(NOT_EMPTY "NOT_EMPTY")
ASSERT_EMPTY(${NOT_EMPTY})
ASSERT_FILE_NOT_EXISTS("${MODULES_PATH}/Testings.cmake")
ASSERT_FILE_EXISTS("")
```

## [CPM.cmake](https://github.com/flagarde/CMakeCM/blob/master/modules/CPM.cmake) : ##
Wrapper to [CPM](https://github.com/flagarde/CPM) the setup-free `CMake` dependency management. Use the `cpm` function with `VERSION` argument to download CPM. If VERSION is not set the version will be the one in https://github.com/flagarde/CMakeCM/blob/master/modules/CPM.cmake.

```cmake
include(CPM)
cpm(VERSION 0.26.7)
```

## [Ping.cmake](https://github.com/flagarde/CMakeCM/blob/master/modules/Ping.cmake) : ##
Test if you are online. Try to download [Ping](https://github.com/TestingRepositories/Ping) an populate the `IS_ONLINE` and `IS_OFFLINE` variables.

```cmake
include(Ping)

if(${IS_ONLINE} STREQUAL TRUE)
  message(STATUS "I'm online.")
endif()
```

# Remote


