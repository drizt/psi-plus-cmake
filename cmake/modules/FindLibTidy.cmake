if ( NOT ${WIN32} )
	find_package( PkgConfig REQUIRED )
	pkg_check_modules( PC_LIBOTR QUIET libtidy )
	set ( LIBOTR_DEFINITIONS ${PC_LIBOTR_CFLAGS_OTHER} )
endif ( NOT ${WIN32} )
find_path(
	LIBTIDY_INCLUDE_DIR tidy.h
	HINTS
	${PC_LIBTIDY_INCLUDEDIR}
	${PC_LIBTIDY_INCLUDE_DIRS}
	PATH_SUFFIXES
	tidy
)
find_library(
	LIBTIDY_LIBRARY
	NAMES tidy libtidy
	HINTS 
	${PC_LIBTIDY_LIBDIR}
	${PC_LIBTIDY_LIBRARY_DIRS}
)
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
				LibTidy
				DEFAULT_MSG
				LIBTIDY_LIBRARY
				LIBTIDY_INCLUDE_DIR
)
if ( LIBTIDY_FOUND )
	set ( LIBTIDY_LIBRARIES ${LIBGPGERROR_LIBRARY} )
	set ( LIBTIDY_INCLUDE_DIRS ${LIBGPGERROR_INCLUDE_DIR} )
endif ( LIBTIDY_FOUND )

mark_as_advanced( LIBTIDY_INCLUDE_DIR LIBTIDY_LIBRARY )
