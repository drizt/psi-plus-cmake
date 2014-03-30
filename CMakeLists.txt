cmake_minimum_required( VERSION 2.8.6 ) 

if ( UNIX AND NOT( APPLE OR CYGWIN ) )
	set ( PLUGIN_INSTALL_PATH ${PLUGIN_INSTALL_PATH} )
	add_subdirectory ( src )
endif ( UNIX AND NOT( APPLE OR CYGWIN ) )