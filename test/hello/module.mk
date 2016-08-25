local_pgm  := $(subdirectory)/hello
local_src  := $(addprefix $(subdirectory)/,$(wildcard *.cc))
local_objs := $(subst .cc,.o,$(local_src))

programs   += $(local_pgm)
sources    += $(local_src)

$(local_pgm): $(local_objs) $(libraries)
