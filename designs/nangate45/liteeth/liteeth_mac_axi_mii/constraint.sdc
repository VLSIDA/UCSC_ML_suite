# XDC file generated from LitEx
# Converted from XDC to SDC timing constraints
# Made to run on 100 MHz

current_design liteeth_mac_axi_mii

################################################################################
# Clock constraints
################################################################################

# Define system clock (adjust period based on your target frequency)
create_clock -name sys_clk -period 10.0 [get_ports sys_clock]

# Ethernet receive clock (25 MHz for MII = 40ns period)
create_clock -name mii_clocks_rx -period 40.0 [get_ports mii_clocks_rx]

# Ethernet transmit clock (25 MHz for MII = 40ns period)  
create_clock -name mii_clocks_tx -period 40.0 [get_ports mii_clocks_tx]

################################################################################
# Clock domain crossing constraints
################################################################################

# Mark clock domains as asynchronous to each other
set_clock_groups -group [get_clocks sys_clk] -group [get_clocks mii_clocks_rx] -asynchronous
set_clock_groups -group [get_clocks sys_clk] -group [get_clocks mii_clocks_tx] -asynchronous  
set_clock_groups -group [get_clocks mii_clocks_rx] -group [get_clocks mii_clocks_tx] -asynchronous

################################################################################
# False path constraints
################################################################################

# Reset synchronizer paths (simplified for OpenROAD)
set_false_path -through [get_nets -hierarchical *mr_ff*]

# Asynchronous reset paths
set_false_path -to [get_pins -hierarchical */PRE]
set_false_path -to [get_pins -hierarchical */CLR]

# Reset synchronizer timing (if applicable)
set_max_delay 2.0 -from [get_pins -hierarchical *ars_ff1*/C] -to [get_pins -hierarchical *ars_ff2*/D]

################################################################################
# I/O timing constraints (adjust based on your interface requirements)
################################################################################

# AXI-Lite bus timing (adjust percentages based on technology)
set clk_io_pct 0.2
set_input_delay  [expr 10.0 * $clk_io_pct] -clock sys_clk [get_ports bus_*]
set_output_delay [expr 10.0 * $clk_io_pct] -clock sys_clk [get_ports bus_*]

# MII interface timing constraints
set_input_delay  4.0 -clock mii_clocks_rx [get_ports mii_rx_*]
set_output_delay 4.0 -clock mii_clocks_tx [get_ports mii_tx_*]

# Interrupt output
set_output_delay [expr 10.0 * $clk_io_pct] -clock sys_clk [get_ports interrupt]
