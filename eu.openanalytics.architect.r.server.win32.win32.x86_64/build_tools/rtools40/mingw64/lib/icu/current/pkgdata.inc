GENCCODE_ASSEMBLY_TYPE=-a gcc-mingw64
SO=dll
SOBJ=dll
A=a
LIBPREFIX=lib
LIB_EXT_ORDER=58.dll
COMPILE=x86_64-w64-mingw32-gcc   -DHAVE_DLOPEN=0 -DU_HAVE_ATOMIC=1 -DU_HAVE_MMAP=0 -DU_HAVE_STRTOD_L=0  -DU_STATIC_IMPLEMENTATION -DU_ATTRIBUTE_DEPRECATED= -O2 -std=c99 -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings -mthreads  -c
LIBFLAGS=-I/mingw64/include -DPIC 
GENLIB=x86_64-w64-mingw32-gcc -O2 -std=c99 -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings -mthreads   -shared -Wl,-Bsymbolic -Wl,--enable-auto-import -Wl,--out-implib=./all.dll.a
LDICUDTFLAGS=
LD_SONAME=
RPATH_FLAGS=
BIR_LDFLAGS=
AR=ar
ARFLAGS=r
RANLIB=ranlib
INSTALL_CMD=/usr/bin/install -c
