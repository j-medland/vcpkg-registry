cmake_minimum_required(VERSION 3.0.0)
project(test)

find_package(ni-labview-cintools)

# list all variables
get_cmake_property(_variableNames VARIABLES)
list (SORT _variableNames)
foreach (_variableName ${_variableNames})
    message(STATUS "${_variableName}=${${_variableName}}")
endforeach()

