set( PLUGIN juickplugin )
cmake_minimum_required( VERSION 2.8.11 )
set( CMAKE_AUTOMOC TRUE )
add_definitions( -Wall -DQT_PLUGIN )
include_directories(
	${CMAKE_SOURCE_DIR}
	${CMAKE_CURRENT_BINARY_DIR}
	#$
	../../include
	.
)
set( _HDRS
	${PLUGIN}.h
	juickjidlist.h
	juickparser.h
	juickdownloader.h
	defines.h
)
set( _SRCS
	${PLUGIN}.cpp
	juickjidlist.cpp
	juickparser.cpp
	juickdownloader.cpp
)
set( _UIS
	juickjidlist.ui
	settings.ui
)
set( _RSCS
	resources.qrc
)
IF( ${USE_QT5} )
	find_package( Qt5Widgets REQUIRED )
	find_package( Qt5Xml REQUIRED )
	find_package( Qt5Network REQUIRED )
	find_package( Qt5Webkit REQUIRED )
	include_directories(
		${Qt5Widgets_INCLUDES}
		${Qt5Xml_INCLUDES}
		${Qt5Network_INCLUDES}
		${Qt5Webkit_INCLUDES}
	)
	add_definitions(
		${Qt5Widgets_DEFINITIONS}
		${Qt5Xml_DEFINITIONS}
		${Qt5Network_DEFINITIONS}
		${Qt5Webkit_DEFINITIONS}
	)
	set(QT_DEPLIBS
		Qt5::Widgets
		${Qt5Xml_LIBRARIES}
		${Qt5Network_LIBRARIES}
		${Qt5Webkit_LIBRARIES}
	)
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
		${QT_QTNETWORK_INCLUDE_DIR}
		${QT_QTWEBKIT_INCLUDE_DIR}
	)
	set(QT_DEPLIBS
		${QT_QTCORE_LIBRARY}
		${QT_QTGUI_LIBRARY}
		${QT_QTXML_LIBRARY}
		${QT_QTNETWORK_LIBRARY}
		${QT_QTWEBKIT_LIBRARY}
	)
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
target_link_libraries(
	${PLUGIN}
	${QT_DEPLIBS}
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
		DESTINATION
		${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
		RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
	)
endif( WIN32 )
