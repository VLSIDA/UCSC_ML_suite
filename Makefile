###            Comprehensive Design List (nangate45, sky130hd, asap7)            ###
# 
# DESIGN_CONFIG=./designs/nangate45/lfsr_top/config.mk
# DESIGN_CONFIG=./designs/nangate45/liteeth/liteeth_mac_axi_mii/config.mk
# DESIGN_CONFIG=./designs/nangate45/liteeth/liteeth_mac_wb_mii/config.mk
# DESIGN_CONFIG=./designs/nangate45/minimax/config.mk
# DESIGN_CONFIG=./designs/nangate45/NyuziProcessor/config.mk
# 
# DESIGN_CONFIG=./designs/sky130hd/lfsr_top/config.mk
# DESIGN_CONFIG=./designs/sky130hd/liteeth/liteeth_mac_axi_mii/config.mk
# DESIGN_CONFIG=./designs/sky130hd/liteeth/liteeth_mac_wb_mii/config.mk
# DESIGN_CONFIG=./designs/sky130hd/minimax/config.mk
# DESIGN_CONFIG=./designs/sky130hd/NyuziProcessor/config.mk
# 
# DESIGN_CONFIG=./designs/asap7/minimax/config.mk
# DESIGN_CONFIG=./designs/asap7/lfsr_top/config.mk
# DESIGN_CONFIG=./designs/asap7/liteeth/liteeth_mac_axi_mii/config.mk

DESIGN_CONFIG ?= ./designs/nangate45/lfsr_prbs_gen/config.mk
-include OpenROAD-flow-scripts/flow/Makefile
# Designs with RAM macros use FakeRAM (LEF generated for pins, no internal logic)
# Check if calling "dev" with an ORFS command or by itself.
DEV_RUN_TAG?=x
.PHONY: dev
ifeq ($(firstword $(MAKECMDGOALS)),dev)
DEV_RUN_TAG:=$(shell date +%s%N)$(shell bash -c "echo $$RANDOM")
export DESIGN_NICKNAME:= $(DESIGN_NAME).dev
ifneq ($(lastword $(MAKECMDGOALS)),dev)
dev: ;@:
else
$(info Starting dev run)
dev: .dev-run-$(DESIGN_NAME)-$(DEV_RUN_TAG)
endif
endif
export DEV_RUN_TAG

.PHONY: do-dev-setup
do-dev-setup:
	git submodule init $(BENCH_DESIGN_HOME)/src/$(DEV_DESIGN_HOME)/repo
	git submodule update $(BENCH_DESIGN_HOME)/src/$(DEV_DESIGN_HOME)/repo
    # Check if a setup.sh script exists for the current design
	@if [ -f "$(BENCH_DESIGN_HOME)/src/$(DEV_DESIGN_HOME)/setup.sh" ]; then \
		bash $(BENCH_DESIGN_HOME)/src/$(DEV_DESIGN_HOME)/setup.sh; \
	fi

# .dev-suite-run flag is necessary because ORFS makefile unsets all vars for recursion
.DELETE_ON_ERROR:
.dev-run%:
    # Change Design Nickname to avoid conflict between default and dev designs  
	: > $@
	$(MAKE) do-dev-setup 
<<<<<<< Updated upstream
	@if [ ! -f "$(RESULTS_DIR)/1_synth.v" ]; then \
=======
    # Check where the design was at (if continuing a run), otherwise run entire flow to finish
	@if [ ! -f "$(RESULTS_DIR)/1_synth.rtlil" ]; then \
>>>>>>> Stashed changes
		$(MAKE) finish; \
	elif [ ! -f "$(RESULTS_DIR)/2_floorplan.odb" ]; then \
		$(MAKE) do-floorplan do-place do-cts do-route do-finish; \
	elif [ ! -f "$(RESULTS_DIR)/3_place.odb" ]; then \
		$(MAKE) do-place do-cts do-route do-finish; \
	elif [ ! -f "$(RESULTS_DIR)/4_cts.odb" ]; then \
		$(MAKE) do-cts do-route do-finish; \
	elif [ ! -f "$(RESULTS_DIR)/5_route.odb" ]; then \
		$(MAKE) do-route do-finish; \
	else \
		$(MAKE) do-finish; \
	fi
	rm -f $@
	
.PHONY: clean_design
# DESIGN_SRC can be used to clean up any design-dependent source files
clean_design:
	rm -rf $(DESIGN_SRC)

clean_all: clean_design

