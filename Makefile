
DESIGN_CONFIG ?= ./designs/nangate45/lfsr_top/config.mk

-include OpenROAD-flow-scripts/flow/Makefile

.PHONY: do-setup
do-setup: 
	git submodule init $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/repo
	git submodule update $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/repo
	
# Add additional synth target dependency
yosys-dependencies: do-setup
