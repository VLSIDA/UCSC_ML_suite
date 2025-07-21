#!/bin/bash

# liteeth_udp_stream_rgmii
echo "Setting up liteeth_udp_stream_rgmii..."
rm -rf build
python ../repo/liteeth/gen.py ../repo/examples/udp_s7phyrgmii.yml
cp build/gateware/liteeth_core.v ../liteeth_udp_stream_rgmii.v
mkdir -p ../builds
cp -r build ../builds/udp_stream_rgmii_build

sed -i 's/^module liteeth_core (/module liteeth_udp_stream_rgmii (/' ../liteeth_udp_stream_rgmii.v

sed -i 's/PLLE2_ADV #(/PLLE2_DUMMY #(/g' ../liteeth_udp_stream_rgmii.v

# Replace Storage 3 (12-bit x 128-word) - ICMP payload FIFO
sed -i '/\/\/ Memory storage_3: 128-words x 12-bit/,/assign icmp_echo_payload_fifo_rdport_dat_r = storage_3_dat1;/c\
\/\/ Memory storage_3: 128-words x 12-bit\
\/\/------------------------------------------------------------------------------\
\/\/ Port 0 | Read: Sync  | Write: Sync | Mode: Read-First | Write-Granularity: 12 \
\/\/ Port 1 | Read: Sync | Write: ---- | \
liteeth_1rw1r_12w128d_sram u_storage_12w128d_0 (\
`ifdef USE_POWER_PINS\
    .vdd(vdd),\
    .gnd(gnd),\
`endif\
    \/\/ Port 0: RW\
    .clk0(sys_clk),\
    .csb0(1'"'"'b0),\
    .web0(~icmp_echo_payload_fifo_wrport_we),\
    .addr0(icmp_echo_payload_fifo_wrport_adr),\
    .din0(icmp_echo_payload_fifo_wrport_dat_w),\
    .dout0(icmp_echo_payload_fifo_wrport_dat_r),\
    \/\/ Port 1: R\
    .clk1(sys_clk),\
    .csb1(~icmp_echo_payload_fifo_rdport_re),\
    .addr1(icmp_echo_payload_fifo_rdport_adr),\
    .dout1(icmp_echo_payload_fifo_rdport_dat_r)\
);' ../liteeth_udp_stream_rgmii.v

# Replace Storage 5 (64-bit x 64-word) - UDP Streamer 0 TX FIFO
sed -i '/\/\/ Memory storage_5: 64-words x 34-bit/,/assign liteethudpstreamer0_tx_fifo_rdport_dat_r = storage_5_dat1;/c\
\/\/ Memory storage_5: 64-words x 64-bit\
\/\/------------------------------------------------------------------------------\
\/\/ Port 0 | Read: Sync  | Write: Sync | Mode: Read-First | Write-Granularity: 64 \
\/\/ Port 1 | Read: Sync | Write: ---- | \
wire [63:0] storage_5_dat0;\
wire [63:0] storage_5_dat1;\
liteeth_1rw1r_64w64d_sram u_tx_buffer_64w64d_0 (\
`ifdef USE_POWER_PINS\
    .vdd(vdd),\
    .gnd(gnd),\
`endif\
    \/\/ Port 0: RW\
    .clk0(sys_clk),\
    .csb0(1'"'"'b0),\
    .web0(~liteethudpstreamer0_tx_fifo_wrport_we),\
    .addr0(liteethudpstreamer0_tx_fifo_wrport_adr),\
    .din0({30'"'"'b0, liteethudpstreamer0_tx_fifo_wrport_dat_w}),\
    .dout0(storage_5_dat0),\
    \/\/ Port 1: R\
    .clk1(sys_clk),\
    .csb1(~liteethudpstreamer0_tx_fifo_rdport_re),\
    .addr1(liteethudpstreamer0_tx_fifo_rdport_adr),\
    .dout1(storage_5_dat1)\
);\
assign liteethudpstreamer0_tx_fifo_wrport_dat_r = storage_5_dat0[33:0];\
assign liteethudpstreamer0_tx_fifo_rdport_dat_r = storage_5_dat1[33:0];' ../liteeth_udp_stream_rgmii.v

# Replace Storage 6 (64-bit x 64-word) - UDP Streamer 0 RX FIFO  
sed -i '/\/\/ Memory storage_6: 64-words x 35-bit/,/assign liteethudpstreamer0_rx_fifo_rdport_dat_r = storage_6_dat1;/c\
\/\/ Memory storage_6: 64-words x 64-bit\
\/\/------------------------------------------------------------------------------\
\/\/ Port 0 | Read: Sync  | Write: Sync | Mode: Read-First | Write-Granularity: 64 \
\/\/ Port 1 | Read: Sync | Write: ---- | \
wire [63:0] storage_6_dat0;\
wire [63:0] storage_6_dat1;\
liteeth_1rw1r_64w64d_sram u_rx_buffer_64w64d_0 (\
`ifdef USE_POWER_PINS\
    .vdd(vdd),\
    .gnd(gnd),\
`endif\
    \/\/ Port 0: RW\
    .clk0(sys_clk),\
    .csb0(1'"'"'b0),\
    .web0(~liteethudpstreamer0_rx_fifo_wrport_we),\
    .addr0(liteethudpstreamer0_rx_fifo_wrport_adr),\
    .din0({29'"'"'b0, liteethudpstreamer0_rx_fifo_wrport_dat_w}),\
    .dout0(storage_6_dat0),\
    \/\/ Port 1: R\
    .clk1(sys_clk),\
    .csb1(~liteethudpstreamer0_rx_fifo_rdport_re),\
    .addr1(liteethudpstreamer0_rx_fifo_rdport_adr),\
    .dout1(storage_6_dat1)\
);\
assign liteethudpstreamer0_rx_fifo_wrport_dat_r = storage_6_dat0[34:0];\
assign liteethudpstreamer0_rx_fifo_rdport_dat_r = storage_6_dat1[34:0];' ../liteeth_udp_stream_rgmii.v

# Replace Storage 7 (64-bit x 64-word) - UDP Streamer 1 TX FIFO
sed -i '/\/\/ Memory storage_7: 64-words x 34-bit/,/assign liteethudpstreamer1_tx_fifo_rdport_dat_r = storage_7_dat1;/c\
\/\/ Memory storage_7: 64-words x 64-bit\
\/\/------------------------------------------------------------------------------\
\/\/ Port 0 | Read: Sync  | Write: Sync | Mode: Read-First | Write-Granularity: 64 \
\/\/ Port 1 | Read: Sync | Write: ---- | \
wire [63:0] storage_7_dat0;\
wire [63:0] storage_7_dat1;\
liteeth_1rw1r_64w64d_sram u_tx_buffer_64w64d_1 (\
`ifdef USE_POWER_PINS\
    .vdd(vdd),\
    .gnd(gnd),\
`endif\
    \/\/ Port 0: RW\
    .clk0(sys_clk),\
    .csb0(1'"'"'b0),\
    .web0(~liteethudpstreamer1_tx_fifo_wrport_we),\
    .addr0(liteethudpstreamer1_tx_fifo_wrport_adr),\
    .din0({30'"'"'b0, liteethudpstreamer1_tx_fifo_wrport_dat_w}),\
    .dout0(storage_7_dat0),\
    \/\/ Port 1: R\
    .clk1(sys_clk),\
    .csb1(~liteethudpstreamer1_tx_fifo_rdport_re),\
    .addr1(liteethudpstreamer1_tx_fifo_rdport_adr),\
    .dout1(storage_7_dat1)\
);\
assign liteethudpstreamer1_tx_fifo_wrport_dat_r = storage_7_dat0[33:0];\
assign liteethudpstreamer1_tx_fifo_rdport_dat_r = storage_7_dat1[33:0];' ../liteeth_udp_stream_rgmii.v

# Replace Storage 8 (64-bit x 64-word) - UDP Streamer 1 RX FIFO
sed -i '/\/\/ Memory storage_8: 64-words x 35-bit/,/assign liteethudpstreamer1_rx_fifo_rdport_dat_r = storage_8_dat1;/c\
\/\/ Memory storage_8: 64-words x 64-bit\
\/\/------------------------------------------------------------------------------\
\/\/ Port 0 | Read: Sync  | Write: Sync | Mode: Read-First | Write-Granularity: 64 \
\/\/ Port 1 | Read: Sync | Write: ---- | \
wire [63:0] storage_8_dat0;\
wire [63:0] storage_8_dat1;\
liteeth_1rw1r_64w64d_sram u_rx_buffer_64w64d_1 (\
`ifdef USE_POWER_PINS\
    .vdd(vdd),\
    .gnd(gnd),\
`endif\
    \/\/ Port 0: RW\
    .clk0(sys_clk),\
    .csb0(1'"'"'b0),\
    .web0(~liteethudpstreamer1_rx_fifo_wrport_we),\
    .addr0(liteethudpstreamer1_rx_fifo_wrport_adr),\
    .din0({29'"'"'b0, liteethudpstreamer1_rx_fifo_wrport_dat_w}),\
    .dout0(storage_8_dat0),\
    \/\/ Port 1: R\
    .clk1(sys_clk),\
    .csb1(~liteethudpstreamer1_rx_fifo_rdport_re),\
    .addr1(liteethudpstreamer1_rx_fifo_rdport_adr),\
    .dout1(storage_8_dat1)\
);\
assign liteethudpstreamer1_rx_fifo_wrport_dat_r = storage_8_dat0[34:0];\
assign liteethudpstreamer1_rx_fifo_rdport_dat_r = storage_8_dat1[34:0];' ../liteeth_udp_stream_rgmii.v

echo "SRAM macro replacement completed successfully!"
