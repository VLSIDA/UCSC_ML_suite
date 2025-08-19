export DESIGN_NAME	= minimax
export PLATFORM		= sky130hd

# This could be a wildcard
-include $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/verilog.mk

export SDC_FILE			= $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NAME)/constraint.sdc

export PLACE_DENSITY	= 0.6
export PLACE_PINS_ARGS	= -random

export CORE_UTILIZATION	= 40
export CORE_ASPECT_RATIO	= 1.0
export CORE_MARGIN		= 12