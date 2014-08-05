set( PLUGIN otrplugin )
cmake_minimum_required( VERSION 2.8.11 )
set( CMAKE_AUTOMOC TRUE )
IF( ${WIN32} )
	set( CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules" )
	set( LIBGCRYPT_ROOT "C:\\build\\psideps\\libgcrypt\\i386" CACHE STRING "Path to libgcrypt library" )
	set( LIBGPGERROR_ROOT "C:\\build\\psideps\\libgpg-error\\i386" CACHE STRING "Path to libgpg-error library" )
	set( LIBOTR_ROOT "C:\\build\\psideps\\libotr\\i386" CACHE STRING "Path to libotr library" )
	set( LIBTIDY_ROOT "C:\\build\\psideps\\libtidy\\i386" CACHE STRING "Path to libtidy library" )
	add_definitions( -DQ_WS_WIN )
ENDIF( ${WIN32} )
find_package( LibGcrypt REQUIRED )
find_package( LibOtr REQUIRED )
find_package( LibTidy REQUIRED )
find_package( LibGpgError REQUIRED )
add_definitions(
		-Wall
		-DQT_PLUGIN
		${LIBOTR_DEFINITIONS}
		${LIBTIDY_DEFINITIONS}
		${LIBGCRYPT_DEFINITIONS}
		${LIBGPGERROR_DEFINITIONS}
)
#dirty hack for Qt-5.3.1
IF( USE_QT5 AND WIN32 )
	set(TIDY_INCLUDES
		${LIBTIDY_INCLUDE_DIR}/..
	)
ENDIF( USE_QT5 AND WIN32 )
#
include_directories(
		${CMAKE_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}
		${LIBOTR_INCLUDE_DIR}
		${LIBTIDY_INCLUDE_DIR}
		${LIBGCRYPT_INCLUDE_DIR}
		${LIBGPGERROR_INCLUDE_DIR}
		${TIDY_INCLUDES}
		../../include
		./src
		.
)
set( _HDRS
	src/psiotrplugin.h
	src/otrmessaging.h
	src/otrinternal.h
	src/psiotrconfig.h
	src/psiotrclosure.h
	src/htmltidy.h
	src/otrlextensions.h
)
set( _SRCS
	src/psiotrplugin.cpp
	src/otrmessaging.cpp
	src/otrinternal.cpp
	src/psiotrconfig.cpp
	src/psiotrclosure.cpp
	src/htmltidy.cpp
	src/otrlextensions.c
)
set( _RSCS
	${PLUGIN}.qrc
)
IF( ${USE_QT5} )
	find_package( Qt5Widgets REQUIRED )
	find_package( Qt5Xml REQUIRED )
	find_package( Qt5Concurrent REQUIRED )
	include_directories(
		${Qt5Widgets_INCLUDES}
		${Qt5Xml_INCLUDES}
		${Qt5Concurrent_INCLUDE_DIRS}
	)
	add_definitions(
		${Qt5Widgets_DEFINITIONS}
		${Qt5Xml_DEFINITIONS}
		${Qt5Concurrent_DEFINITIONS}
	)
	set(QT_DEPLIBS
		Qt5::Widgets
		Qt5::Xml
		Qt5::Concurrent
	)
	set(CMAKE_CXX_FLAGS "-std=c++0x ${CMAKE_CXX_FLAGS} ${Qt5Widgets_EXECUTABLE_COMPILE_FLAGS}")
	qt5_add_resources(RSCS ${_RSCS})
ELSE( ${USE_QT5} )
	find_package( Qt4 REQUIRED )
	include( ${QT_USE_FILE} )
	include_directories(
		${QT_QTCORE_INCLUDE_DIR}
		${QT_QTGUI_INCLUDE_DIR}
		${QT_QTXML_INCLUDE_DIR}
	)
	set(QT_DEPLIBS
		${QT_QTCORE_LIBRARY}
		${QT_QTGUI_LIBRARY}
		${QT_QTXML_LIBRARY}
	)
	QT4_ADD_RESOURCES(RSCS ${_RSCS})
ENDIF( ${USE_QT5} )

add_library(
	${PLUGIN}
	SHARED
	${_SRCS}
	${UIS}
	${RSCS}
	${TRS}
	${MOCS}
)
target_link_libraries(
	${PLUGIN}
	${QT_DEPLIBS}
	${LIBOTR_LIBRARY}
	${LIBTIDY_LIBRARY}
	${LIBGCRYPT_LIBRARY}
	${LIBGPGERROR_LIBRARY}
)
if( UNIX AND NOT( APPLE OR CYGWIN ) )
	install(
		TARGETS
		${PLUGIN}
		LIBRARY
		DESTINATION
		${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
	)
endif( UNIX AND NOT( APPLE OR CYGWIN ) )
if( WIN32 )
	install(
		TARGETS
		${PLUGIN}
		LIBRARY
		DESTINATION ${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
		RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
	)
endif( WIN32 )
