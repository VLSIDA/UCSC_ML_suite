#!/bin/bash

# liteeth_udp_stream_sgmii
echo "Setting up liteeth_udp_stream_sgmii..."
rm -rf build
python ../repo/liteeth/gen.py ../repo/examples/udp_a7_gtp_sgmii.yml
cp build/gateware/liteeth_core.v ../liteeth_udp_stream_sgmii.v
mkdir ../builds
cp -r build ../builds/udp_stream_sgmii_build

sed -i 's/^module liteeth_core (/module liteeth_udp_stream_sgmii (/' ../liteeth_udp_stream_sgmii.v

sed -i 's/^GTPE2_COMMON #(/GTPE2_COMMON_DUMMY #(/' ../liteeth_udp_stream_sgmii.v
sed -i 's/^GTPE2_CHANNEL #(/GTPE2_CHANNEL_DUMMY #(/' ../liteeth_udp_stream_sgmii.v
sed -i 's/^MMCME2_ADV #(/MMCME2_DUMMY #(/' ../liteeth_udp_stream_sgmii.v
sed -i '/\$readmemh("liteeth_core_mem_6b5b.init", mem_6b5b);/d' ../liteeth_udp_stream_sgmii.v

sed -i '/\/\/ Memory storage: 32-words x 42-bit/,/assign core_mac_core_tx_cdc_cdc_rdport_dat_r = storage_dat1;/c\
\/\/ Modified Memory storage: 32-words x 48-bit\
\/\/------------------------------------------------------------------------------\
\/\/ Port 0 | Read: Sync  | Write: Sync | Mode: Read-First | Write-Granularity: 48 \
\/\/ Port 1 | Read: Sync | Write: ---- | \
wire [47:0] storage_dat0;\
wire [47:0] storage_dat1;\
liteeth_1rw1r_48w32d_sram u_storage_48w32d_0 (\
`ifdef USE_POWER_PINS\
    .vdd(vdd),\
    .gnd(gnd),\
`endif\
    \/\/ Port 0: RW\
    .clk0(sys_clk),\
    .csb0(1'"'"'b0),\
    .web0(~core_mac_core_tx_cdc_cdc_wrport_we),\
    .addr0(core_mac_core_tx_cdc_cdc_wrport_adr),\
    .din0({6'"'"'b0, core_mac_core_tx_cdc_cdc_wrport_dat_w}),\
    .dout0(storage_dat0),\
    \/\/ Port 1: R\
    .clk1(eth_tx_clk),\
    .csb1(1'"'"'b0),\
    .addr1(core_mac_core_tx_cdc_cdc_rdport_adr),\
    .dout1(storage_dat1)\
);\
assign core_mac_core_tx_cdc_cdc_wrport_dat_r = storage_dat0[41:0];\
assign core_mac_core_tx_cdc_cdc_rdport_dat_r = storage_dat1[41:0];\
' ../liteeth_udp_stream_sgmii.v

sed -i '/\/\/ Memory storage_1: 32-words x 42-bit/,/assign core_mac_core_rx_cdc_cdc_rdport_dat_r = storage_1_dat1;/c\
\/\/ Modified Modified Memory storage_1: 32-words x 48-bit\
\/\/------------------------------------------------------------------------------\
\/\/ Port 0 | Read: Sync  | Write: Sync | Mode: Read-First | Write-Granularity: 48 \
\/\/ Port 1 | Read: Sync | Write: ---- | \
wire [47:0] storage_1_dat0;\
wire [47:0] storage_1_dat1;\
liteeth_1rw1r_48w32d_sram u_storage_48w32d_1 (\
`ifdef USE_POWER_PINS\
    .vdd(vdd),\
    .gnd(gnd),\
`endif\
    \/\/ Port 0: RW\
    .clk0(eth_rx_clk),\
    .csb0(1'"'"'b0),\
    .web0(~core_mac_core_rx_cdc_cdc_wrport_we),\
    .addr0(core_mac_core_rx_cdc_cdc_wrport_adr),\
    .din0({6'"'"'b0, core_mac_core_rx_cdc_cdc_wrport_dat_w}),\
    .dout0(storage_1_dat0),\
    \/\/ Port 1: R\
    .clk1(sys_clk),\
    .csb1(1'"'"'b0),\
    .addr1(core_mac_core_rx_cdc_cdc_rdport_adr),\
    .dout1(storage_1_dat1)\
);\
assign core_mac_core_rx_cdc_cdc_wrport_dat_r = storage_1_dat0[41:0];\
assign core_mac_core_rx_cdc_cdc_rdport_dat_r = storage_1_dat1[41:0];\
' ../liteeth_udp_stream_sgmii.v

sed -i '/\/\/ Memory storage_3: 32-words x 42-bit/,/assign core_icmp_echo_payload_fifo_rdport_dat_r = storage_3_dat1;/c\
\/\/ Modified Memory storage_3: 32-words x 48-bit\
\/\/------------------------------------------------------------------------------\
\/\/ Port 0 | Read: Sync  | Write: Sync | Mode: Read-First | Write-Granularity: 48 \
\/\/ Port 1 | Read: Sync | Write: ---- | \
wire [47:0] storage_3_dat0;\
wire [47:0] storage_3_dat1;\
liteeth_1rw1r_48w32d_sram u_storage_48w32d_3 (\
`ifdef USE_POWER_PINS\
    .vdd(vdd),\
    .gnd(gnd),\
`endif\
    \/\/ Port 0: RW\
    .clk0(sys_clk),\
    .csb0(1'"'"'b0),\
    .web0(~core_icmp_echo_payload_fifo_wrport_we),\
    .addr0(core_icmp_echo_payload_fifo_wrport_adr),\
    .din0({6'"'"'b0, core_icmp_echo_payload_fifo_wrport_dat_w}),\
    .dout0(storage_3_dat0),\
    \/\/ Port 1: R\
    .clk1(sys_clk),\
    .csb1(~core_icmp_echo_payload_fifo_rdport_re),\
    .addr1(core_icmp_echo_payload_fifo_rdport_adr),\
    .dout1(storage_3_dat1)\
);\
assign core_icmp_echo_payload_fifo_wrport_dat_r = storage_3_dat0[41:0];\
assign core_icmp_echo_payload_fifo_rdport_dat_r = storage_3_dat1[41:0];\
' ../liteeth_udp_stream_sgmii.v

sed -i '/\/\/ Memory storage_5: 1024-words x 34-bit/,/assign udpcore_tx_fifo_rdport_dat_r = storage_5_dat1;/c\
\/\/ Modified Memory storage_5: 1024-words x 64-bit\
\/\/------------------------------------------------------------------------------\
\/\/ Port 0 | Read: Sync  | Write: Sync | Mode: Read-First | Write-Granularity: 64 \
\/\/ Port 1 | Read: Sync | Write: ---- | \
wire [63:0] storage_5_dat0;\
wire [63:0] storage_5_dat1;\
liteeth_1rw1r_64w1024d_sram u_storage_64w1024d_5 (\
`ifdef USE_POWER_PINS\
    .vdd(vdd),\
    .gnd(gnd),\
`endif\
    \/\/ Port 0: RW\
    .clk0(sys_clk),\
    .csb0(1'"'"'b0),\
    .web0(~udpcore_tx_fifo_wrport_we),\
    .addr0(udpcore_tx_fifo_wrport_adr),\
    .din0({30'"'"'b0, udpcore_tx_fifo_wrport_dat_w}),\
    .dout0(storage_5_dat0),\
    \/\/ Port 1: R\
    .clk1(sys_clk),\
    .csb1(~udpcore_tx_fifo_rdport_re),\
    .addr1(udpcore_tx_fifo_rdport_adr),\
    .dout1(storage_5_dat1)\
);\
assign udpcore_tx_fifo_wrport_dat_r = storage_5_dat0[33:0];\
assign udpcore_tx_fifo_rdport_dat_r = storage_5_dat1[33:0];\
' ../liteeth_udp_stream_sgmii.v

sed -i '/\/\/ Memory storage_6: 1024-words x 35-bit/,/assign udpcore_rx_fifo_rdport_dat_r = storage_6_dat1;/c\
\/\/ Modified Memory storage_6: 1024-words x 64-bit\
\/\/------------------------------------------------------------------------------\
\/\/ Port 0 | Read: Sync  | Write: Sync | Mode: Read-First | Write-Granularity: 64 \
\/\/ Port 1 | Read: Sync | Write: ---- | \
wire [63:0] storage_6_dat0;\
wire [63:0] storage_6_dat1;\
liteeth_1rw1r_64w1024d_sram u_storage_64w1024d_6 (\
`ifdef USE_POWER_PINS\
    .vdd(vdd),\
    .gnd(gnd),\
`endif\
    \/\/ Port 0: RW\
    .clk0(sys_clk),\
    .csb0(1'"'"'b0),\
    .web0(~udpcore_rx_fifo_wrport_we),\
    .addr0(udpcore_rx_fifo_wrport_adr),\
    .din0({29'"'"'b0, udpcore_rx_fifo_wrport_dat_w}),\
    .dout0(storage_6_dat0),\
    \/\/ Port 1: R\
    .clk1(sys_clk),\
    .csb1(~udpcore_rx_fifo_rdport_re),\
    .addr1(udpcore_rx_fifo_rdport_adr),\
    .dout1(storage_6_dat1)\
);\
assign udpcore_rx_fifo_wrport_dat_r = storage_6_dat0[34:0];\
assign udpcore_rx_fifo_rdport_dat_r = storage_6_dat1[34:0];\
' ../liteeth_udp_stream_sgmii.v

