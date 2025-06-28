# Generated MAC Core by LitEx
A synthesizable Ethernet MAC (Media Access Control) core derived from the LiteEth project, specifically modified for ASIC implementation using the OpenROAD flow scripts.

## Notes
- **4 Packet Buffer Memories**: 383×32-bit each (384x32)
- **Total Memory**: ~49 KB
- **Core Size**: 655×655

### SDC
- **System Clock**: 100 MHz (Explicit from generated xdc code)

## What's changed
### FDPE instance

(FPGA focused -> Synthesizable target for ORFS)

The original LiteEth core used Xilinx FPGA-specific `FDPE` instances for reset synchronizers. These have been replaced with behaviorally equivalent Verilog code:

```verilog
// Original FPGA primitive:
FDPE #(.INIT(1'b1)) FDPE (.C(clk), .PRE(reset), .D(data), .Q(output), .CE(1'b1));

// ASIC-compatible replacement:
reg output;
always @(posedge clk or posedge reset) begin
    if (reset)
        output <= 1'b1;  // Preset behavior
    else
        output <= data;   // Normal operation
end
```

### SRAM Macros
Generated from FakeRAM

Added memory macros for ASIC implementation:

- **32×384 SRAM macros** with both 8-bit and 32-bit write granularity options
- **32×42 SRAM macros** for smaller memory requirements

These macros replace the original memory inference to provide better control over memory implementation in the ASIC flow.

### XDC to SDC

The LiteEth generator produces XDC files with FPGA-specific constraints so had to change to create a ASIC-compatible SDC file.
