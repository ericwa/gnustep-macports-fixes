categories          gnustep
depends_lib         port:gnustep-core

# source the GNUstep make shell script.
pre-build {
  . ${prefix}/share/GNUstep/Makefiles/GNUstep.sh
}

use_configure       no

# FIXME: not sure if this is needed
universal_variant   no
