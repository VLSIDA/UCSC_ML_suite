export DESIGN_NAME	= minimax
export PLATFORM		= asap7

export VERILOG_FILES	= $(sort $(wildcard $(DESIGN_HOME)/src/$(DESIGN_NAME)/*.v))
export SDC_FILE			= $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export PLACE_DENSITY	= 0.7
export PLACE_PINS_ARGS := -random

export CORE_UTILIZATION	= 65
export CORE_ASPECT_RATIO	= 1.0
export CORE_MARGIN		= 4