if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release")
endif()

project(iris)
cmake_minimum_required(VERSION 2.8.11)

set( IRIS_LIB_VERSION_MAJOR 1 )
set( IRIS_LIB_VERSION_MINOR 0 )
set( IRIS_LIB_VERSION_PATCH 0 )
set( IRIS_LIB_VERSION_STRING
	${IRIS_LIB_VERSION_MAJOR}.${IRIS_LIB_VERSION_MINOR}.${IRIS_LIB_VERSION_PATCH}
)

set( CMAKE_MODULE_PATH
	"${CMAKE_MODULE_PATH}"
	"${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules"
	"${CMAKE_CURRENT_SOURCE_DIR}/../cmake/modules"
	"${PROJECT_SOURCE_DIR}/cmake/modules"
	"${PROJECT_SOURCE_DIR}/../cmake/modules"
)

option( BUILD_SHARED_LIBS "Build iris lib shared" OFF )
option( SEPARATE_QJDNS "Build qjdns with iris library" OFF )

include_directories(${PROJECT_SOURCE_DIR} ${PROJECT_BINARY_DIR})
include_directories(include/iris)

#set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})  # to find FindIdn.cmake file

set(CMAKE_AUTOMOC OFF)

# Enable C++11
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

if(APPLE)
  # Force Qt5 build on Mac OS X. Qt4 is not supported
  set(USE_QT5 ON)
endif()

if(USE_QT5)
  find_package(Qt5Core REQUIRED)
  find_package(Qt5Gui REQUIRED)
  find_package(Qt5Xml REQUIRED)
  find_package(Qt5Network REQUIRED)
  find_package( Qca-qt5 REQUIRED PATHS ${QCA_DIR} )
  get_target_property( QCA_INCLUDES qca-qt5 INTERFACE_INCLUDE_DIRECTORIES )

  macro(qt4_generate_moc)
    qt5_generate_moc(${ARGN})
  endmacro()

  add_definitions(-DHAVE_QT5)
else()
  find_package(Qt4 REQUIRED QtCore QtGui QtNetwork QtXml)
  find_package( Qca REQUIRED PATHS ${QCA_DIR} )
  get_target_property( QCA_INCLUDES qca INTERFACE_INCLUDE_DIRECTORIES )
  include(${QT_USE_FILE})
endif()

include_directories(
	${QCA_INCLUDES}
)

macro(qt_wrap_cpp)
  set(_SOURCES ${ARGN})
  list(REMOVE_AT _SOURCES 0)
  foreach(SOURCE ${_SOURCES})
    if(SOURCE MATCHES "^(.*/|)([^/.]+)\\.h$")
      set(DEST "moc_${CMAKE_MATCH_2}.cpp")
      qt4_generate_moc(${SOURCE} ${DEST})
      list(APPEND ${ARGV0} ${DEST})
    elseif(SOURCE MATCHES "^(.*/|)([^/.]+)\\.cpp$")
      set(DEST "${CMAKE_MATCH_2}.moc")
      qt4_generate_moc(${SOURCE} ${DEST})
      list(APPEND ${ARGV0} ${DEST})
    else()
      message(WARNING "Wrong source ${SOURCE}")
    endif()
  endforeach()
  unset(_SOURCES)
endmacro()

if(NOT SEPARATE_QJDNS)
	option( BUILD_QJDNS "Buid JDNS Qt-wrapper" ON )
	option( BUILD_JDNS_TOOL "Build jdns test tool" OFF )
	add_subdirectory(src/jdns)
	include_directories(
		src/jdns/include/jdns
	)
else()
	find_package(QJDns REQUIRED)
	include_directories( ${QJDns_INCLUDE_DIR} )
endif()

find_package(IDN REQUIRED)

add_definitions(-DIRISNET_STATIC)

add_subdirectory(src/irisnet)
add_subdirectory(src/xmpp)
