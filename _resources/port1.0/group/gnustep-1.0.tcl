# et:ts=4
# gnustep.tcl
#
# $Id$
#
# Copyright (c) 2006 Yves de Champlain <yves@opendarwin.org>,
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

#
# Group code for GNUstep ports.
#

#
# Overview of gnustep 1.0 PortGroup :
#

#
# default categories            gnustep
# default homepage              http://www.gnustep.org/
# default master_sites          gnustep:core
# default depends_lib           port:gnustep-core
#
# array set gnustep.post_flags  Apple CC two-level namespaces requires all 
#                               symbols to be resolved at link time, 
#                               so most of the patches are just that.
#                               Setting the gnustep.post_flags array makes this
#                               simple beyond common understanding !
#                               ex: 
#                               platform darwin {
#                                   array set gnustep.post_flags {
#                                       BundleSubDir  "-lfoo -lbar"
#                                   }
#                               }
#
#
# proc set_gnustep_make         Sets GNUSTEP_MAKEFILES 
#                               according to the FilesystemLayout 
#
# proc set_gnustep_env          Sets DYLD_LIBRARY_PATH and PATH 
#                               for the gnustep FilesystemLayout
#
#
# default use_configure         no
# default configure.env         Sets the environment for the gnustep FilesystemLayout
# configure.pre_args-append     "[set_gnustep_make]"
#
# default build.env             {[set_gnustep_env]}
# default build.type            gnu
# build.pre_args-append         "messages=yes [set_gnustep_make]"
#
# default destroot.env          {[set_gnustep_env]}
# destroot.pre_args-append      "messages=yes [set_gnustep_make] [set_gnustep_domain]"
#
# variant with_docs             Most GNUstep programs providing documentation
#                               follow the same pattern
#

#
# GNUstep utilities
#

#
# Adds SHARED_LD_POSTFLAGS for Darwin's linker 
#
# Sets GNUSTEP_INSTALLATION_DOMAIN for ports using the 
# deprecated GNUSTEP_SYSTEM_ROOT variable
#


#
# Options this group provides :
#

#
# Default values for this group :
#

default categories          gnustep
default homepage            http://www.gnustep.org/

