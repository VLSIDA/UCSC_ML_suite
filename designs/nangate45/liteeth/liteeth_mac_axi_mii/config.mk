export DESIGN_NAME = liteeth_mac_axi_mii
export DESIGN_NICKNAME = liteeth
export PLATFORM    = nangate45

PLATFORM_DESIGN_DIR=$(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)
REPO_SRC_DIR = $(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)

TARGET_FILE = $(REPO_SRC_DIR)/$(DESIGN_NAME).v

# Target yml file to be generated
export YML_FILE=$(REPO_SRC_DIR)/repo/examples/axi-lite-mii.yml

USED_REPO_FILES=$(YML_FILE)
$(TARGET_FILE) : $(USED_REPO_FILES) 
	bash $(REPO_SRC_DIR)/gen.sh && echo "Starting Generation..."
	patch --silent -N -l $(TARGET_FILE) < $(REPO_SRC_DIR)/patch/mac_axi_mii.patch && echo "Converting to ASIC..."

export VERILOG_FILES = $(TARGET_FILE) \
                       $(PLATFORM_DESIGN_DIR)/xilinx2asic/FDPE.v \
                       $(PLATFORM_DESIGN_DIR)/sram/verilog/liteeth_1rw1r_32w384d_32_sram.v \
                       $(PLATFORM_DESIGN_DIR)/sram/verilog/liteeth_1rw1r_32w384d_8_sram.v

export SDC_FILE      = $(PLATFORM_DESIGN_DIR)/$(DESIGN_NAME)/constraint.sdc

export ADDITIONAL_LEFS = \
  $(PLATFORM_DESIGN_DIR)/sram/lef/liteeth_1rw1r_32w384d_32_sram.lef \
  $(PLATFORM_DESIGN_DIR)/sram/lef/liteeth_1rw1r_32w384d_8_sram.lef

export ADDITIONAL_LIBS = \
  $(PLATFORM_DESIGN_DIR)/sram/lib/liteeth_1rw1r_32w384d_32_sram.lib \
  $(PLATFORM_DESIGN_DIR)/sram/lib/liteeth_1rw1r_32w384d_8_sram.lib

export DIE_AREA = 0 0 700 700
export CORE_AREA = 15 15 685 685
export PLACE_DENSITY = 0.4
export CELL_PAD_IN_SITES_GLOBAL_PLACEMENT = 2
export CELL_PAD_IN_SITES_DETAIL_PLACEMENT = 2
export MACRO_PLACE_HALO = 30 30
export ROUTING_LAYER_ADJUSTMENT = 0.25