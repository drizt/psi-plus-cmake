if( LIBGPGERROR_INCLUDE_DIR AND LIBGPGERROR_LIBRARY )
	# in cache already
	set(LIBGPGERROR_FIND_QUIETLY TRUE)
endif( LIBGPGERROR_INCLUDE_DIR AND LIBGPGERROR_LIBRARY )

if( UNIX AND NOT( APPLE OR CYGWIN ) )
	find_package( PkgConfig QUIET )
	pkg_check_modules( PC_LIBGPGERROR QUIET libgpg-error )
	if( PC_LIBGPGERROR_FOUND )
		set( LIBGPGERROR_DEFINITIONS ${PC_LIBGPGERROR_CFLAGS} )
	endif( PC_LIBGPGERROR_FOUND )
endif( UNIX AND NOT( APPLE OR CYGWIN ) )

if( WIN32 )
	FIND_PROGRAM(LIBGPGERRORCONFIG_EXECUTABLE NAMES libgpg-error-config PATHS ${LIBGPGERROR_ROOT}/bin)
	IF(LIBGPGERRORCONFIG_EXECUTABLE)
		execute_process(COMMAND sh "${LIBGPGERRORCONFIG_EXECUTABLE}" --prefix OUTPUT_VARIABLE PREFIX)
		set(LIBGPGERROR_LIB_HINT "${PREFIX}/lib")
		set(LIBGPGERROR_INCLUDE_HINT "${PREFIX}/include")
	ENDIF(LIBGPGERRORCONFIG_EXECUTABLE)
endif( WIN32 )

set( LIBGPGERROR_ROOT "" CACHE STRING "Path to libgpg-error library" )

find_path(
	LIBGPGERROR_INCLUDE_DIR gpg-error.h
	HINTS
	${LIBGPGERROR_ROOT}/include
	${PC_LIBGPGERROR_INCLUDEDIR}
	${PC_LIBGPGERROR_INCLUDE_DIRS}
	${LIBGPGERROR_INCLUDE_HINT}
)

find_library(
	LIBGPGERROR_LIBRARY
	NAMES gpg-error libgpg-error gpg-error-0 libgpg-error-0
	HINTS 
	${PC_LIBGPGERROR_LIBDIR}
	${PC_LIBGPGERROR_LIBRARY_DIRS}
	${LIBGPGERROR_LIB_HINT}
	${LIBGPGERROR_ROOT}/lib
	${LIBGPGERROR_ROOT}/bin
)
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
				LibGpgError
				DEFAULT_MSG
				LIBGPGERROR_LIBRARY
				LIBGPGERROR_INCLUDE_DIR
)
if( LIBGPGERROR_FOUND )
	set( LIBGPGERROR_LIBRARIES ${LIBGPGERROR_LIBRARY} )
	set( LIBGPGERROR_INCLUDE_DIRS ${LIBGPGERROR_INCLUDE_DIR} )
endif( LIBGPGERROR_FOUND )
mark_as_advanced( LIBGPGERROR_INCLUDE_DIR LIBGPGERROR_LIBRARY )
