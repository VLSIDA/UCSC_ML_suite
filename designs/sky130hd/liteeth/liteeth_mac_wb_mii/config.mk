export DESIGN_NAME = liteeth_mac_wb_mii
export DESIGN_NICKNAME = liteeth
export PLATFORM    = sky130hd

export VERILOG_FILES = $(DESIGN_HOME)/src/liteeth/liteeth_mac_wb_mii.v \
                       $(DESIGN_HOME)/src/liteeth/xilinx2asic/FDPE.v \
                       $(DESIGN_HOME)/src/liteeth/macros/sky130hd/liteeth_1rw1r_32w384d_32_sram.v \
                       $(DESIGN_HOME)/src/liteeth/macros/sky130hd/liteeth_1rw1r_32w384d_8_sram.v

export SDC_FILE      = $(DESIGN_HOME)/$(PLATFORM)/liteeth/liteeth_mac_wb_mii/constraint.sdc
export MACRO_PLACEMENT_TCL = $(DESIGN_HOME)/$(PLATFORM)/liteeth/liteeth_mac_wb_mii/macro_placement.tcl

export ADDITIONAL_LEFS = \
  $(DESIGN_HOME)/src/liteeth/macros/sky130hd/liteeth_1rw1r_32w384d_32_sram.lef \
  $(DESIGN_HOME)/src/liteeth/macros/sky130hd/liteeth_1rw1r_32w384d_8_sram.lef

export ADDITIONAL_LIBS = \
  $(DESIGN_HOME)/src/liteeth/macros/sky130hd/liteeth_1rw1r_32w384d_32_sram.lib \
  $(DESIGN_HOME)/src/liteeth/macros/sky130hd/liteeth_1rw1r_32w384d_8_sram.lib

export DIE_AREA = 0 0 1630 1630
export CORE_AREA = 30 30 1600 1600
export PLACE_DENSITY = 0.2

export CAP_MARGIN = 0.02
export SLEW_MARGIN = 0.02
export MACRO_PLACE_HALO = 30 30

export ROUTING_LAYER_ADJUSTMENT = 0.25

