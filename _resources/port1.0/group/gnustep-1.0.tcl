# this contains common settings for GNUstep

categories          gnustep
homepage            http://www.gnustep.org/
master_sites        gnustep:core

# source the GNUstep make shell script.
pre-build {
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
configure.compiler      macports-clang
depends_build-append    port:clang-3.0

platform darwin 11 { # 10.7
    # use the system provided clang compiler.
    # note that the system llvm-gcc-4.2 won't work because -fconstant-string-class is broken on that compiler
    depends_build-delete    port:clang-3.0
    configure.compiler      clang
}

configure.env-append GNUSTEP_MAKEFILES=${prefix}/GNUstep/System/Library/Makefiles

# defaults to: --prefix=${prefix}
configure.pre_args  --prefix=${prefix}/GNUstep

# FIXME: not sure if this is needed
universal_variant   no

# we install into ${prefix}/GNUstep which is a violation of the macports filesystem standard
destroot.violate_mtree  yes
