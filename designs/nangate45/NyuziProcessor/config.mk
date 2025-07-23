export DESIGN_NICKNAME = NyuziProcessor
export DESIGN_NAME = core
export PLATFORM    = nangate45
# Used to specify design-specific src files to clean
export DESIGN_SRC = $(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)/nyuziTop.v \
					$(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)/repo

REPO_SRC_DIR    = $(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)/repo/hardware/core
REPO_FILES  = $(wildcard $(REPO_SRC_DIR)/*.sv)
USED_REPO_FILES  = $(filter-out \
  $(REPO_SRC_DIR)/sram_1r1w.sv \
  $(REPO_SRC_DIR)/sram_2r1w.sv, \
  $(REPO_FILES))
REPO_INCLUDE_FILES = $(REPO_SRC_DIR)/defines.svh

TARGET_FILE = $(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)/nyuziTop.v

$(TARGET_FILE) : $(USED_REPO_FILES) 
    # Bypass error if patch has already been applied (prone to fail if repo code has changed)
	patch -p0 -N --silent --directory=$(REPO_SRC_DIR) < $(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)/patch-all.patch > /dev/null 2>&1 || [[ $$? == 1 ]]
	$(BENCH_DESIGN_HOME)/src/$(DESIGN_NICKNAME)/sv2v -w $@ -I $(REPO_INCLUDE_FILES) $(USED_REPO_FILES)


export SYNTH_HIERARCHICAL = 1

export VERILOG_FILES = $(TARGET_FILE) \
                       $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/macros.v
                       

export ADDITIONAL_LEFS = $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lef/sram_1x256_1r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lef/sram_3x1_1r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lef/sram_16x52_1r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lef/sram_20x64_1r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lef/sram_20x64_2r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lef/sram_32x128_2r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lef/sram_512x256_1r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lef/sram_512x1024_1r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lef/sram_512x2048_1r1w.lef

export ADDITIONAL_LIBS = $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lib/sram_1x256_1r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lib/sram_3x1_1r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lib/sram_16x52_1r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lib/sram_20x64_1r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lib/sram_20x64_2r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lib/sram_32x128_2r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lib/sram_512x256_1r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lib/sram_512x1024_1r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/sram/lib/sram_512x2048_1r1w.lib 
export ABC_AREA = 1

export SDC_FILE      = $(BENCH_DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export CORE_UTILIZATION = 43

export PLACE_DENSITY_LB_ADDON = 0.05

export MACRO_PLACE_HALO    = 25 25

export TNS_END_PERCENT     = 100


