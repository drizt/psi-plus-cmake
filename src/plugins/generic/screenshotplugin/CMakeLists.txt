set ( PLUGIN screenshotplugin )
cmake_minimum_required( VERSION 2.8.6 )
set ( CMAKE_AUTOMOC TRUE )
add_definitions ( -Wall )
find_package ( Qt4 REQUIRED )
include ( ${QT_USE_FILE} )
include_directories (
	${CMAKE_SOURCE_DIR}
	${CMAKE_CURRENT_BINARY_DIR}
	${QT_QTCORE_INCLUDE_DIR}
	${QT_QTGUI_INCLUDE_DIR}
	${QT_QTXML_INCLUDE_DIR}
	${QT_QTNETWORK_INCLUDE_DIR}
	../../include
	qxt/core
	qxt/gui
	.
)
if ( ${UNIX} AND NOT( ${APPLE} OR ${CYGWIN} ) )
	find_package( X11 REQUIRED )
	add_definitions ( -DX11 )
	set ( qxt_X11_SRCS
		qxt/gui/qxtwindowsystem_x11.cpp
		qxt/gui/x11info.cpp
	)
	set ( qxt_X11_HDRS
		qxt/gui/x11info.h
	)
endif()
if ( ${APPLE} )
	set ( qxt_mac_SRCS
		qxt/gui/qxtwindowsystem_mac.cpp
	)
	set ( qxt_mac_HRDS
		qxt/gui/qxtwindowsystem_mac.h
	)
endif()
if ( ${WIN32} )
	set ( qxt_win_SRCS
		qxt/gui/qxtwindowsystem_win.cpp
	)
endif()
set ( _HDRS
	screenshot.h
	server.h
	editserverdlg.h
	screenshotoptions.h
	toolbar.h
	pixmapwidget.h
	options.h
	optionsdlg.h
	optionswidget.h
	iconset.h
	controller.h
	defines.h
	proxysettingsdlg.h
	qxt/core/qxtglobal.h
	qxt/gui/qxtwindowsystem.h
	${qxt_X11_HDRS}
	${qxt_mac_HRDS}
)
set ( _SRCS
	${PLUGIN}.cpp
	screenshot.cpp
	server.cpp
	editserverdlg.cpp
	screenshotoptions.cpp
	toolbar.cpp
	pixmapwidget.cpp
	options.cpp
	optionsdlg.cpp
	optionswidget.cpp
	iconset.cpp
	controller.cpp
	proxysettingsdlg.cpp
	qxt/core/qxtglobal.cpp
	qxt/gui/qxtwindowsystem.cpp
	${qxt_X11_SRCS}
	${qxt_mac_SRCS}
	${qxt_win_SRCS}
)
set ( _UIS
	optionswidget.ui
	editserverdlg.ui
	screenshot.ui
	screenshotoptions.ui
	optionsdlg.ui
	proxysettingsdlg.ui
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
	${X11_LIBRARIES}
	${QT_QTCORE_LIBRARY}
	${QT_QTGUI_LIBRARY}
	${QT_QTXML_LIBRARY}
	${QT_QTNETWORK_LIBRARY}
)
install (
	TARGETS
	${PLUGIN}
	LIBRARY
	DESTINATION
	${CMAKE_INSTALL_PREFIX}/${PLUGINS_PATH}
)
