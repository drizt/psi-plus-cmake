cmake_minimum_required( VERSION 2.8.6 ) 

add_subdirectory ( generic )
if ( UNIX AND NOT( APPLE OR CYGWIN ) )
	add_subdirectory ( unix )
endif ( UNIX AND NOT( APPLE OR CYGWIN ) )