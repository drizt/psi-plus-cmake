set ( PLUGIN gomokugameplugin )
cmake_minimum_required( VERSION 2.8.6 )
set ( CMAKE_AUTOMOC TRUE )
add_definitions ( -Wall -DQT_PLUGIN )
find_package ( Qt4 REQUIRED )
include ( ${QT_USE_FILE} )
include_directories (
	${CMAKE_SOURCE_DIR}
	${CMAKE_CURRENT_BINARY_DIR}
	${QT_QTCORE_INCLUDE_DIR}
	${QT_QTGUI_INCLUDE_DIR}
	${QT_QTXML_INCLUDE_DIR}
	../../include
	.
)
set ( _HDRS
	${PLUGIN}.h
	pluginwindow.h
	boardview.h
	boardmodel.h
	boarddelegate.h
	gameelement.h
	invatedialog.h
	gamesessions.h
	common.h
	options.h
	gamemodel.h
)
set ( _SRCS
	${PLUGIN}.cpp
	pluginwindow.cpp
	boardview.cpp
	boardmodel.cpp
	boarddelegate.cpp
	gameelement.cpp
	invatedialog.cpp
	gamesessions.cpp
	options.cpp
	gamemodel.cpp
)
set ( _UIS
	pluginwindow.ui
	invatedialog.ui
	invitationdialog.ui
	options.ui
)
QT4_WRAP_UI(UIS ${_UIS})

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
	DESTINATION
	${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
	RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
)
endif( WIN32 )
