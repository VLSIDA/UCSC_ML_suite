ifneq ($(wildcard $(DEV_FLAG)),)
export DEV_SRC = $(BENCH_DESIGN_HOME)/src/NyuziProcessor/dev/nyuziTop.v \
				 $(BENCH_DESIGN_HOME)/src/NyuziProcessor/dev/repo
REPO_SRC_DIR    = $(BENCH_DESIGN_HOME)/src/NyuziProcessor/dev/repo/hardware/core$
REPO_FILES  = $(wildcard $(REPO_SRC_DIR)/*.sv)
REPO_FILES  = $(filter-out \
  $(REPO_SRC_DIR)/sram_1r1w.sv \
  $(REPO_SRC_DIR)/sram_2r1w.sv, \
  $(REPO_FILES))
REPO_INCLUDE_FILES = $(REPO_SRC_DIR)/defines.svh

TARGET_DEV_FILE = $(BENCH_DESIGN_HOME)/src/NyuziProcessor/dev/nyuziTop.v

$(TARGET_DEV_FILE) : $(REPO_FILES) 
    # Bypass error if patch has already been applied (prone to fail if repo code has changed)
	patch -p0 -N --silent --directory=$(REPO_SRC_DIR) < $(BENCH_DESIGN_HOME)/src/NyuziProcessor/patch-all.patch > /dev/null 2>&1 || [[ $$? == 1 ]]
	$(BENCH_DESIGN_HOME)/src/NyuziProcessor/dev/sv2v -w $@ -I $(REPO_INCLUDE_FILES) $(REPO_FILES)

export VERILOG_FILES = $(TARGET_DEV_FILE) \
                       $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/macros.v
                       
else
export VERILOG_FILES = $(BENCH_DESIGN_HOME)/src/NyuziProcessor/nyuziTop.v \
                       $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/macros.v
endif