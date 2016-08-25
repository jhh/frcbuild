# Sample makefile for Stryke Force robot system

#
# Makefile functions
#

# $(call source-to-object, source-file-list)
source-to-object = $(subst .cc,.o,$(filter %.cc,$1))

# $(subdirectory)
subdirectory = $(patsubst %/module.mk,%,			\
		 $(word						\
		   $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))

# $(call make-library, library-name, source-file-list)
define make-library
  libraries += $1
  sources   += $2

  $1: $(call source-to-object,$2)
	$(AR) $(ARFLAGS) $$@ $$^
endef

#
# Module variables
#

# Collect information from each module in these four variables.
# Initialize them here as simple variables, libs go first.
modules      := lib/hello test/hello
programs     :=
libraries    :=
sources	     :=

objects      = 	$(call source-to-object,$(sources))
dependencies = 	$(subst .o,.d,$(objects))

include_dirs := lib include
CPPFLAGS     += $(addprefix -I ,$(include_dirs))
LDFLAGS      += -lc++
vpath %.h $(include_dirs)

MV  := mv -f
RM  := rm -f
SED := sed
#CXX = clang

all:

include $(addsuffix /module.mk,$(modules))

.PHONY: all
all: $(programs)

.PHONY: libraries
libraries: $(libraries)

.PHONY: clean
clean:
	$(RM) $(objects) $(programs) $(libraries) $(dependencies)

ifneq "$(MAKECMDGOALS)" "clean"
  -include $(dependencies)
endif

%.d: %.cc
	$(CXX) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -MM $< | \
	$(SED) 's,\($(notdir $*)\.o\) *:,$(dir $@)\1 $@: ,' > $@.tmp
	$(MV) $@.tmp $@
