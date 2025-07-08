export DESIGN_NAME	= minimax
export PLATFORM		= sky130hd

# This could be a wildcard
REPO_FILES = $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/repo/rtl/$(DESIGN_NAME).v
# This cannot be a wildcard, since it is used in the dependency
export VERILOG_FILES = $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/$(DESIGN_NAME).v

REPO_LICENSE = $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/repo/LICENSE
LICENSE_FILE = $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/LICENSE

$(VERILOG_FILES): do-setup $(REPO_FILES)
	echo "Copying $(REPO_LICENSE)  ->  $(LICENSE_FILE)"
	cp -u $(REPO_LICENSE) $(LICENSE_FILE)
	echo "Translating $(REPO_FILES)  ->  $@"
	sv2v -w $@ $(REPO_FILES)
	echo "Done."

export SDC_FILE			= $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NAME)/constraint.sdc

export PLACE_DENSITY	= 0.6
export PLACE_PINS_ARGS	= -random

export CORE_UTILIZATION	= 40
export CORE_ASPECT_RATIO	= 1.0
export CORE_MARGIN		= 12