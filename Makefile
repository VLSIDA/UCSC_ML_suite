DESIGN_CONFIG ?= ./designs/nangate45/lfsr_top/config.mk

DESIGN_DIRECTORY ?= $(DESIGN_NICKNAME)

-include OpenROAD-flow-scripts/flow/Makefile

.PHONY: do-setup
do-setup: 
	git submodule init $(BENCH_DESIGN_HOME)/src/$(DESIGN_DIRECTORY)/repo
	git submodule update $(BENCH_DESIGN_HOME)/src/$(DESIGN_DIRECTORY)/repo
	[ -f "$(BENCH_DESIGN_HOME)/src/$(DESIGN_DIRECTORY)/setup.sh" ] && \
	source "$(BENCH_DESIGN_HOME)/src/$(DESIGN_DIRECTORY)/setup.sh"

.PHONY: fresh

fresh: do-setup finish

ifeq ($(wildcard $(BENCH_DESIGN_HOME)/src/$(DESIGN_DIRECTORY)/repo),)
.DEFAULT_GOAL := fresh
endif

yosys-dependencies: do-setup