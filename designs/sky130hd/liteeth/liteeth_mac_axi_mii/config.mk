export DESIGN_NAME = liteeth_mac_axi_mii
export PLATFORM    = sky130hd

-include $(BENCH_DESIGN_HOME)/src/liteeth/verilog.mk

export SDC_FILE            = $(BENCH_DESIGN_HOME)/$(PLATFORM)/liteeth/$(DESIGN_NAME)/constraint.sdc

export MACRO_PLACEMENT_TCL = $(BENCH_DESIGN_HOME)/$(PLATFORM)/liteeth/$(DESIGN_NAME)/macro_placement.tcl

export ADDITIONAL_LEFS = \
  $(BENCH_DESIGN_HOME)/$(PLATFORM)/liteeth/sram/liteeth_1rw1r_32w384d_32_sram.lef \
  $(BENCH_DESIGN_HOME)/$(PLATFORM)/liteeth/sram/liteeth_1rw1r_32w384d_8_sram.lef

export ADDITIONAL_LIBS = \
  $(BENCH_DESIGN_HOME)/$(PLATFORM)/liteeth/sram/liteeth_1rw1r_32w384d_32_sram.lib \
  $(BENCH_DESIGN_HOME)/$(PLATFORM)/liteeth/sram/liteeth_1rw1r_32w384d_8_sram.lib


export CORE_UTILIZATION = 35
export PLACE_DENSITY = 0.2

export CAP_MARGIN = 0.02
export SLEW_MARGIN = 0.02
export MACRO_PLACE_HALO = 30 30

export ROUTING_LAYER_ADJUSTMENT = 0.25