categories          gnustep
depends_lib         port:gnustep-core

# source the GNUstep make shell script.
build.cmd       . ${prefix}/GNUstep/System/Library/Makefiles/GNUstep.sh && make

use_configure       no

# FIXME: not sure if this is needed
universal_variant   no
