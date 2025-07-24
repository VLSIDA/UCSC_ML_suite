export DESIGN_NAME = lfsr_top
export PLATFORM    = asap7

VERILOG_FILES = \
  $(wildcard $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/*.v) \
  $(wildcard $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/repo/rtl/*.v)

export VERILOG_FILES := $(sort $(VERILOG_FILES))
export SDC_FILE      = $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NAME)/constraint.sdc

export CORE_UTILIZATION 	= 40
export TNS_END_PERCENT      = 100
