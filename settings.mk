export BENCH_DESIGN_HOME = $(abspath $(dir $(firstword $(MAKEFILE_LIST)))/designs)
export DEV_FLAG          = $(abspath $(dir $(firstword $(MAKEFILE_LIST)))/.dev-suite-run)
export DEV_DESIGN_HOME  ?= $(DESIGN_NAME)