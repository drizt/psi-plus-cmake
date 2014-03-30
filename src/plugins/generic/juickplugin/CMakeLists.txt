project( juickplugin )
cmake_minimum_required( VERSION 2.8.6 )
set ( CMAKE_BUILD_TYPE Release )
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
	${QT_QTWEBKIT_INCLUDE_DIR}
	../../include
	.
)

set ( _HDRS
	${PROJECT_NAME}.h
	juickjidlist.h
	juickparser.h
	juickdownloader.h
	defines.h
)

set ( _SRCS
	${PROJECT_NAME}.cpp
	juickjidlist.cpp
	juickparser.cpp
	juickdownloader.cpp
)

set ( _UIS
	juickjidlist.ui
	settings.ui
)
QT4_WRAP_UI(UIS ${_UIS})

set ( _RSCS
	resources.qrc
)
QT4_ADD_RESOURCES(RSCS ${_RSCS})

add_library (
	${PROJECT_NAME}
	SHARED
	${_SRCS}
	${UIS}
	${RSCS}
	${TRS}
	${MOCS}
)
target_link_libraries (
	${PROJECT_NAME}
	${QT_QTCORE_LIBRARY}
	${QT_QTGUI_LIBRARY}
	${QT_QTXML_LIBRARY}
	${QT_QTNETWORK_LIBRARY}
	${QT_QTWEBKIT_LIBRARY}
)

set ( PLUGIN_INSTALL_PATH ${PLUGIN_INSTALL_PATH} PARENT_SCOPE)
install (
	TARGETS
	${PROJECT_NAME}
	LIBRARY
	DESTINATION
	${CMAKE_INSTALL_PREFIX}/${PLUGIN_INSTALL_PATH}
)
