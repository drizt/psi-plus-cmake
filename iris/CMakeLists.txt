set( LIB_IRIS iris )
cmake_minimum_required( VERSION 2.8.11 )
cmake_policy(SET CMP0003 NEW)
cmake_policy(SET CMP0020 OLD)

if( WIN32 )
	set(CMAKE_DEBUG_POSTFIX "d")
elseif( APPLE )
	set(CMAKE_DEBUG_POSTFIX "_debug")
endif( WIN32 )

set( CMAKE_AUTOMOC ON )
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set( IRIS_LIB_VERSION_MAJOR 1 )
set( IRIS_LIB_VERSION_MINOR 0 )
set( IRIS_LIB_VERSION_PATCH 0 )
set( IRIS_LIB_VERSION_STRING
	${IRIS_LIB_VERSION_MAJOR}.${IRIS_LIB_VERSION_MINOR}.${IRIS_LIB_VERSION_PATCH}
)

set( CMAKE_MODULE_PATH
	"${CMAKE_MODULE_PATH}"
	"${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules"
	"${CMAKE_CURRENT_SOURCE_DIR}/../cmake/modules"
)
set( LIB_SUFFIX "" CACHE STRING "Define suffix of directory name (32/64)" )
set( LIB_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/lib${LIB_SUFFIX}" CACHE PATH "The directory where lib files will be installed in" )
set( BIN_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/bin" CACHE PATH "The directory where binary files will be installed in" )
set( INCLUDE_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/include" CACHE PATH "The directory the headers are installed in" )
set( QCA_DIR "" CACHE STRING "Set Path to QCA library" )
set( IDN_ROOT "" CACHE STRING "Set Path to libidn library" )
set( ZLIB_ROOT "" CACHE STRING "Set Path to zlib library" )
set( CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin" )
# Use the same path for shared and static library
set( CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib" )
set( CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib" )

option( BUNDLED_QJDNS "Build qjdns with iris library" ON )
option( BUILD_SHARED_LIBS "Build shared library" ON )
option( QT4_BUILD "Build with Qt4 support" ON )
option( BUILD_QJDNS "Buid JDNS Qt-wrapper" ON )
option( BUILD_JDNS_TOOL "Build jdns test tool" OFF )

get_directory_property(hasParent PARENT_DIRECTORY)

if( ${QT4_BUILD} )
	set( USE_QT5 OFF)
else( ${QT4_BUILD} )
	set( USE_QT5 ON)
endif( ${QT4_BUILD} )

if( NOT WIN32 )
	add_definitions( -fPIC )
else( NOT WIN32 )
	if( MINGW )
		add_definitions( -DWIN32 )
	endif( MINGW )
endif( NOT WIN32 )

if( ${USE_QT5} )
	find_package( Qca-qt5 REQUIRED PATHS ${QCA_DIR} )
	get_target_property( QCA_INCLUDES qca-qt5 INTERFACE_INCLUDE_DIRECTORIES )
	set(qca_LIB qca-qt5)
else( ${USE_QT5} )
	find_package( Qca REQUIRED PATHS ${QCA_DIR} )
	get_target_property( QCA_INCLUDES qca INTERFACE_INCLUDE_DIRECTORIES )
	set(qca_LIB qca)
endif( ${USE_QT5} )
find_package( ZLIB REQUIRED )
find_package( IDN REQUIRED )

add_definitions( -DIRIS_XMPP_JID_DEPRECATED )

set( iris_SRCS "" )
set( libiris_INCLUDES "" )
set( iris_HDRS "" )

include_directories(
	${CMAKE_SOURCE_DIR}
	src
	src/xmpp/base
	src/xmpp/base
	src/xmpp/jid
	src/irisnet/noncore/cutestuff
	src/xmpp/xmpp-im
	src/xmpp/sasl
	src/xmpp/zlib
	src/xmpp/base64
	src/xmpp/xmpp-core
	src/xmpp/jingle
	
	src/irisnet/noncore
	src/irisnet/noncore/legacy
	src/irisnet/corelib
	src/irisnet/appledns
	${IDN_INCLUDE_DIR}
	${ZLIB_INCLUDE_DIR}
	${QCA_INCLUDES}
)

if( ${USE_QT5} )
	find_package( Qt5 COMPONENTS Core Gui Network Xml REQUIRED )
	include_directories( ${Qt5Gui_INCLUDE_DIRS} )
	set( CMAKE_CXX_FLAGS "-std=c++0x ${CMAKE_CXX_FLAGS} ${Qt5Core_EXECUTABLE_COMPILE_FLAGS}")
	set( QT_DEPLIBS
		Qt5::Core
		Qt5::Network
		Qt5::Xml
	)
else( ${USE_QT5} )
	find_package( Qt4 COMPONENTS QtGui QtCore QtNetwork QtXml REQUIRED )
	include( ${QT_USE_FILE} )
	set(QT_DEPLIBS
		Qt4::QtCore
		Qt4::QtNetwork
		Qt4::QtXml
	)
endif( ${USE_QT5} )


include( ${CMAKE_CURRENT_SOURCE_DIR}/libiris_includes.cmake )
include( ${CMAKE_CURRENT_SOURCE_DIR}/libiris_sources.cmake )
include( ${CMAKE_CURRENT_SOURCE_DIR}/libiris_headers.cmake )

if( ${BUNDLED_QJDNS} )
	add_subdirectory( src/jdns )
	include_directories(
		src/jdns/include/jdns
	)
else( ${BUNDLED_QJDNS} )
	find_package( QJDns REQUIRED )
	include_directories( ${QJDns_INCLUDE_DIR} )
endif( ${BUNDLED_QJDNS} )
set( qjdns_FILE qjdns )

if( ${BUILD_SHARED_LIBS} )
	add_library( ${LIB_IRIS} SHARED ${iris_SRCS} )
else( ${BUILD_SHARED_LIBS} )
	add_definitions( -DIRISNET_STATIC )
	add_definitions( -DJDNS_STATIC )
	add_library( ${LIB_IRIS} STATIC ${iris_SRCS} )
endif( ${BUILD_SHARED_LIBS} )

set( iris_libs
	${QT_DEPLIBS}
	${qca_LIB}
	${ZLIB_LIBRARIES}
	${IDN_LIBRARIES}
	${qjdns_FILE}
)

if( WIN32 )
	set( iris_libs ${iris_libs} ws2_32 )
endif( WIN32 )

# On Solaris, some of the name resolution functions are in libnsl;
# this needs to be linked in if found. Copied from kdelibs.
include( CheckLibraryExists )
check_library_exists( nsl gethostbyname "" HAVE_NSL_LIBRARY )

if( HAVE_NSL_LIBRARY )
	# This is probably Solaris, and libiris needs to link
	# to libnsl for gethostbyname
	set( iris_libs ${iris_libs} nsl )
endif( HAVE_NSL_LIBRARY )

set_target_properties(
	${LIB_IRIS}
	PROPERTIES
	CLEAN_DIRECT_OUTPUT 1
	VERSION
	${IRIS_LIB_VERSION_STRING}
	PUBLIC_HEADER "${libiris_INCLUDES}"
)

target_link_libraries( ${LIB_IRIS} ${iris_libs} )
if( ${BUNDLED_QJDNS} )
	add_dependencies( ${LIB_IRIS} qjdns )
endif( ${BUNDLED_QJDNS} )

if( NOT hasParent )
	if(NOT MSVC)
		set(IRIS_CONFIG_INSTALL_DIR "${LIB_INSTALL_DIR}/cmake/iris")
	else(NOT MSVC)
		set(IRIS_CONFIG_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/cmake/")
	endif(NOT MSVC)

	file(RELATIVE_PATH relInstallDir ${IRIS_CONFIG_INSTALL_DIR} ${CMAKE_INSTALL_PREFIX})
	file(RELATIVE_PATH IRIS_INCLUDEDIR_REL ${CMAKE_INSTALL_PREFIX} "${INCLUDE_INSTALL_DIR}/iris")
	file(RELATIVE_PATH LIB_INSTALL_DIR_REL ${CMAKE_INSTALL_PREFIX} ${LIB_INSTALL_DIR})

	if(NOT WIN32)
		configure_file(${CMAKE_CURRENT_SOURCE_DIR}/iris.pc.in
				${CMAKE_CURRENT_BINARY_DIR}/iris.pc
				@ONLY
		)
		install(FILES ${CMAKE_CURRENT_BINARY_DIR}/iris.pc
			DESTINATION ${LIB_INSTALL_DIR}/pkgconfig
		)
	endif(NOT WIN32)

	configure_file(
		"${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
		"${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
		IMMEDIATE @ONLY
	)

	configure_file(${CMAKE_CURRENT_SOURCE_DIR}/IrisConfig.cmake.in
			${CMAKE_CURRENT_BINARY_DIR}/IrisConfig.cmake
			@ONLY
	)
	configure_file(${CMAKE_CURRENT_SOURCE_DIR}/IrisConfigVersion.cmake.in
			${CMAKE_CURRENT_BINARY_DIR}/IrisConfigVersion.cmake
			@ONLY
	)
	install(FILES ${CMAKE_CURRENT_BINARY_DIR}/IrisConfig.cmake
			${CMAKE_CURRENT_BINARY_DIR}/IrisConfigVersion.cmake
			DESTINATION ${IRIS_CONFIG_INSTALL_DIR})

	install(EXPORT iris-export DESTINATION ${IRIS_CONFIG_INSTALL_DIR} FILE IrisTargets.cmake)
	if( ${BUILD_SHARED_LIBS} )
		if( UNIX )
			install(
				TARGETS
				${LIB_IRIS}
				EXPORT iris-export
				LIBRARY
				DESTINATION ${LIB_INSTALL_DIR}
				ARCHIVE DESTINATION "${LIB_INSTALL_DIR}/iris"
				PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_PREFIX}/include/iris"
			)
		endif( UNIX )
		if( WIN32 )
			install(
				TARGETS
				${LIB_IRIS}
				EXPORT iris-export
				LIBRARY
				DESTINATION ${BIN_INSTALL_DIR}
				RUNTIME DESTINATION ${BIN_INSTALL_DIR}
				ARCHIVE DESTINATION "${LIB_INSTALL_DIR}/iris"
				PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_PREFIX}/include/iris"
			)
		endif( WIN32 )
	else( ${BUILD_SHARED_LIBS} )
		install(
			TARGETS
			${LIB_IRIS}
			EXPORT iris-export
			LIBRARY
			DESTINATION ${LIB_INSTALL_DIR}
			ARCHIVE DESTINATION "${LIB_INSTALL_DIR}"
			PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_PREFIX}/include/iris"
		)
	endif( ${BUILD_SHARED_LIBS} )
	add_custom_target(uninstall_iris
			"${CMAKE_COMMAND}" -P "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake")
endif( NOT hasParent )
