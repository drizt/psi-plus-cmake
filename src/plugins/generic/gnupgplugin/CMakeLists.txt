set ( PLUGIN gnupgplugin )
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
	../../include
	.
)
set ( _HDRS
	options.h
	model.h
	gpgprocess.h
	addkeydlg.h
	gnupg.h
	lineeditwidget.h
	datewidget.h
)
set ( _SRCS
	options.cpp
	model.cpp
	gpgprocess.cpp
	addkeydlg.cpp
	gnupg.cpp
	lineeditwidget.cpp
	datewidget.cpp
)
set ( _UIS
	options.ui
	addkeydlg.ui
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
)
