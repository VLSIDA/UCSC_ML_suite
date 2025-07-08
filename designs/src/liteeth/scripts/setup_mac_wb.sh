# liteeth_mac_wb_mii
echo "Setting up liteeth_mac_wb_mii..."
rm -rf build
python ../repo/liteeth/gen.py ../repo/examples/wishbone_mii.yml
cp build/gateware/liteeth_core.v ../liteeth_mac_wb_mii.v
sed -i 's/^module liteeth_core (/module liteeth_mac_wb_mii (/' ../liteeth_mac_wb_mii.v

sed -i '/\/\/ Memory mem: 383-words x 32-bit/,/assign wishbone_interface_sram0_dat_r = mem_dat1;/c\
liteeth_32x384_32_sram u_tx_buffer_0 (\
`ifdef USE_POWER_PINS\
    .vdd(vdd),\
    .gnd(gnd),\
`endif\
    // Port 0: RW (Read/Write)\
    .clk0(sys_clk),\
    .csb0(1'\''b0),                                        // Always enabled\
    .web0(~wishbone_interface_writer_memory0_we),       // Active low write enable\
    .addr0(wishbone_interface_writer_memory0_adr),\
    .din0(wishbone_interface_writer_memory0_dat_w),\
    .dout0(wishbone_interface_writer_memory0_dat_r),\
    \
    // Port 1: R (Read-only)\
    .clk1(sys_clk),\
    .csb1(1'\''b0),                                        // Always enabled\
    .addr1(wishbone_interface_sram0_adr),\
    .dout1(wishbone_interface_sram0_dat_r)\
);' ../liteeth_mac_wb_mii.v

sed -i '/\/\/ Memory mem_1: 383-words x 32-bit/,/assign wishbone_interface_sram1_dat_r = mem_1_dat1;/c\
liteeth_32x384_32_sram u_tx_buffer_1 (\
`ifdef USE_POWER_PINS\
    .vdd(vdd),\
    .gnd(gnd),\
`endif\
    // Port 0: RW (Read/Write)\
    .clk0(sys_clk),\
    .csb0(1'\''b0),                                        // Always enabled\
    .web0(~wishbone_interface_writer_memory1_we),       // Active low write enable\
    .addr0(wishbone_interface_writer_memory1_adr),\
    .din0(wishbone_interface_writer_memory1_dat_w),\
    .dout0(wishbone_interface_writer_memory1_dat_r),\
    \
    // Port 1: R (Read-only)\
    .clk1(sys_clk),\
    .csb1(1'\''b0),                                        // Always enabled\
    .addr1(wishbone_interface_sram1_adr),\
    .dout1(wishbone_interface_sram1_dat_r)\
);' ../liteeth_mac_wb_mii.v

sed -i '/^\/\/ Memory mem_2: 383-words x 32-bit/,/^assign wishbone_interface_sram2_dat_r = mem_2\[mem_2_adr1\];$/c\
liteeth_32x384_8_sram u_rx_buffer_0 (\
`ifdef USE_POWER_PINS\
    .vdd(vdd),\
    .gnd(gnd),\
`endif\
    .clk0(sys_clk),\
    .csb0(1'\''b0),\
    .web0(~|wishbone_interface_sram2_we),\
    .wmask0(wishbone_interface_sram2_we),\
    .addr0(wishbone_interface_sram2_adr),\
    .din0(wishbone_interface_sram2_dat_w),\
    .dout0(wishbone_interface_sram2_dat_r),\
    .clk1(sys_clk),\
    .csb1(~wishbone_interface_reader_memory0_re),\
    .addr1(wishbone_interface_reader_memory0_adr),\
    .dout1(wishbone_interface_reader_memory0_dat_r)\
);' ../liteeth_mac_wb_mii.v

sed -i '/^\/\/ Memory mem_3: 383-words x 32-bit/,/^assign wishbone_interface_sram3_dat_r = mem_3\[mem_3_adr1\];$/c\
liteeth_32x384_8_sram u_rx_buffer_1 (\
`ifdef USE_POWER_PINS\
    .vdd(vdd),\
    .gnd(gnd),\
`endif\
    .clk0(sys_clk),\
    .csb0(1'\''b0),\
    .web0(~|wishbone_interface_sram3_we),\
    .wmask0(wishbone_interface_sram3_we),\
    .addr0(wishbone_interface_sram3_adr),\
    .din0(wishbone_interface_sram3_dat_w),\
    .dout0(wishbone_interface_sram3_dat_r),\
    .clk1(sys_clk),\
    .csb1(~wishbone_interface_reader_memory1_re),\
    .addr1(wishbone_interface_reader_memory1_adr),\
    .dout1(wishbone_interface_reader_memory1_dat_r)\
);' ../liteeth_mac_wb_mii.v

# sed -i '/^\/\/ Memory storage_2: 32-words x 42-bit/,/^assign core_rx_cdc_cdc_rdport_dat_r = storage_2_dat1;$/c\
# liteeth_48x32_sram u_rx_cdc_storage (\
# `ifdef USE_POWER_PINS\
#     .vdd(vdd),\
#     .gnd(gnd),\
# `endif\
#     // Port 0: RW (Write/Read Port - eth_rx_clk domain)\
#     .clk0(eth_rx_clk),\
#     .csb0(1'\''b0),                                    // Always enabled\
#     .web0(~core_rx_cdc_cdc_wrport_we),                // Active low write enable\
#     .addr0(core_rx_cdc_cdc_wrport_adr),\
#     .din0(core_rx_cdc_cdc_wrport_dat_w),\
#     .dout0(core_rx_cdc_cdc_wrport_dat_r),\
#     \
#     // Port 1: R (Read-Only Port - sys_clk domain)\
#     .clk1(sys_clk),\
#     .csb1(1'\''b0),                                    // Always enabled\
#     .addr1(core_rx_cdc_cdc_rdport_adr),\
#     .dout1(core_rx_cdc_cdc_rdport_dat_r)\
# );' ../liteeth_mac_wb_mii.v

# sed -i '/^\/\/ Memory storage: 32-words x 42-bit/,/^assign core_tx_cdc_cdc_rdport_dat_r = storage_dat1;$/c\
# liteeth_48x32_sram u_tx_cdc_storage (\
# `ifdef USE_POWER_PINS\
#     .vdd(vdd),\
#     .gnd(gnd),\
# `endif\
#     // Port 0: RW (Write/Read Port - sys_clk domain)\
#     .clk0(sys_clk),\
#     .csb0(1'\''b0),                                    // Always enabled\
#     .web0(~core_tx_cdc_cdc_wrport_we),                // Active low write enable\
#     .addr0(core_tx_cdc_cdc_wrport_adr),\
#     .din0(core_tx_cdc_cdc_wrport_dat_w),\
#     .dout0(core_tx_cdc_cdc_wrport_dat_r),\
#     \
#     // Port 1: R (Read-Only Port - eth_tx_clk domain)\
#     .clk1(eth_tx_clk),\
#     .csb1(1'\''b0),                                    // Always enabled\
#     .addr1(core_tx_cdc_cdc_rdport_adr),\
#     .dout1(core_tx_cdc_cdc_rdport_dat_r)\
# );' ../liteeth_mac_wb_mii.v

echo "Successfully setting up liteeth_mac_wb_mii"
