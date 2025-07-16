export DESIGN_NAME = liteeth_mac_wb_mii
export DESIGN_DIRECTORY = liteeth
export PLATFORM    = sky130hd

export LITEETH_DIR = $(BENCH_DESIGN_HOME)/src/liteeth

REPO_LICENSE = $(BENCH_DESIGN_HOME)/src/$(DESIGN_DIRECTORY)/repo/LICENSE
LICENSE_FILE = $(BENCH_DESIGN_HOME)/src/$(DESIGN_DIRECTORY)/LICENSE
YML_FILE = $(BENCH_DESIGN_HOME)/src/liteeth/repo/examples/wishbone_mii.yml
GENERATED_FILE = $(BENCH_DESIGN_HOME)/src/liteeth/liteeth_mac_wb_mii.v

$(GENERATED_FILE): do-setup $(YML_FILE)
	echo "Copying $(REPO_LICENSE)  ->  $(LICENSE_FILE)"
	cp -u $(REPO_LICENSE) $(LICENSE_FILE)
	echo "Activating python environment and generating Verilog files..."
	cd $(LITEETH_DIR) && \
	source .venv/bin/activate && \
	cd scripts && \
	[ ! -f "../liteeth_mac_wb_mii.v" ] && bash setup_mac_wb.sh; \
	echo "Finished verilog file setup."
	echo "Done."

export VERILOG_FILES = $(DESIGN_HOME)/src/liteeth/liteeth_mac_wb_mii.v \
                       $(DESIGN_HOME)/src/liteeth/xilinx2asic/FDPE.v \
                       $(DESIGN_HOME)/src/liteeth/macros/sky130hd/liteeth_32x384_32_sram.v \
                       $(DESIGN_HOME)/src/liteeth/macros/sky130hd/liteeth_32x384_8_sram.v

export SDC_FILE      = $(DESIGN_HOME)/$(PLATFORM)/liteeth/liteeth_mac_wb_mii/constraint.sdc
export MACRO_PLACEMENT_TCL = $(DESIGN_HOME)/$(PLATFORM)/liteeth/liteeth_mac_wb_mii/macro_placement.tcl

export ADDITIONAL_LEFS = \
  $(DESIGN_HOME)/src/liteeth/macros/sky130hd/liteeth_32x384_32_sram.lef \
  $(DESIGN_HOME)/src/liteeth/macros/sky130hd/liteeth_32x384_8_sram.lef

export ADDITIONAL_LIBS = \
  $(DESIGN_HOME)/src/liteeth/macros/sky130hd/liteeth_32x384_32_sram.lib \
  $(DESIGN_HOME)/src/liteeth/macros/sky130hd/liteeth_32x384_8_sram.lib

export DIE_AREA = 0 0 1630 1630
export CORE_AREA = 30 30 1600 1600
# export CORE_UTILIZATION = 30
export PLACE_DENSITY = 0.2

export CAP_MARGIN = 0.02
export SLEW_MARGIN = 0.02
# export CELL_PAD_IN_SITES_GLOBAL_PLACEMENT = 2
# export CELL_PAD_IN_SITES_DETAIL_PLACEMENT = 2
export MACRO_PLACE_HALO = 30 30

export ROUTING_LAYER_ADJUSTMENT = 0.25

