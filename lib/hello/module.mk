local_src := $(wildcard $(subdirectory)/*.cc)

$(eval $(call make-library, $(subdirectory)/libtest.a, $(local_src)))
