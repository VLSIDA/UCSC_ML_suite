#!/bin/bash

#!/bin/bash

# liteeth_mac_wb_mii
echo "Setting up liteeth_mac_wb_mii..."
rm -rf build
python ../repo/liteeth/gen.py ../repo/examples/wishbone_mii.yml
cp build/gateware/liteeth_core.v ../liteeth_mac_wb_mii.v
mkdir ../builds
cp -r build ../builds/mac_wb_build

sed -i 's/^module liteeth_core (/module liteeth_mac_wb_mii (/' ../liteeth_mac_wb_mii.v

# Replace mem (32-bit x 384-word)
sed -i '/\/\/ Memory mem: 383-words x 32-bit/,/assign wishbone_interface_sram0_dat_r = mem_dat1;/c\
\/\/ Modified Memory mem: 384-words x 32-bit \
\/\/------------------------------------------------------------------------------\
\/\/ Port 0 | Read: Sync  | Write: Sync | Mode: Write-First | Write-Granularity: 32 \
\/\/ Port 1 | Read: Sync  | Write: ---- | \
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

# Replace mem_1 (32-bit x 384-word)
sed -i '/\/\/ Memory mem_1: 383-words x 32-bit/,/assign wishbone_interface_sram1_dat_r = mem_1_dat1;/c\
\/\/ Modified Memory mem_1: 384-words x 32-bit \
\/\/------------------------------------------------------------------------------\
\/\/ Port 0 | Read: Sync  | Write: Sync | Mode: Write-First | Write-Granularity: 32 \
\/\/ Port 1 | Read: Sync  | Write: ---- | \
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

# Replace mem_2 (32-bit x 384-word)
sed -i '/^\/\/ Memory mem_2: 383-words x 32-bit/,/^assign wishbone_interface_sram2_dat_r = mem_2\[mem_2_adr1\];$/c\
\/\/ Modified Memory mem_2: 384-words x 32-bit \
\/\/------------------------------------------------------------------------------\
\/\/ Port 0 | Read: Sync  | Write: Sync | Mode: Write-First | Write-Granularity: 8 \
\/\/ Port 1 | Read: Sync  | Write: ---- | \
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

# Replace mem_3 (32-bit x 384-word)
sed -i '/^\/\/ Memory mem_3: 383-words x 32-bit/,/^assign wishbone_interface_sram3_dat_r = mem_3\[mem_3_adr1\];$/c\
\/\/ Modified Memory mem_3: 384-words x 32-bit \
\/\/------------------------------------------------------------------------------\
\/\/ Port 0 | Read: Sync  | Write: Sync | Mode: Write-First | Write-Granularity: 8 \
\/\/ Port 1 | Read: Sync  | Write: ---- | \
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

echo "Successfully setting up liteeth_mac_wb_mii"
