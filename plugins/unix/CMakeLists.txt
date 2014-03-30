cmake_minimum_required( VERSION 2.8.6 ) 

if ( UNIX AND NOT( APPLE OR CYGWIN ) )
	set ( PLUGIN_INSTALL_PATH ${PLUGIN_INSTALL_PATH} PARENT_SCOPE)
	set ( plugins 
		gnome3supportplugin
	)

	FOREACH (plugin ${plugins})
		MESSAGE("Parse subdirectory: ./${plugin}")
		ADD_SUBDIRECTORY("./${plugin}")
	ENDFOREACH(plugin)
endif ( UNIX AND NOT( APPLE OR CYGWIN ) )