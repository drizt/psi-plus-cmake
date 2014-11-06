set( PLUGIN videostatusplugin )
cmake_minimum_required( VERSION 2.8.11 )
set( CMAKE_AUTOMOC TRUE )
add_definitions( -Wall -DQT_PLUGIN )
if( NOT WIN32 )
	add_definitions( -Ddbus )
	find_package( X11 REQUIRED )
else( NOT WIN32 )
	add_definitions( -DQ_WS_WIN )
endif( NOT WIN32 )
include_directories(
	${CMAKE_SOURCE_DIR}
	${CMAKE_CURRENT_BINARY_DIR}
	../../include
	.
)
if( NOT WIN32 )
set( x11_SRCS
	x11info.cpp
)
set( x11_HDRS
	x11info.h
)
endif( NOT WIN32 )
set( _SRCS
	${PLUGIN}.cpp
	${x11_SRCS}
)
set( _UIS
	options.ui
)
set( _RSCS
	resources.qrc
)
IF( ${USE_QT5} )
	find_package( Qt5Widgets REQUIRED )
	find_package( Qt5Xml REQUIRED )
	include_directories(
		${Qt5Widgets_INCLUDES}
		${Qt5Xml_INCLUDES}
	)
	add_definitions(
		${Qt5Widgets_DEFINITIONS}
		${Qt5Xml_DEFINITIONS}
	)
	IF( UNIX AND NOT( APPLE OR CYGWIN ) )
		find_package( Qt5Dbus REQUIRED )
		include_directories( ${Qt5Dbus_INCLUDES} )
		add_definitions( ${Qt5Dbus_DEFINITIONS} )
	ENDIF( UNIX AND NOT( APPLE OR CYGWIN ) )
	set(QT_DEPLIBS
		Qt5::Widgets
		Qt5::Xml
	)
	IF( UNIX AND NOT( APPLE OR CYGWIN ) )
		set(QT_DEPLIBS "${QT_DEPLIBS}" "${Qt5Dbus_LIBRARIES}" )
	ENDIF( UNIX AND NOT( APPLE OR CYGWIN ) )
	set(CMAKE_CXX_FLAGS "-std=c++0x ${CMAKE_CXX_FLAGS} ${Qt5Widgets_EXECUTABLE_COMPILE_FLAGS}")
	qt5_wrap_ui(UIS ${_UIS})
	qt5_add_resources(RSCS ${_RSCS})
ELSE( ${USE_QT5} )
	find_package( Qt4 REQUIRED )
	include( ${QT_USE_FILE} )
	include_directories(
		${QT_QTCORE_INCLUDE_DIR}
		${QT_QTGUI_INCLUDE_DIR}
		${QT_QTXML_INCLUDE_DIR}

	)
	IF( UNIX AND NOT( APPLE OR CYGWIN ) )
		include_directories(${QT_QTDBUS_INCLUDE_DIR})
	ENDIF( UNIX AND NOT( APPLE OR CYGWIN ) )
	set(QT_DEPLIBS
		${QT_QTCORE_LIBRARY}
		${QT_QTGUI_LIBRARY}
		${QT_QTXML_LIBRARY}
	)
	IF( UNIX AND NOT( APPLE OR CYGWIN ) )
		set(QT_DEPLIBS "${QT_DEPLIBS}" "${QT_QTDBUS_LIBRARY}" )
	ENDIF( UNIX AND NOT( APPLE OR CYGWIN ) )
	QT4_WRAP_UI(UIS ${_UIS})
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
if( UNIX AND NOT( APPLE OR CYGWIN ) )
	target_link_libraries(
		${PLUGIN}
		${X11_LIBRARY}
		${QT_DEPLIBS}
	)
	install(
		TARGETS
		${PLUGIN}
		LIBRARY
		DESTINATION
		${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
		RUNTIME DESTINATION
		${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
	)
endif( UNIX AND NOT( APPLE OR CYGWIN ) )

if( ${WIN32} )
	target_link_libraries(
		${PLUGIN}
		${QT_DEPLIBS}
	)
	install(
		TARGETS
		${PLUGIN}
		LIBRARY
		DESTINATION
		${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
		RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
	)
endif( ${WIN32} )
