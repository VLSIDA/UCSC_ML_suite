export DESIGN_NAME = liteeth_mac_wb_mii
export DESIGN_NICKNAME = liteeth
export PLATFORM    = nangate45

PLATFORM_DESIGN_DIR=$(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)
REPO_SRC_DIR = $(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)

TARGET_FILE = $(REPO_SRC_DIR)/$(DESIGN_NAME).v

# Target yml file to be generated
export YML_FILE=$(REPO_SRC_DIR)/repo/examples/wishbone_mii.yml

USED_REPO_FILES=$(YML_FILE)
$(TARGET_FILE) : $(USED_REPO_FILES) 
	bash $(REPO_SRC_DIR)/gen.sh && echo "Starting Generation..."
	patch --silent -N -l $(TARGET_FILE) < $(REPO_SRC_DIR)/patch/mac_wb_mii.patch && echo "Converting to ASIC..."

export VERILOG_FILES = $(TARGET_FILE) \
                       $(PLATFORM_DESIGN_DIR)/xilinx2asic/FDPE.v \
                       $(PLATFORM_DESIGN_DIR)/sram/liteeth_1rw1r_32w384d_32_sram.v \
                       $(PLATFORM_DESIGN_DIR)/sram/liteeth_1rw1r_32w384d_8_sram.v

export SDC_FILE      = $(PLATFORM_DESIGN_DIR)/$(DESIGN_NAME)/constraint.sdc

export ADDITIONAL_LEFS = \
  $(PLATFORM_DESIGN_DIR)/sram/liteeth_1rw1r_32w384d_32_sram.lef \
  $(PLATFORM_DESIGN_DIR)/sram/liteeth_1rw1r_32w384d_8_sram.lef

export ADDITIONAL_LIBS = \
  $(PLATFORM_DESIGN_DIR)/sram/liteeth_1rw1r_32w384d_32_sram.lib \
  $(PLATFORM_DESIGN_DIR)/sram/liteeth_1rw1r_32w384d_8_sram.lib

export DIE_AREA = 0 0 680 680
export CORE_AREA = 15 15 665 665
export PLACE_DENSITY = 0.25
export CAP_MARGIN = 0.02
export SLEW_MARGIN = 0.15
export CELL_PAD_IN_SITES_GLOBAL_PLACEMENT = 3
export CELL_PAD_IN_SITES_DETAIL_PLACEMENT = 3
export MACRO_PLACE_HALO = 30 30
export ROUTING_LAYER_ADJUSTMENT = 0.2