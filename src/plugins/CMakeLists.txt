cmake_minimum_required( VERSION 2.8.11 )
set( BUILD_PLUGINS "ALL" CACHE STRING "List of plugins to build" )
IF( NOT WIN32 )
	set( PLUGINS_PATH "lib${LIB_SUFFIX}/psi-plus/plugins" CACHE STRING "Install suffix for plugins" )
ELSE( NOT WIN32 )
	IF( "${CMAKE_BUILD_TYPE}" STREQUAL "Release" )
		add_definitions(
				-Os
				-funroll-loops
				-ffast-math
				-fomit-frame-pointer
		)
	ENDIF( "${CMAKE_BUILD_TYPE}" STREQUAL "Release" )
	set( PLUGINS_PATH "psi-plus/plugins" CACHE STRING "Install suffix for plugins" )
ENDIF( NOT WIN32 )

add_subdirectory( generic )
IF( UNIX AND NOT( APPLE OR CYGWIN ) )
	add_subdirectory( unix )
ENDIF( UNIX AND NOT( APPLE OR CYGWIN ) )

unset( BUILD_PLUGINS CACHE )
unset( PLUGINS_PATH CACHE )
