# LiteEth Cores

## Quick Start


### Prerequisites
- WSL Ubuntu on Windows 11 (tested)
- Python 3.6+
- Git

### Setup & Generate Cores

Then run:
```bash
make DESIGN_CONFIG=designs/nangate45/liteeth/<DESIGN_NAME>/config.mk

```

This automatically:
1. Creates Python virtual environment
2. Installs LiteX/LiteEth dependencies
3. Generates 5 Ethernet cores with SRAM macros
4. Prepares cores for ASIC synthesis

### Run ASIC Flow
```bash
make DESIGN_CONFIG=designs/nangate45/liteeth/<DESIGN>/config.mk

make DESIGN_CONFIG=designs/nangate45/liteeth/liteeth_mac_axi_mii/config.mk

```

## Generated Cores

- liteeth_mac_axi_mii
- liteeth_mac_wb_mii
- liteeth_udp_stream_sgmii
- liteeth_udp_stream_rgmii
- liteeth_udp_raw_rgmii

#### liteeth_mac_axi_mii
Ethernet MAC core with AXI-Lite CPU interface and MII PHY connection. Provides basic Ethernet MAC functionality at 100 MHz with big-endian data ordering.
- Bus Interface: AXI-Lite for CPU register access
- PHY Interface: MII (Media Independent Interface) for 10/100 Mbps Ethernet

### liteeth_mac_wb_mii
Ethernet MAC core with Wishbone CPU interface and MII PHY connection. Offers similar MAC functionality as AXI variant but uses Wishbone bus protocol.
- Bus Interface: Wishbone for CPU register access
- PHY Interface: MII (Media Independent Interface) for 10/100 Mbps Ethernet

### liteeth_udp_stream_sgmii
Complete UDP/IP stack with SGMII gigabit interface using streaming data mode. Supports DHCP auto-configuration and high-speed serial communication with built-in FIFOs.
- Protocol Stack: Full UDP/IP with DHCP support
- PHY Interface: SGMII (Serial Gigabit Media Independent Interface) for 1000 Mbps

### liteeth_udp_stream_rgmii
UDP/IP stack with RGMII gigabit interface in streaming mode with configurable buffering. Features port-specific UDP endpoints with automatic packet handling and flow control.
- Protocol Stack: UDP/IP with configurable MAC/IP addresses
- PHY Interface: RGMII (Reduced Gigabit Media Independent Interface) for 1000 Mbps

### liteeth_udp_raw_rgmii
Advanced UDP core with RGMII interface providing raw UDP port access without automatic packet filtering. Gives direct control over UDP headers and packet transmission for custom protocols.
- Protocol Stack: Raw UDP mode for full header control
- PHY Interface: RGMII with configurable TX/RX delays and CDC buffering

## What the Setup Does

1. **Environment Setup**: Creates Python venv, installs LiteX/LiteEth
2. **Core Generation**: Uses LiteEth's `gen.py` with predefined YAML configs
3. **ASIC Conversion**: Replaces inferred memory with SRAM macro instances
4. **File Organization**: Places cores in OpenROAD-compatible structure

## Platform Support

Tested on WSL Ubuntu/Windows 11. Should work on any Linux system with Python 3.6+ and standard build tools.
