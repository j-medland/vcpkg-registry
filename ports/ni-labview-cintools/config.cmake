set(LABVIEW_CINTOOLS_PKG_NAME "LVCINTOOLS")

get_filename_component(_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)


get_filename_component(LVCINTOOLS_PATH "${_DIR}/../../"  ABSOLUTE)

set(${LABVIEW_CINTOOLS_PKG_NAME}_FOUND TRUE CACHE BOOL "LabVIEW CINTOOLS found" )
set(${LABVIEW_CINTOOLS_PKG_NAME}_STATIC_LIB_DIRS "${LVCINTOOLS_PATH}/lib/" CACHE PATH "LabVIEW CINTOOLS Static Library Directory")
set(${LABVIEW_CINTOOLS_PKG_NAME}_INCLUDE_DIRS "${LVCINTOOLS_PATH}/include" CACHE PATH "LabVIEW CINTOOLS Include Directory")

if(VCPKG_TARGET_TRIPLET MATCHES "windows")
    set(${LABVIEW_CINTOOLS_PKG_NAME}_LIBRARIES "${LVCINTOOLS_PATH}/lib/labviewv.lib" CACHE PATH "LabVIEW CINTOOLS Static Library Path")
elseif(VCPKG_TARGET_TRIPLET MATCHES "linux")
    #shared library chandged its name between different versions - check for liblv.so
    if(EXISTS "${LVCINTOOLS_PATH}/lib/liblv.so")
        set(${LABVIEW_CINTOOLS_PKG_NAME}_LIBRARIES "${LVCINTOOLS_PATH}/lib/liblv.so" CACHE PATH "LabVIEW CINTOOLS Static Library Path")
    else()
        set(${LABVIEW_CINTOOLS_PKG_NAME}_LIBRARIES "${LVCINTOOLS_PATH}/lib/labviewl.so" CACHE PATH "LabVIEW CINTOOLS Static Library Path")
    endif()
endif()
