# et:ts=4
# gnustep.tcl
#
# $Id$
#
# Copyright (c) 2006 Yves de Champlain <yves@opendarwin.org>
# Copyright (c) 2011 Eric Wasylishen
# Copyright (c) 2014 Eric Gallager <egall@gwmail.gwu.edu> and The MacPorts Project
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of Apple Computer, Inc. nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# This PortGroup contains common settings for GNUstep.

#
# Overview of gnustep 1.1 PortGroup:
#

#
# default categories            gnustep
# default homepage              http://www.gnustep.org/
# default master_sites          gnustep:core
# default depends_lib           "" (nothing, this is a change from the old
#                                   gnustep 1.0 PortGroup)
#
# array set gnustep.post_flags  (this feature has been removed as of the update
#                                to the gnustep 1.1 PortGroup)
#
#
# proc set_gnustep_make         (this feature has been removed as of the update
#                                to the gnustep 1.1 PortGroup)
#
# proc set_gnustep_env          (this feature has been removed as of the update
#                                to the gnustep 1.1 PortGroup)
#
#
# default gnustep.cc            (setting this as a separate variable has been
#                                removed as of the update to the gnustep 1.1
#                                PortGroup; this PortGroup still changes
#                                the compilers somewhat similarly though)
#
# default use_configure         no
# default configure.env         GNUSTEP_MAKEFILES=${prefix}/GNUstep/System/Library/Makefiles
# default configure.pre_args    --prefix=${prefix}/GNUstep
#
# default build.env             "" (nothing, this is a change from the old
#                                   gnustep 1.0 PortGroup)
# default build.type            "" (nothing, this is a change from the old
#                                   gnustep 1.0 PortGroup)
# default build.args            messages=yes
#
# default destroot.env          "" (nothing, this is a change from the old
#                                   gnustep 1.0 PortGroup)
# default destroot.pre_args     "" (nothing, this is a change from the old
#                                   gnustep 1.0 PortGroup)
#
# variant with_docs             (this variant has been removed as of the update
#                                to the gnustep 1.1 PortGroup)
#

categories          gnustep
homepage            http://www.gnustep.org/
master_sites        gnustep:core

# Source the GNUstep make shell script:
pre-build {
    # The file will not exist when we are building gnustep-make itself
    # (since that is the package that installs it).
    # The gnustep-make Portfile still includes this PortGroup,
    # because all of the other settings in here are still relevant.
    set gsmakefile    "${prefix}/GNUstep/System/Library/Makefiles/GNUstep.sh"
    if {[file exists ${gsmakefile}]} {
      build.cmd     ". ${gsmakefile} && make"
    }
}
build.args      messages=yes

# Typically configure is not needed; just use GNUstep make:
use_configure       no

# but if we do use configure...

# for platform <= 10.6
# system provided clang 1.6 does NOT work:
depends_build-append    port:clang-3.0
# FIXME: We should set configure.compiler instead of the following,
# but macports does NOT support a configure.compiler setting of clang-3.0...
# (actually, we should really be using compiler.blacklist, compiler.whitelist,
# and compiler.fallback instead... see UsingTheRightCompiler on the MacPorts
# Trac Wiki)
configure.cc            ${prefix}/bin/clang-mp-3.0
configure.cpp           ${prefix}/bin/clang-mp-3.0
configure.cxx           ${prefix}/bin/clang++-mp-3.0
configure.objc          ${prefix}/bin/clang-mp-3.0

platform darwin 11 { # 10.7
    # use the system provided clang compiler.
    # note that the system llvm-gcc-4.2 will NOT work,
    # because -fconstant-string-class is broken on that compiler:
    depends_build-delete    port:clang-3.0
    configure.cc            clang
    configure.cpp           clang
    configure.cxx           clang++
    configure.objc          clang
}

# On a normal GNUstep installation, GNUstep.sh would be sourced before running
# configure. In our port, GNUstep.sh is only sourced when running 'make'
# (see pre-build rule), not configure. To compensate, we set
# the GNUSTEP_MAKEFILES variable which allows configure to work properly
configure.env-append GNUSTEP_MAKEFILES=${prefix}/GNUstep/System/Library/Makefiles

# defaults to: --prefix=${prefix}
configure.pre_args  --prefix=${prefix}/GNUstep

# FIXME: not sure if this is needed:
universal_variant   no

# we install into ${prefix}/GNUstep which is a violation of the MacPorts
# filesystem standard:
destroot.violate_mtree  yes
