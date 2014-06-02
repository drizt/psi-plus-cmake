set ( PLUGIN videostatusplugin )
cmake_minimum_required( VERSION 2.8.6 )
set ( CMAKE_AUTOMOC TRUE )
if ( NOT WIN32 )
	add_definitions ( -Wall -Ddbus -DQT_PLUGIN )
else ( NOT WIN32 )
	add_definitions ( -Wall -DQ_WS_WIN -DQT_PLUGIN )
endif( NOT WIN32 )
find_package ( Qt4 REQUIRED )
if ( NOT WIN32 )
	set(QTDBUS_INCLUDES ${QT_QTDBUS_INCLUDE_DIR})
	find_package( X11 REQUIRED )
endif( NOT WIN32 )
include ( ${QT_USE_FILE} )
include_directories (
	${CMAKE_SOURCE_DIR}
	${CMAKE_CURRENT_BINARY_DIR}
	${QT_QTCORE_INCLUDE_DIR}
	${QT_QTGUI_INCLUDE_DIR}
	${QT_QTXML_INCLUDE_DIR}
	${QTDBUS_INCLUDES}
	../../include
	.
)
if ( NOT WIN32 )
set ( x11_SRCS
	x11info.cpp
)
set ( x11_HDRS
	x11info.h
)
endif( NOT WIN32 )
set ( _SRCS
	${PLUGIN}.cpp
	${x11_SRCS}
)
set ( _UIS
	options.ui
)
QT4_WRAP_UI(UIS ${_UIS})

set ( _RSCS
	resources.qrc
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
if ( UNIX AND NOT( APPLE OR CYGWIN ) )
target_link_libraries (
	${PLUGIN}
	${X11_LIBRARY}
	${QT_QTCORE_LIBRARY}
	${QT_QTGUI_LIBRARY}
	${QT_QTXML_LIBRARY}
	${QT_QTDBUS_LIBRARY}
)
install (
	TARGETS
	${PLUGIN}
	LIBRARY
	DESTINATION
	${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
)
endif ( UNIX AND NOT( APPLE OR CYGWIN ) )

if ( ${WIN32} )
target_link_libraries (
	${PLUGIN}
	${QT_QTCORE_LIBRARY}
	${QT_QTGUI_LIBRARY}
	${QT_QTXML_LIBRARY}
)
install (
	TARGETS
	${PLUGIN}
	LIBRARY
	DESTINATION
	${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
	RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
)
endif( ${WIN32} )
