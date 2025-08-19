export DESIGN_NAME = core
export PLATFORM    = nangate45
# Used to specify design-specific src files to clean



export SYNTH_HIERARCHICAL = 1

export ADDITIONAL_LEFS = $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lef/sram_1x256_1r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lef/sram_3x1_1r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lef/sram_16x52_1r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lef/sram_20x64_1r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lef/sram_20x64_2r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lef/sram_32x128_2r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lef/sram_512x256_1r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lef/sram_512x1024_1r1w.lef \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lef/sram_512x2048_1r1w.lef

export ADDITIONAL_LIBS = $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lib/sram_1x256_1r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lib/sram_3x1_1r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lib/sram_16x52_1r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lib/sram_20x64_1r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lib/sram_20x64_2r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lib/sram_32x128_2r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lib/sram_512x256_1r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lib/sram_512x1024_1r1w.lib \
                         $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/sram/lib/sram_512x2048_1r1w.lib 
export ABC_AREA = 1

export SDC_FILE      = $(BENCH_DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/constraint.sdc

export DIE_AREA  = 0 0 2450 2450 
export CORE_AREA = 30 30 2420 2420


export PLACE_DENSITY_LB_ADDON = 0.05

export MACRO_PLACE_HALO    = 25 25

export TNS_END_PERCENT     = 100

export FASTROUTE_TCL = $(DESIGN_HOME)/$(PLATFORM)/NyuziProcessor/fastroute.tcl