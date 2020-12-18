cmake_minimum_required(VERSION 3.10)

project(CPMTest
        VERSION "1"
        DESCRIPTION "CPM Test"
        HOMEPAGE_URL "https://github.com/flagarde/CMakeCM/blob/master/modules/CPM.cmake"
        LANGUAGES NONE
       )

set(CMAKE_MODULE_PATH "${MODULES_PATH}")

include(Testings)
include(CPM)

cpm(VERSION 0.27.6)

# Nothing change
declare_option(REPOSITORY NO_CHANGE OPTION NAME VALUE Villa)
declare_option(REPOSITORY NO_CHANGE OPTION PRENOM VALUE franck)
declare_option(REPOSITORY NO_CHANGE OPTION AGE VALUE 20)
print_options(REPOSITORY NO_CHANGE)
# Change Age
set(CHANGE_AGE_AGE 18)
declare_option(REPOSITORY CHANGE_AGE OPTION AGE VALUE 20)
declare_option(REPOSITORY CHANGE_AGE OPTION PRENOM VALUE franck)
declare_option(REPOSITORY CHANGE_AGE OPTION NAME VALUE Villa)
print_options(REPOSITORY CHANGE_AGE)
# Change prenom
declare_option(REPOSITORY CHANGE_PRENOM OPTION AGE VALUE 20)
declare_option(REPOSITORY CHANGE_PRENOM OPTION PRENOM VALUE franck)
declare_option(REPOSITORY CHANGE_PRENOM OPTION PRENOM VALUE Louis)
declare_option(REPOSITORY CHANGE_PRENOM OPTION NAME VALUE Villa)
print_options(REPOSITORY CHANGE_PRENOM)


undeclare_option(REPOSITORY NO_CHANGE OPTION PRENOM)
print_options(REPOSITORY NO_CHANGE)

undeclare_all_options(REPOSITORY CHANGE_PRENOM)
print_options(REPOSITORY CHANGE_PRENOM)
