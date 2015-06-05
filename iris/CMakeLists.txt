set( LIB_IRIS iris )
cmake_minimum_required( VERSION 2.8.11 )
set( CMAKE_AUTOMOC ON )
set(CMAKE_INCLUDE_CURRENT_DIR ON)
#Fixme
set( IRIS_LIB_VERSION_MAJOR 1 )
set( IRIS_LIB_VERSION_MINOR 0 )
set( IRIS_LIB_VERSION_PATCH 0 )
set( IRIS_LIB_VERSION_STRING
	${IRIS_LIB_VERSION_MAJOR}.${IRIS_LIB_VERSION_MINOR}.${IRIS_LIB_VERSION_PATCH}
)
#Set Path to cmake modules
set( CMAKE_MODULE_PATH
	${CMAKE_MODULE_PATH}
	${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules
	${CMAKE_CURRENT_SOURCE_DIR}/../cmake/modules
)
set( LIB_SUFFIX "" CACHE STRING "Define suffix of directory name (32/64)" )
set( LIB_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/lib${LIB_SUFFIX}" CACHE PATH "Directory where lib will install" )
set( BIN_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/bin" CACHE PATH "Directory where bin will install" )
set( QT_DIR "" CACHE STRING "Set Path to Qt libraries" )
set( QCA_DIR "" CACHE STRING "Set Path to QCA library" )
set( IDN_ROOT "" CACHE STRING "Set Path to libidn library" )
set( ZLIB_ROOT "" CACHE STRING "Set Path to zlib library" )
#Variables
set( BUILD_STATIC OFF CACHE BOOL "Build iris as static library" )
set( USE_QT5 OFF CACHE BOOL "Build iris with Qt5")
#

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
else( ${USE_QT5} )
	find_package( Qca REQUIRED PATHS ${QCA_DIR} )
	get_target_property( QCA_INCLUDES qca INTERFACE_INCLUDE_DIRECTORIES )
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
	src/jdns/include/jdns
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

if( ${BUILD_STATIC} )
	add_definitions( -DIRISNET_STATIC )
	add_definitions( -DJDNS_STATIC )
	add_library( ${LIB_IRIS} STATIC ${iris_SRCS} )
else( ${BUILD_STATIC} )
	add_library( ${LIB_IRIS} SHARED ${iris_SRCS} )
endif( ${BUILD_STATIC} )

set( iris_libs
	${QT_DEPLIBS}
	${IDN_LIBRARIES}
	qca
	${ZLIB_LIBRARIES}
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
)

target_link_libraries( ${LIB_IRIS} ${iris_libs} )

########### install files ###############
if( ${BUILD_STATIC} )
	install(
		TARGETS
		${LIB_IRIS}
		LIBRARY
		DESTINATION ${LIB_INSTALL_DIR}
		ARCHIVE DESTINATION ${LIB_INSTALL_DIR}/iris
	)
install( FILES ${libiris_INCLUDES} DESTINATION ${CMAKE_INSTALL_PREFIX}/include/iris )
else( ${BUILD_STATIC} )
	if( ${UNIX} )
		install(
			TARGETS
			${LIB_IRIS}
			LIBRARY
			DESTINATION ${LIB_INSTALL_DIR}
			ARCHIVE DESTINATION ${LIB_INSTALL_DIR}/iris
		)
	endif( ${UNIX} )
	if( ${WIN32} )
		install(
			TARGETS
			${LIB_IRIS}
			LIBRARY
			DESTINATION ${BIN_INSTALL_DIR}
			RUNTIME DESTINATION ${BIN_INSTALL_DIR}
			ARCHIVE DESTINATION ${LIB_INSTALL_DIR}/iris
		)
	endif( ${WIN32} )
endif( ${BUILD_STATIC} )

set( DOC_FILES
	${CMAKE_CURRENT_SOURCE_DIR}/README
	${CMAKE_CURRENT_SOURCE_DIR}/COPYING
	${CMAKE_CURRENT_SOURCE_DIR}/TODO
)

INSTALL( FILES ${DOC_FILES} DESTINATION ${CMAKE_INSTALL_PREFIX}/share/iris )
