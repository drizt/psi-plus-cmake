if(NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Release" CACHE STRING "")
endif()

project(psi-plus)
cmake_minimum_required(VERSION 3.0.2)

set(GLOBAL_DEPENDS_DEBUG_MODE ON)

set( CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules" )
option( BUNDLED_IRIS "Build iris library bundled" ON )
option( ONLY_PLUGINS "Build psi-plus plugins only" OFF )
option( USE_HUNSPELL "Build psi-plus with hunspell spellcheck" ON )
option( USE_ENCHANT "Build psi-plus with enchant spellcheck" OFF )
option( SEPARATE_QJDNS "Build qjdns as separate lib" OFF )
option( USE_QT5 "Use Qt5 to build psi-plus" ON )
option( ENABLE_PLUGINS "Enable plugins" OFF )
option( ENABLE_WEBKIT "Enable webkit support" ON )
set( ENABLE_SQL OFF CACHE BOOL "Enable SQL history support")

if(EXISTS "${PROJECT_SOURCE_DIR}/src/historyimp.cpp")
	message("-- SQL history - enabled")
	set(ENABLE_SQL ON)
else()
	set(ENABLE_SQL OFF)
endif()

if(ENABLE_WEBKIT)
	message("-- Webkit - enabled")
endif()

if(WIN32)
	if(MSVC)
		set(BUILD_ARCH "win64" CACHE STRING "CPU architecture win32/win64")
		set(SDK_PATH "c:/build/newsdk" CACHE STRING "Path to SDK")
		set(SDK_SUFFIX ${BUILD_ARCH})
		set(LIBGCRYPT_SDK "libotr")
		set(LIBGPGERROR_SDK "libotr")
	else()
		set(BUILD_ARCH "i386" CACHE STRING "CPU architecture i386/x86_64")
		set(SDK_PATH "c:/build/psibuild/psideps" CACHE STRING "Path to SDK")
		set(SDK_SUFFIX ${BUILD_ARCH})
		#temporary Qt5
		if(USE_QT5)
			set(SDK_PATH "${SDK_PATH}/Qt5")
			set(SDK_SUFFIX "")
		endif()
		set(LIBGCRYPT_SDK "libgcrypt")
		set(LIBGPGERROR_SDK "libgpg-error")
	endif()
	set(QCA_DIR "${SDK_PATH}/qca/${SDK_SUFFIX}/" CACHE STRING "Path to QCA")
	set(IDN_ROOT "${SDK_PATH}/libidn/${SDK_SUFFIX}/" CACHE STRING "Path to IDN library")
	set(HUNSPELL_ROOT "${SDK_PATH}/hunspell/${SDK_SUFFIX}/" CACHE STRING "Path to hunspell library")
	set(LIBGCRYPT_ROOT "${SDK_PATH}/${LIBGCRYPT_SDK}/${SDK_SUFFIX}/" CACHE STRING "Path to libgcrypt library")
	set(LIBGPGERROR_ROOT "${SDK_PATH}/${LIBGPGERROR_SDK}/${SDK_SUFFIX}/" CACHE STRING "Path to libgpg-error library")
	set(LIBOTR_ROOT "${SDK_PATH}/libotr/${SDK_SUFFIX}/" CACHE STRING "Path to libotr library")
	set(LIBTIDY_ROOT "${SDK_PATH}/libtidy/${SDK_SUFFIX}/" CACHE STRING "Path to libtidy library")
	set(QJSON_ROOT "${SDK_PATH}/qjson/${SDK_SUFFIX}" CACHE STRING "Path to qjson library")
	set(ZLIB_ROOT "${SDK_PATH}/zlib/${SDK_SUFFIX}/" CACHE STRING "Path to zlib")
	set(QJDNS_DIR "${SDK_PATH}/qjdns/${SDK_SUFFIX}/" CACHE STRING "Path to qjdns")
	set(GST_SDK "${SDK_PATH}/gstbundle/${SDK_SUFFIX}/" CACHE STRING "Path to gstreamer SDK")
	set(PSIMEDIA_DIR "${SDK_PATH}/psimedia/${SDK_SUFFIX}/" CACHE STRING "Path to psimedia plugin")
	set(PLUGINS_PATH "/plugins" CACHE STRING "Install suffix for plugins")
endif()

set(APP_VERSION "0.16")
set(PSI_PLUS_VERSION "${APP_VERSION}-dev" CACHE STRING "Version string of Psi+")

option(PRODUCTION "Build production version" OFF)

# Define LINUX on Linux like as WIN32 on Windows and APPLE on Mac OS X
if(UNIX AND NOT APPLE)
	set(LINUX ON)
endif()

# Qt dependencies make building very slow
# Track only .h files
include_regular_expression("^.*\\.h$")

# Put executable in build root dir
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/psi" )

if(APPLE)
	# Force Qt5 build on Mac OS X. Qt4 is not supported
	set(USE_QT5 ON)
else()
# Enable all warnings
        if(NOT MSVC)
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --std=c++11 -Wall -Wextra")
		set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra")
		set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O2")
		set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -O2")
	else()
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")
	endif()
endif()

if(USE_QT5)
	option( QT4_BUILD "Build with Qt4 support" OFF )
else()
	set( USE_QT5 OFF)
	option( QT4_BUILD "Build with Qt4 support" ON )
endif()

# Copy a list of files from one directory to another. Only full paths.
function(copy SOURCE DEST TARGET)
	if(EXISTS ${SOURCE})
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
		add_subdirectory( iris )
	else( ${BUNDLED_IRIS} )
		find_package( Iris REQUIRED )
		include_directories(${Iris_INCLUDE_DIR})
	endif( ${BUNDLED_IRIS} )
	set( iris_LIB iris )

	add_subdirectory(src)

	copy("${PROJECT_SOURCE_DIR}/iconsets/" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/iconsets/" prepare-bin)
	copy("${PROJECT_SOURCE_DIR}/themes/" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/themes/" prepare-bin)
	copy("${PROJECT_SOURCE_DIR}/sound/" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/sound/" prepare-bin)
	copy("${PROJECT_SOURCE_DIR}/skins/" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/skins/" prepare-bin)
	copy("${PROJECT_SOURCE_DIR}/client_icons.txt" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/" prepare-bin)

	if(WIN32)
		copy("${PROJECT_SOURCE_DIR}/myspell/" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/myspell/" prepare-bin)
	endif()
else()
	set(ENABLE_PLUGINS ON)
	add_subdirectory(src/plugins)
endif()
