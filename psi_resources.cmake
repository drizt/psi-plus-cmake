cmake_minimum_required( VERSION 2.8.11 )

set( psi_resources
	psi.qrc
	iconsets.qrc
)

set( psi_win_resources "" )

if (CMAKE_SIZEOF_VOID_P MATCHES 8)
        set( psi_win_resources
		psi_win64.rc
	)
else(CMAKE_SIZEOF_VOID_P MATCHES 8)
        set( psi_win_resources
		psi_win32.rc
	)
endif(CMAKE_SIZEOF_VOID_P MATCHES 8)
