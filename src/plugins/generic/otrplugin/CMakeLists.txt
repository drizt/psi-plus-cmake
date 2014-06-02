set ( PLUGIN otrplugin )
cmake_minimum_required( VERSION 2.8.6 )
set ( CMAKE_AUTOMOC TRUE )
find_package ( Qt4 REQUIRED )
find_package ( LibGcrypt REQUIRED )
find_package ( LibOtr REQUIRED )
find_package ( LibTidy REQUIRED )
find_package ( LibGpgError REQUIRED )
include ( ${QT_USE_FILE} )
add_definitions (
		-Wall
		-DQT_PLUGIN
		${LIBOTR_DEFINITIONS}
		${LIBTIDY_DEFINITIONS}
		${LIBGCRYPT_DEFINITIONS}
		${LIBGPGERROR_DEFINITIONS}
)
include_directories (
		${CMAKE_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}
		${QT_QTCORE_INCLUDE_DIR}
		${QT_QTGUI_INCLUDE_DIR}
		${QT_QTXML_INCLUDE_DIR}
		${LIBOTR_INCLUDE_DIR}
		${LIBTIDY_INCLUDE_DIR}
		${LIBGCRYPT_INCLUDE_DIR}
		${LIBGPGERROR_INCLUDE_DIR}
		../../include
		./src
		.
)
set ( _HDRS
	src/psiotrplugin.h
	src/otrmessaging.h
	src/otrinternal.h
	src/psiotrconfig.h
	src/psiotrclosure.h
	src/htmltidy.h
	src/otrlextensions.h
)
set ( _SRCS
	src/psiotrplugin.cpp
	src/otrmessaging.cpp
	src/otrinternal.cpp
	src/psiotrconfig.cpp
	src/psiotrclosure.cpp
	src/htmltidy.cpp
	src/otrlextensions.c
)
set ( _RSCS
	${PLUGIN}.qrc
)
QT4_ADD_RESOURCES(RSCS ${_RSCS})
add_library (
	${PLUGIN}
	SHARED
	${_SRCS}
	${UIS}
	${RSCS}
	${TRS}
	${MOCS}
)
target_link_libraries (
	${PLUGIN}
	${QT_QTCORE_LIBRARY}
	${QT_QTGUI_LIBRARY}
	${QT_QTXML_LIBRARY}
	${LIBOTR_LIBRARY}
	${LIBTIDY_LIBRARY}
	${LIBGCRYPT_LIBRARY}
	${LIBGPGERROR_LIBRARY}
)
if ( UNIX AND NOT( APPLE OR CYGWIN ) )
install (
	TARGETS
	${PLUGIN}
	LIBRARY
	DESTINATION
	${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
)
endif ( UNIX AND NOT( APPLE OR CYGWIN ) )
if ( WIN32 )
install (
	TARGETS
	${PLUGIN}
	LIBRARY
	DESTINATION ${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
	RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
)
endif( WIN32 )
