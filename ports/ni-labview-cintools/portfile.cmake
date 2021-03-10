# determine version to install from feature
# default to 2020
set(LV_VERSION 2020)

if("2019" IN_LIST FEATURES)
    set(LV_VERSION "2019")
elseif("2018" IN_LIST FEATURES)
    set(LV_VERSION "2018")
elseif("2017" IN_LIST FEATURES)
    set(LV_VERSION "2017")
elseif("2016" IN_LIST FEATURES)
    set(LV_VERSION "2016")
elseif("2015" IN_LIST FEATURES)
    set(LV_VERSION "2015")
elseif("2014" IN_LIST FEATURES)
    set(LV_VERSION "2014")
elseif("2013" IN_LIST FEATURES)
    set(LV_VERSION "2013")
elseif("2012" IN_LIST FEATURES)
    set(LV_VERSION "2012")
endif()

# install based on target
if(VCPKG_TARGET_IS_WINDOWS)

    set(LV_PRGRM_FILES_ROOT "Program Files (x86)")

    if(VCPKG_TARGET_ARCHITECTURE MATCHES "x64")
        set(LV_PRGRM_FILES_ROOT "Program Files")
    endif()

    # Get the top level directory to copy files from
    file(TO_NATIVE_PATH "C:/${LV_PRGRM_FILES_ROOT}/National Instruments/LabVIEW ${LV_VERSION}/cintools" LABVIEW_CINTOOLS_ROOT)

    if(NOT EXISTS ${LABVIEW_CINTOOLS_ROOT})
        message(FATAL_ERROR " The directory \"${LABVIEW_CINTOOLS_ROOT}\" does not exist!")
    endif()
    
    message(STATUS " Copying files from ${LABVIEW_CINTOOLS_ROOT}")

    # header files
    file(INSTALL "${LABVIEW_CINTOOLS_ROOT}/" DESTINATION "${CURRENT_PACKAGES_DIR}/include" FILES_MATCHING PATTERN "*.h")
    # lib
    file(INSTALL "${LABVIEW_CINTOOLS_ROOT}/" DESTINATION "${CURRENT_PACKAGES_DIR}/lib" FILES_MATCHING PATTERN "*.lib")

elseif (VCPKG_TARGET_IS_LINUX)

    set(LV_DIR_NAME "LabVIEW-${LV_VERSION}")

    if(VCPKG_TARGET_ARCHITECTURE MATCHES "x64")
         set(LV_DIR_NAME "LabVIEW-${LV_VERSION}-64")
    endif()

# Get the top level directory to copy files from
file(TO_NATIVE_PATH "/usr/local/natinst/${LV_DIR_NAME}/cintools" LABVIEW_CINTOOLS_ROOT)

if(NOT EXISTS ${LABVIEW_CINTOOLS_ROOT})
    message(FATAL_ERROR " The directory \"${LABVIEW_CINTOOLS_ROOT}\" does not exist!")
endif()

message(STATUS " Copying files from ${LABVIEW_CINTOOLS_ROOT}")

# header files
file(INSTALL "${LABVIEW_CINTOOLS_ROOT}/" DESTINATION "${CURRENT_PACKAGES_DIR}/include" FILES_MATCHING PATTERN "*.h")
# so
file(INSTALL "${LABVIEW_CINTOOLS_ROOT}/" DESTINATION "${CURRENT_PACKAGES_DIR}/lib" FILES_MATCHING PATTERN "*.so")

else ()
    message(FATAL_ERROR "Unknown build for this target")
endif ()

## cmake-config-file
file(TO_NATIVE_PATH "${CURRENT_PORT_DIR}/config.cmake" LABVIEW_CINTOOLS_CONFIG)
file(INSTALL "${LABVIEW_CINTOOLS_CONFIG}" DESTINATION "${CURRENT_PACKAGES_DIR}/share/ni-labview-cintools" RENAME "ni-labview-cintools-config.cmake")

# skip the lack of debug but it might mean we miss other files
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
