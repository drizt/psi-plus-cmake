set_directory_properties(PROPERTIES
  INCLUDE_DIRECTORIES ""
  COMPILE_DEFINITIONS ""
)

if(USE_QT5)
  add_definitions(-DHAVE_QT5)
endif()

# Use the same path for shared and static plugins
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/plugins")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/plugins")

set(BUILD_PLUGINS "ALL" CACHE STRING "List of plugins to build")

if(NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  add_definitions(-DQT_NO_DEBUG -pthread)
endif(NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Debug")

if(NOT WIN32)
  set(LIB_SUFFIX "" CACHE STRING "Define suffix of directory name (32/64)")
  set(PLUGINS_PATH "lib${LIB_SUFFIX}/psi-plus/plugins" CACHE STRING "Install suffix for plugins")
else()
  set(PLUGINS_PATH "psi-plus/plugins" CACHE STRING "Install suffix for plugins")
endif()

add_subdirectory(generic)
if(LINUX)
  add_subdirectory(unix)
endif()

unset(BUILD_PLUGINS CACHE)
unset(PLUGINS_PATH CACHE)
