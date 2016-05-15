if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "")
endif()

project(psi-plus)
cmake_minimum_required(VERSION 2.8.11)

set(GLOBAL_DEPENDS_DEBUG_MODE ON)

set( CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules" )
option( BUNDLED_IRIS "Build iris library bundled" ON )
#This option will be changed when build of psi+ will be ready
option( ONLY_PLUGINS "Build psi-plus plugins only" OFF )
option( USE_HUNSPELL "Build psi-plus plugins only" ON )
option( USE_ENCHANT "Build psi-plus plugins only" OFF )
option( SEPARATE_QJDNS "Build qjdns as separate lib" ON )
option( USE_QT5 "Use Qt5 to build psi-plus" ON )
option( ENABLE_PLUGINS "Enable plugins" OFF )
set(PSI_PLUS_VERSION "" CACHE STRING "Version string of Psi+")

if(WIN32)
  set(QCA_DIR "c:/build/psibuild/psideps/qca/i386" CACHE STRING "Path to QCA")
  set(IDN_ROOT "c:/build/psibuild/psideps/libidn/i386" CACHE STRING "Path to IDN library")
  set(HUNSPELL_ROOT "c:/build/psibuild/psideps/hunspell/i386" CACHE STRING "Path to hunspell library")
  set(LIBGCRYPT_ROOT "c:/build/psibuild/psideps/libgcrypt/i386" CACHE STRING "Path to libgcrypt library")
  set(LIBGPGERROR_ROOT "c:/build/psibuild/psideps/libgpg-error/i386" CACHE STRING "Path to libgpg-error library")
  set(LIBOTR_ROOT "c:/build/psibuild/psideps/libotr/i386" CACHE STRING "Path to libotr library")
  set(LIBTIDY_ROOT "c:/build/psibuild/psideps/libtidy/i386" CACHE STRING "Path to libtidy library")
  set(QJSON_ROOT "c:/build/psibuild/psideps/qjson/i386" CACHE STRING "Path to qjson library")
  set(ZLIB_ROOT "c:/build/psibuild/psideps/zlib/i386" CACHE STRING "Path to zlib")
  set(QJDNS_DIR "c:/build/psibuild/psideps/qjdns/i386" CACHE STRING "Path to qjdns")
endif()

set(APP_VERSION "0.16")
option(PRODUCTION "Build production version" OFF)

# Define LINUX on Linux like as WIN32 on Windows and APPLE on Mac OS X
if(UNIX AND NOT APPLE)
  set(LINUX ON)
endif()

# Qt dependencies make building very slow
# Track only .h files
include_regular_expression("^.*\\.h$")

# Put Wime executable in build root dir
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/psi" )

# Enable C++11
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

# Enable all warnings
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra")

# Make all warnings into errors only for release buildings
#if(CMAKE_BUILD_TYPE STREQUAL Release OR CMAKE_BUILD_TYPE STREQUAL RelWithDbInfo)
#  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror -Wno-error=cpp")
#  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror -Wno-error=cpp")
#endif()

if(APPLE)
  # Force Qt5 build on Mac OS X. Qt4 is not supported
  set(USE_QT5 ON)
endif()

if(USE_QT5)
  option( QT4_BUILD "Build with Qt4 support" OFF )
else()
  set( USE_QT5 OFF)
  option( QT4_BUILD "Build with Qt4 support" ON )
endif()

# Copy a list of files from one directory to another. Only full paths.
function(copy SOURCE DEST TARGET)
  set(OUT_TARGET_FILE "${CMAKE_BINARY_DIR}/${TARGET}.cmake")

  string(REGEX REPLACE "\\\\+" "/" DEST "${DEST}")
  string(REGEX REPLACE "\\\\+" "/" SOURCE "${SOURCE}")

  if(NOT TARGET ${TARGET})
    file(REMOVE "${OUT_TARGET_FILE}")
    add_custom_target(${TARGET} COMMAND ${CMAKE_COMMAND} -P "${OUT_TARGET_FILE}")
  endif()

  if(IS_DIRECTORY ${SOURCE})
    # copy directory
    file(GLOB_RECURSE FILES "${SOURCE}/*")
    get_filename_component(SOURCE_DIR_NAME ${SOURCE} NAME)

    foreach(FILE ${FILES})
      file(RELATIVE_PATH REL_PATH ${SOURCE} ${FILE})
      set(REL_PATH "${SOURCE_DIR_NAME}/${REL_PATH}")
      get_filename_component(REL_PATH ${REL_PATH} DIRECTORY)
      set(DESTIN "${DEST}/${REL_PATH}")

      string(REGEX REPLACE "/+" "/" DESTIN ${DESTIN})
      string(REGEX REPLACE "/+" "/" FILE ${FILE})

      file(APPEND
        "${OUT_TARGET_FILE}"
        "file(INSTALL \"${FILE}\" DESTINATION \"${DESTIN}\" USE_SOURCE_PERMISSIONS)\n")
    endforeach()
  else()
    string(REPLACE "//" "/" DEST ${DEST})
    if(DEST MATCHES "/$")
      set(DIR "${DEST}")
      string(REGEX REPLACE "^(.+)/$" "\\1" DIR ${DIR})
    else()
      # need to copy and rename
      get_filename_component(DIR ${DEST} DIRECTORY)
      get_filename_component(FILENAME ${DEST} NAME)
      get_filename_component(SOURCE_FILENAME ${SOURCE} NAME)
    endif()
    file(APPEND
      "${OUT_TARGET_FILE}"
      "file(INSTALL \"${SOURCE}\" DESTINATION \"${DIR}\" USE_SOURCE_PERMISSIONS)\n")
    if(DEFINED FILENAME)
      file(APPEND
        "${OUT_TARGET_FILE}"
        "file(RENAME \"${DIR}/${SOURCE_FILENAME}\" \"${DIR}/${FILENAME}\")\n")
    endif()
  endif()
endfunction()

# Configure CCache if available
find_program(CCACHE_PATH ccache DOC "Path to ccache")
if(CCACHE_PATH)
  message(STATUS "Found ccache at ${CCACHE_PATH}")
  set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ${CCACHE_PATH})
  set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ${CCACHE_PATH})
endif()
      

if(NOT ONLY_PLUGINS)
if( ${BUNDLED_IRIS} )
	set( BUILD_SHARED_LIBS OFF )
	add_subdirectory( iris )
else( ${BUNDLED_IRIS} )
	find_package( Iris REQUIRED )
endif( ${BUNDLED_IRIS} )
set( iris_LIB iris )

add_subdirectory(src)

copy("${CMAKE_SOURCE_DIR}/iconsets/" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/iconsets/" prepare-bin)
copy("${CMAKE_SOURCE_DIR}/themes/" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/themes/" prepare-bin)
copy("${CMAKE_SOURCE_DIR}/sound/" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/sound/" prepare-bin)
copy("${CMAKE_SOURCE_DIR}/skins/" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/skins/" prepare-bin)

if(WIN32)
  copy("${CMAKE_SOURCE_DIR}/myspell/" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/myspell/" prepare-bin)
endif()

else()
	set(ENABLE_PLUGINS ON)
	add_subdirectory(src/plugins)
endif()
