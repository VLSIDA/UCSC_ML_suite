export DESIGN_NAME = lfsr_top
export PLATFORM    = nangate45

export VERILOG_FILES = $(sort $(wildcard $(DESIGN_HOME)/src/$(DESIGN_NAME)/*.v))
export SDC_FILE      = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NAME)/constraint.sdc

export CORE_UTILIZATION ?= 55
export PLACE_DENSITY_LB_ADDON = 0.20
export TNS_END_PERCENT        = 100

export PDN_TCL = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NAME)/grid_strategy-M1-M4.tcl