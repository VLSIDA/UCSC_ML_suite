
# Create Project

create_project -force -name liteeth_core -part 
set_msg_config -id {Common 17-55} -new_severity {Warning}

# Add project commands


# Add Sources

read_verilog {/OpenROAD-flow-scripts/UCSC_ML_suite/designs/src/liteeth/scripts/build/gateware/liteeth_core.v}

# Add EDIFs


# Add IPs


# Add constraints

read_xdc liteeth_core.xdc
set_property PROCESSING_ORDER EARLY [get_files liteeth_core.xdc]

# Add pre-synthesis commands


# Synthesis

synth_design -directive default -top liteeth_core -part 

# Synthesis report

report_timing_summary -file liteeth_core_timing_synth.rpt
report_utilization -hierarchical -file liteeth_core_utilization_hierarchical_synth.rpt
report_utilization -file liteeth_core_utilization_synth.rpt
write_checkpoint -force liteeth_core_synth.dcp

# Add pre-optimize commands


# Optimize design

opt_design -directive default

# Add pre-placement commands


# Placement

place_design -directive default

# Placement report

report_utilization -hierarchical -file liteeth_core_utilization_hierarchical_place.rpt
report_utilization -file liteeth_core_utilization_place.rpt
report_io -file liteeth_core_io.rpt
report_control_sets -verbose -file liteeth_core_control_sets.rpt
report_clock_utilization -file liteeth_core_clock_utilization.rpt
write_checkpoint -force liteeth_core_place.dcp

# Add pre-routing commands


# Routing

route_design -directive default
phys_opt_design -directive default
write_checkpoint -force liteeth_core_route.dcp

# Routing report

report_timing_summary -no_header -no_detailed_paths
report_route_status -file liteeth_core_route_status.rpt
report_drc -file liteeth_core_drc.rpt
report_timing_summary -datasheet -max_paths 10 -file liteeth_core_timing.rpt
report_power -file liteeth_core_power.rpt

# Bitstream generation

write_bitstream -force liteeth_core.bit 

# End

quit