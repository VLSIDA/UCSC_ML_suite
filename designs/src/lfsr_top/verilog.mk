ifneq ($(wildcard $(DEV_FLAG)),)
export VERILOG_FILES = \
  $(wildcard $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/dev/*.v) \
  $(wildcard $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/dev/repo/rtl/*.v)
else
export VERILOG_FILES = $(wildcard $(BENCH_DESIGN_HOME)/src/$(DESIGN_NAME)/*.v)
endif