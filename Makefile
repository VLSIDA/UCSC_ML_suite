
###            Comprehensive Design List (nangate45, sky130hd, asap7)            ###
# DESIGN_CONFIG=./designs/nangate45/lfsr_top/config.mk
# DESIGN_CONFIG=./designs/nangate45/liteeth/liteeth_mac_axi_mii/config.mk
# DESIGN_CONFIG=./designs/nangate45/liteeth/liteeth_mac_wb_mii/config.mk
# DESIGN_CONFIG=./designs/nangate45/minimax/config.mk
# DESIGN_CONFIG=./designs/nangate45/nyuzi/config.mk
# 
# DESIGN_CONFIG=./designs/sky130hd/lfsr_top/config.mk
# DESIGN_CONFIG=./designs/sky130hd/liteeth/liteeth_mac_axi_mii/config.mk
# DESIGN_CONFIG=./designs/sky130hd/liteeth/liteeth_mac_wb_mii/config.mk
# DESIGN_CONFIG=./designs/sky130hd/minimax/config.mk
#
# DESIGN_CONFIG=./designs/asap7/minimax/config.mk
# DESIGN_CONFIG=./designs/asap7/lfsr_top/config.mk

DESIGN_CONFIG ?= ./designs/nangate45/lfsr_top/config.mk
-include OpenROAD-flow-scripts/flow/Makefile

# Check if calling "dev" with an ORFS command or by itself.
DEV_RUN_TAG?=x
.PHONY: dev do-dev-setup 
ifeq ($(firstword $(MAKECMDGOALS)),dev)
DEV_RUN_TAG:=$(DESIGN_NAME)-$(shell date +%s%N)
ifneq ($(lastword $(MAKECMDGOALS)),dev)
dev: ;@:
export DESIGN_NICKNAME=$(DESIGN_NAME).dev
else
$(info Starting dev run)
dev: .dev-suite-run$(DEV_RUN_TAG)
endif
endif
export DEV_RUN_TAG

# .dev-suite-run flag is necessary because ORFS makefile unsets all vars for recursion
.DELETE_ON_ERROR:
.dev-suite-run%:
    # Change Design Nickname to avoid conflict between default and dev designs  
	$(eval export DESIGN_NICKNAME = $(DESIGN_NAME).dev)
	: > $@
	$(MAKE) do-dev-setup 
	$(MAKE) finish
	rm -f $@
	
do-dev-setup:
	git submodule init $(BENCH_DESIGN_HOME)/src/$(DEV_DESIGN_HOME)/repo
	git submodule update $(BENCH_DESIGN_HOME)/src/$(DEV_DESIGN_HOME)/repo
    # Check if a setup.sh script exists for the current design
	@if [ -f "$(BENCH_DESIGN_HOME)/src/$(DEV_DESIGN_HOME)/setup.sh" ]; then \
		bash $(BENCH_DESIGN_HOME)/src/$(DEV_DESIGN_HOME)/setup.sh; \
	fi
  
.PHONY: clean_design
# DESIGN_SRC can be used to clean up any design-dependent source files
clean_design:
	rm -rf $(DESIGN_SRC)

clean_all: clean_design

