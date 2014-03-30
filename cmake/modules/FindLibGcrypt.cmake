if (LIBGCRYP_INCLUDE_DIR AND LIBGCRYP_LIBRARY)
   # in cache already
   set(libgcrypt_FIND_QUIETLY TRUE)
endif ()
if ( NOT ${WIN32} )
	find_package( PkgConfig QUIET )
	pkg_check_modules( PC_LIBGCRYPT QUIET libgcrypt )
	set ( LIBGCRYPT_DEFINITIONS ${PC_LIBGCRYPT_CFLAGS_OTHER} )
endif ( NOT ${WIN32} )
find_path(
	LIBGCRYPT_INCLUDE_DIR gcrypt.h
	HINTS
	${PC_LIBGCRYPT_INCLUDEDIR}
	${PC_LIBGCRYPT_INCLUDE_DIRS}
	PATH_SUFFIXES
)
find_library(
	LIBGCRYPT_LIBRARY
	NAMES gcrypt libgcrypt
	HINTS 
	${PC_LIBGCRYPT_LIBDIR}
	${PC_LIBGCRYPT_LIBRARY_DIRS}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
				LibGcrypt
				DEFAULT_MSG
				LIBGCRYPT_LIBRARY
				LIBGCRYPT_INCLUDE_DIR
)
if ( LIBGCRYPT_FOUND )
	set ( LIBGCRYPT_LIBRARIES ${LIBGCRYPT_LIBRARY} )
	set ( LIBGCRYPT_INCLUDE_DIRS ${LIBGCRYPT_INCLUDE_DIR} )
endif ( LIBGCRYPT_FOUND )
mark_as_advanced ( LIBGCRYPT_INCLUDE_DIR LIBGCRYPT_LIBRARY )
