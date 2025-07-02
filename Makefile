
-include OpenROAD-flow-scripts/flow/Makefile

.PHONY: do-setup
do-setup: 
	git submodule init $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/repo
	source $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/setup.sh


# Add additional synth target dependency
yosys-dependencies: do-setup
