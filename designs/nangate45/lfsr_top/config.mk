export DESIGN_NAME = lfsr_top
export PLATFORM    = nangate45

VERILOG_FILES = \
  $(wildcard $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/*.v) \
  $(wildcard $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/repo/rtl/*.v)

export VERILOG_FILES := $(sort $(VERILOG_FILES))
export SDC_FILE      = $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NAME)/constraint.sdc
export ABC_AREA      = 1

export CORE_UTILIZATION = 20
export PLACE_DENSITY_LB_ADDON = 0.20
export TNS_END_PERCENT        = 100
