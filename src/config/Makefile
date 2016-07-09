#===========================================================================
#
# Build makefile. Builds program or library and supports installation.
#
# License  : GPL (General Public License)
# Author   : Arend Lammertink <lamare AT gmail DOT com>
# Date     : 2016/05/18 (version 0.1)
#
#===========================================================================

#---------------------------------------------------------------------------
# Main variables. At least one of the upper two MUST be set: 
#---------------------------------------------------------------------------
BINARIES  = mk_dts.bas libpruio.dts

# PRU assembler programs are output as a ".bin" file

#LIBNAME  = mylib            # default: None set.
#LIBTYPE  = static           # default: dylib for dynamically linked .so

#---------------------------------------------------------------------------
# Override some default directories
#---------------------------------------------------------------------------
#SRCDIRS  = .                # default: .
INCDIRS  = . ../include      # default: ../include
BINDIR   = $(strip ../../bin)         # default: ../bin
LIBDIR   = ../../lib         # default: ../lib
#TESTDIR  =                  # default: ../test
#DOCDIR   =                  # default: ../doc

#---------------------------------------------------------------------------
# Since mk_dts is a dedicated tool to create a device tree overlay, we
# have to define specific targets as well as clean ups. Targets are
# defined after including LaMake.
#---------------------------------------------------------------------------

# Since ./libpruio.dts is generated, it is not always present, so we
# need to explicitly set these to make sure the overlay compiler is
# called and clean up is done:
MY_CLEAN   += ./libpruio.dts
MY_TARGETS += ./libpruio.dts
ALLSRC.dt  := ./libpruio.dts
BINSRC.dt  := ./libpruio.dts

MK_DTS     := $(strip $(BINDIR))/mk_dts

#---------------------------------------------------------------------------
# Include the dirty details aka implementation.
#---------------------------------------------------------------------------
include LaMake/build.mk       # LaMake should be installed in or linked from
                              # /usr[/local]/include 
#===========================================================================

#---------------------------------------------------------------------------
# Any special targets should be defied after including LaMake
#---------------------------------------------------------------------------
./libpruio.dts: $(MK_DTS) 
	@echo "Making ./libpruio.dts"
	@$(MK_DTS)

