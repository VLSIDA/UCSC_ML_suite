DESIGN_CONFIG ?= ./designs/nangate45/lfsr_top/config.mk

-include OpenROAD-flow-scripts/flow/Makefile

.PHONY: do-setup

do-setup: 
	git submodule init $(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)/repo
	git submodule update $(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)/repo
    # Check if a setup.sh script exists for the current design
	@if [ -f "$(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)/setup.sh" ]; then \
		bash $(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)/setup.sh; \
	fi

.PHONY: fresh

fresh: do-setup finish

ifeq ($(wildcard $(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)/repo/),)
.DEFAULT_GOAL := fresh
endif

.PHONY: clean_design
# DESIGN_SRC can be used to clean up any design-dependent source files
clean_design:
	rm -rf $(DESIGN_SRC)

clean_all: clean_design