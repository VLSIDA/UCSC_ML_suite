export DEV_DESIGN_HOME = liteeth/dev

ifneq ($(wildcard $(DEV_FLAG)),)
TARGET_DEV_FILE = $(BENCH_DESIGN_HOME)/src/liteeth/dev/$(DESIGN_NAME).v
# Target yml file to be generated
export YML_FILE=$(BENCH_DESIGN_HOME)/src/liteeth/dev/repo/examples/axi-lite-mii.yml
REPO_FILES=$(YML_FILE)
$(TARGET_DEV_FILE) : $(REPO_FILES) 
	@echo "Starting Generation..."
	@bash $(BENCH_DESIGN_HOME)/src/liteeth/dev/gen.sh 
	@echo "Patching Files for ASIC generation..."
	@patch --silent -N -l $(TARGET_DEV_FILE) < $(BENCH_DESIGN_HOME)/src/liteeth/dev/patch/$(DESIGN_NAME).patch

export VERILOG_FILES = $(TARGET_DEV_FILE) \
                       $(BENCH_DESIGN_HOME)/$(PLATFORM)/liteeth/xilinx2asic/FDPE.v

else
export VERILOG_FILES = $(BENCH_DESIGN_HOME)/src/liteeth/liteeth_mac_axi_mii.v \
					   $(BENCH_DESIGN_HOME)/src/liteeth/xilinx2asic/FDPE.v
endif