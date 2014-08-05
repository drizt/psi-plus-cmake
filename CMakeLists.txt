project( psi-plus )
cmake_minimum_required( VERSION 2.8.11 )

set( CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules" )
set( USE_QT5 OFF CACHE BOOL "Use Qt5" )

IF( WIN32 )
	macro(remove_compiler_flag flag)
		string(REPLACE "${flag}" "" CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}")
		string(REPLACE "${flag}" "" CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}")
	endmacro()
	remove_compiler_flag("-O3")
ENDIF( WIN32 )
add_subdirectory( src )
