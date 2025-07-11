DESIGN_CONFIG ?= ./designs/nangate45/lfsr_top/config.mk

DESIGN_DIRECTORY ?= $(DESIGN_NAME)

-include OpenROAD-flow-scripts/flow/Makefile

.PHONY: do-setup
do-setup: 
	git submodule init $(BENCH_DESIGN_HOME)/src/$(DESIGN_DIRECTORY)/repo
	bash -c '[ -f "$(BENCH_DESIGN_HOME)/src/$(DESIGN_DIRECTORY)/setup.sh" ] && source "$(BENCH_DESIGN_HOME)/src/$(DESIGN_DIRECTORY)/setup.sh"'

# Add additional synth target dependency
yosys-dependencies: do-setup
