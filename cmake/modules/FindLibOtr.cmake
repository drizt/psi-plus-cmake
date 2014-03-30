if ( NOT ${WIN32} )
	find_package( PkgConfig REQUIRED )
	pkg_check_modules( PC_LIBOTR QUIET libotr )
	set ( LIBOTR_DEFINITIONS ${PC_LIBOTR_CFLAGS_OTHER} )
endif ( NOT ${WIN32} )
find_path(
	LIBOTR_INCLUDE_DIR libotr/privkey.h
	HINTS
	${PC_LIBOTR_INCLUDEDIR}
	${PC_LIBOTR_INCLUDE_DIRS}
	PATH_SUFFIXES
	libotr
)
find_library(
	LIBOTR_LIBRARY
	NAMES otr libotr
	HINTS 
	${PC_LIBOTR_LIBDIR}
	${PC_LIBOTR_LIBRARY_DIRS}
)
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
				LibOtr
				DEFAULT_MSG
				LIBOTR_LIBRARY
				LIBOTR_INCLUDE_DIR
)
if ( LIBOTR_FOUND )
	set ( LIBOTR_LIBRARIES ${LIBGPGERROR_LIBRARY} )
	set ( LIBOTR_INCLUDE_DIRS ${LIBGPGERROR_INCLUDE_DIR} )
endif ( LIBOTR_FOUND )

mark_as_advanced( LIBOTR_INCLUDE_DIR LIBOTR_LIBRARY )
