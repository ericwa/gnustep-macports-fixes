categories          gnustep
homepage            http://www.gnustep.org/
depends_lib         port:gnustep-core

# source the GNUstep make shell script.
pre-build {
  . ${prefix}/share/GNUstep/Makefiles/GNUstep.sh
}

use_configure       no

# FIXME: not sure if this is needed
universal_variant   no

# for ports which do use configure (base, back, gui, make)
configure.compiler  macports-gcc-4.6
depends_build       port:gcc46
