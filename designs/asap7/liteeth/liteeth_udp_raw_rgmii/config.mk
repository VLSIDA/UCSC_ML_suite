export DESIGN_NAME = liteeth_udp_raw_rgmii
export DESIGN_NICKNAME = liteeth
export PLATFORM    = asap7

PLATFORM_DESIGN_DIR=$(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)
REPO_SRC_DIR = $(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)

TARGET_FILE = $(REPO_SRC_DIR)/$(DESIGN_NAME).v

# Target yml file to be generated
export YML_FILE=$(REPO_SRC_DIR)/repo/examples/udp_raw_ecp5rgmii.yml

USED_REPO_FILES=$(YML_FILE)
$(TARGET_FILE) : $(USED_REPO_FILES) 
	bash $(REPO_SRC_DIR)/gen.sh && echo "Starting Generation..."
	patch --silent -N -l $(TARGET_FILE) < $(REPO_SRC_DIR)/patch/udp_raw_rgmii.patch && echo "Converting to ASIC..."

export SYNTH_HIERARCHICAL = 1

export VERILOG_FILES = $(TARGET_FILE) \
                       $(PLATFORM_DESIGN_DIR)/sram/verilog/liteeth_1rw1r_12w128d_sram.v \
                       $(PLATFORM_DESIGN_DIR)/sram/verilog/liteeth_1rw1r_64w64d_sram.v \
                       $(PLATFORM_DESIGN_DIR)/lattice2asic/DELAYG.v \
                       $(PLATFORM_DESIGN_DIR)/lattice2asic/FD1S3BX.v \
                       $(PLATFORM_DESIGN_DIR)/lattice2asic/TRELLIS_IO.v \
                       $(PLATFORM_DESIGN_DIR)/lattice2asic/IDDRX1F.v \
                       $(PLATFORM_DESIGN_DIR)/lattice2asic/ODDRX1F.v

export SDC_FILE      = $(PLATFORM_DESIGN_DIR)/$(DESIGN_NAME)/constraint.sdc

export ADDITIONAL_LEFS = \
  $(PLATFORM_DESIGN_DIR)/sram/lef/liteeth_1rw1r_12w128d_sram.lef \
  $(PLATFORM_DESIGN_DIR)/sram/lef/liteeth_1rw1r_64w64d_sram.lef

export ADDITIONAL_LIBS = \
  $(PLATFORM_DESIGN_DIR)/sram/lib/liteeth_1rw1r_12w128d_sram.lib \
  $(PLATFORM_DESIGN_DIR)/sram/lib/liteeth_1rw1r_64w64d_sram.lib

export CORE_UTILIZATION = 35
export MACRO_PLACE_HALO = 5 5
export PLACE_DENSITY = 0.3