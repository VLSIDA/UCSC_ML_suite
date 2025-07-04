# XDC file generated from LitEx
# Converted from XDC to SDC timing constraints
# Made to run on 100 MHz

current_design liteeth_mac_wb_mii  

################################################################################
# Clock constraints
################################################################################

# Define system clock (adjust period based on your target frequency)
create_clock -name sys_clk -period 10.0 [get_ports sys_clock]

# Ethernet receive clock (25 MHz for MII = 40ns period)
create_clock -name eth_rx_clk -period 40.0 [get_nets eth_rx_clk]

# Ethernet transmit clock (25 MHz for MII = 40ns period)  
create_clock -name eth_tx_clk -period 40.0 [get_nets eth_tx_clk]

################################################################################
# Clock domain crossing constraints
################################################################################

# Mark clock domains as asynchronous to each other
set_clock_groups -group [get_clocks sys_clk] -group [get_clocks eth_rx_clk] -asynchronous
set_clock_groups -group [get_clocks sys_clk] -group [get_clocks eth_tx_clk] -asynchronous  
set_clock_groups -group [get_clocks eth_rx_clk] -group [get_clocks eth_tx_clk] -asynchronous

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
set_input_delay  2.0 -clock sys_clk [get_ports wishbone_*]
set_output_delay 2.0 -clock sys_clk [get_ports wishbone_*]

# MII interface timing constraints
set_input_delay  4.0 -clock eth_rx_clk [get_ports mii_rx_*]
set_output_delay 4.0 -clock eth_tx_clk [get_ports mii_tx_*]

# Interrupt output
set_output_delay [expr 10.0 * $clk_io_pct] -clock sys_clk [get_ports interrupt]
