# this contains common settings for GNUstep

categories          gnustep
homepage            http://www.gnustep.org/
master_sites        gnustep:core

# source the GNUstep make shell script.
pre-build {
    # the file will not exist when we are building gnustep-make (since that is the package that
    # installs it.) gnustep-make still includes this portgroup because all of the other settings
    # in here are relevant.
    set gsmakefile    "${prefix}/GNUstep/System/Library/Makefiles/GNUstep.sh"
    if { [file exists ${gsmakefile}] } {
      build.cmd     . ${gsmakefile} && make
    }
}
build.args      messages=yes

# typically configure is not needed; just use GNUstep make
use_configure       no

# but if we do use configure...

# for platform <= 10.6
# system provided clang 1.6 doesn't work
depends_build-append    port:clang-3.0
# FIXME: We should set configure.compiler instead of the following, but macports doesn't support
# a configure.compiler setting of clang-3.0
configure.cc            ${prefix}/bin/clang-mp-3.0
configure.cpp           ${prefix}/bin/clang-mp-3.0
configure.cxx           ${prefix}/bin/clang++-mp-3.0
configure.objc          ${prefix}/bin/clang-mp-3.0

platform darwin 11 { # 10.7
    # use the system provided clang compiler.
    # note that the system llvm-gcc-4.2 won't work because -fconstant-string-class is broken on that compiler
    depends_build-delete    port:clang-3.0
    configure.compiler      clang
}

# On a normal GNUstep installation, GNUstep.sh would be sourced before running
# configure. In our port, GNUstep.sh is only sourced when running 'make'
# (see pre-build rule), not configure. To compensate, we set 
# the GNUSTEP_MAKEFILES variable which allows configure to work properly
configure.env-append GNUSTEP_MAKEFILES=${prefix}/GNUstep/System/Library/Makefiles

# defaults to: --prefix=${prefix}
configure.pre_args  --prefix=${prefix}/GNUstep

# FIXME: not sure if this is needed
universal_variant   no

# we install into ${prefix}/GNUstep which is a violation of the macports filesystem standard
destroot.violate_mtree  yes
