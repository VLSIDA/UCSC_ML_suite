DESIGN_CONFIG ?= ./designs/nangate45/lfsr_top/config.mk

-include OpenROAD-flow-scripts/flow/Makefile

.PHONY: do-setup
do-setup: 
	git submodule init $(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)/repo
	git submodule update $(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)/repo

.PHONY: fresh

fresh: do-setup finish

ifeq ($(wildcard $(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)/repo),)
.DEFAULT_GOAL := fresh
endif

yosys-dependencies: do-setup