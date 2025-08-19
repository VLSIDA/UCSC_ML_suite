export DESIGN_NAME = liteeth_mac_wb_mii
export PLATFORM    = nangate45

-include $(BENCH_DESIGN_HOME)/src/liteeth/verilog.mk

export SDC_FILE      = $(BENCH_DESIGN_HOME)/$(PLATFORM)/liteeth/$(DESIGN_NAME)/constraint.sdc

export ADDITIONAL_LEFS = \
  $(BENCH_DESIGN_HOME)/$(PLATFORM)/liteeth/sram/liteeth_1rw1r_32w384d_32_sram.lef \
  $(BENCH_DESIGN_HOME)/$(PLATFORM)/liteeth/sram/liteeth_1rw1r_32w384d_8_sram.lef

export ADDITIONAL_LIBS = \
  $(BENCH_DESIGN_HOME)/$(PLATFORM)/liteeth/sram/liteeth_1rw1r_32w384d_32_sram.lib \
  $(BENCH_DESIGN_HOME)/$(PLATFORM)/liteeth/sram/liteeth_1rw1r_32w384d_8_sram.lib

export DIE_AREA = 0 0 680 680
export CORE_AREA = 15 15 665 665
export PLACE_DENSITY = 0.25
export CAP_MARGIN = 0.02
export SLEW_MARGIN = 0.15
export CELL_PAD_IN_SITES_GLOBAL_PLACEMENT = 3
export CELL_PAD_IN_SITES_DETAIL_PLACEMENT = 3
export MACRO_PLACE_HALO = 30 30
export ROUTING_LAYER_ADJUSTMENT = 0.2