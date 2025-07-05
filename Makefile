
DESIGN_CONFIG ?= ./designs/nangate45/lfsr_top/config.mk

-include OpenROAD-flow-scripts/flow/Makefile

DESIGN_DIRECTORY ?= $(DESIGN_NAME) 

.PHONY: do-setup
do-setup: 
	git submodule init $(BENCH_DESIGN_HOME)/src/$(DESIGN_DIRECTORY)/repo
	bash -c '[ -f "$(BENCH_DESIGN_HOME)/src/$(DESIGN_DIRECTORY)/setup.sh" ] && source "$(BENCH_DESIGN_HOME)/src/$(DESIGN_DIRECTORY)/setup.sh"'

.DEFAULT_GOAL := run-with-setup

run-with-setup:
	$(MAKE) DESIGN_CONFIG=$(DESIGN_CONFIG) do-setup
	$(MAKE) DESIGN_CONFIG=$(DESIGN_CONFIG) all

# Add additional synth target dependency
yosys-dependencies: do-setup
