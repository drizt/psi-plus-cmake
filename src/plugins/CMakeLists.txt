cmake_minimum_required( VERSION 2.8.6 ) 

if ( UNIX AND NOT( APPLE OR CYGWIN ) )
	set ( PLUGIN_INSTALL_PATH ${PLUGIN_INSTALL_PATH} PARENT_SCOPE )
	add_subdirectory ( generic )
	add_subdirectory ( unix )
endif ( UNIX AND NOT( APPLE OR CYGWIN ) )