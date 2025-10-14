export DESIGN_NAME	= minimax
export PLATFORM		= nangate45

-include $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/verilog.mk

export SDC_FILE			= $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NAME)/constraint.sdc

export PLACE_DENSITY	= 0.7

export CORE_UTILIZATION	= 60
export CORE_ASPECT_RATIO	= 1.0
export CORE_MARGIN		= 6