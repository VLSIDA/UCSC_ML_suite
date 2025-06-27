export DESIGN_NAME = lfsr_top
export PLATFORM    = sky130hd

export VERILOG_FILES = $(sort $(wildcard $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/*.v))
export SDC_FILE      = $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NAME)/constraint.sdc

export CORE_UTILIZATION 	= 40
export TNS_END_PERCENT      = 100