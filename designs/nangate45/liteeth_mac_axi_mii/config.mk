export DESIGN_NAME = liteeth_mac_axi_mii
export PLATFORM    = nangate45
export VERILOG_FILES = $(DESIGN_HOME)/src/liteeth_mac_axi_mii/liteeth_mac_axi_mii.v \
                       $(DESIGN_HOME)/src/liteeth_mac_axi_mii/macros/liteeth_32x384_32_sram.v \
                       $(DESIGN_HOME)/src/liteeth_mac_axi_mii/macros/liteeth_32x384_8_sram.v \
                       $(DESIGN_HOME)/src/liteeth_mac_axi_mii/macros/liteeth_42x32_sram.v

export SDC_FILE      = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NAME)/constraint.sdc

export ADDITIONAL_LEFS = \
  $(DESIGN_HOME)/src/liteeth_mac_axi_mii/macros/liteeth_32x384_32_sram.lef \
  $(DESIGN_HOME)/src/liteeth_mac_axi_mii/macros/liteeth_32x384_8_sram.lef \
  $(DESIGN_HOME)/src/liteeth_mac_axi_mii/macros/liteeth_42x32_sram.lef

export ADDITIONAL_LIBS = \
  $(DESIGN_HOME)/src/liteeth_mac_axi_mii/macros/liteeth_32x384_32_sram.lib \
  $(DESIGN_HOME)/src/liteeth_mac_axi_mii/macros/liteeth_32x384_8_sram.lib \
  $(DESIGN_HOME)/src/liteeth_mac_axi_mii/macros/liteeth_42x32_sram.lib


### Parameters ###
export DIE_AREA = 0 0 670 670
export CORE_AREA = 15 15 655 655
# export CORE_UTILIZATION = 30
export PLACE_DENSITY = 0.5
export CAP_MARGIN = 0.2
export SLEW_MARGIN = 0.15
export CELL_PAD_IN_SITES_GLOBAL_PLACEMENT = 2
export CELL_PAD_IN_SITES_DETAIL_PLACEMENT = 2
export MACRO_PLACE_HALO = 30 30
export ROUTING_LAYER_ADJUSTMENT = 0.25
