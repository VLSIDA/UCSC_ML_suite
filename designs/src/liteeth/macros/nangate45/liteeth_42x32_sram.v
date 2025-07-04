module liteeth_42x32_sram (
`ifdef USE_POWER_PINS
    vdd,
    gnd,
`endif
    // Port 0: RW (Write/Read Port)
    clk0,
    csb0,
    web0,
    addr0,
    din0,
    dout0,
    // Port 1: R (Read-Only Port)
    clk1,
    csb1,
    addr1,
    dout1
);

   parameter BITS = 42;
   parameter WORD_DEPTH = 32;
   parameter ADDR_WIDTH = 5;

`ifdef USE_POWER_PINS
   inout vdd;
   inout gnd;
`endif

   // Port 0: RW
   input                    clk0;
   input                    csb0;  // Active low chip select
   input                    web0;  // Active low write enable
   input  [ADDR_WIDTH-1:0]  addr0;
   input  [BITS-1:0]        din0;
   output [BITS-1:0]        dout0;
   
   // Port 1: R
   input                    clk1;
   input                    csb1;  // Active low chip select
   input  [ADDR_WIDTH-1:0]  addr1;
   output [BITS-1:0]        dout1;

   // Memory array
   reg    [BITS-1:0]        mem [0:WORD_DEPTH-1];

   integer i;

// Write mode: read_first
   // Port 0: Read-Write Port with Read-First behavior
   reg [BITS-1:0] dout0_reg;
   
   always @(posedge clk0) begin
      if (!csb0) begin  // Active low chip select
         // Read-first: capture data before potential write
         dout0_reg <= mem[addr0];
         
         if (!web0) begin  // Active low write enable - writing when web0=0
            mem[addr0] <= din0;
         end
      end
   end
   
   // Read-first: output registered old data
   assign dout0 = dout0_reg;

   // Port 1: Read-Only Port
   reg [BITS-1:0] dout1_reg;
   
   always @(posedge clk1) begin
      if (!csb1) begin  // Active low chip select
         dout1_reg <= mem[addr1];
      end
   end
   
   assign dout1 = dout1_reg;

   // X-propagation and debug logic (optional)
   `ifdef SRAM_MONITOR
   always @(posedge clk0) begin
      if (!csb0 && !web0) begin
         $display("%t: %m writing addr0=%h din0=%h", $time, addr0, din0);
      end
   end
   `endif

   // Timing check placeholders
   `ifdef SRAM_TIMING_CHECK
   reg notifier;
   specify
      // Delays from clk to outputs (registered outputs)
      (posedge clk0 *> dout0) = (0, 0);
      (posedge clk1 *> dout1) = (0, 0);

      // Timing checks
      $width     (posedge clk0,              0, 0, notifier);
      $width     (negedge clk0,              0, 0, notifier);
      $period    (posedge clk0,              0,    notifier);
      $width     (posedge clk1,              0, 0, notifier);
      $width     (negedge clk1,              0, 0, notifier);
      $period    (posedge clk1,              0,    notifier);
      $setuphold (posedge clk0, csb0, 0, 0, notifier);
      $setuphold (posedge clk0, web0, 0, 0, notifier);
      $setuphold (posedge clk0, addr0, 0, 0, notifier);
      $setuphold (posedge clk0, din0, 0, 0, notifier);
      $setuphold (posedge clk1, csb1, 0, 0, notifier);
      $setuphold (posedge clk1, addr1, 0, 0, notifier);

   endspecify
   `endif

endmodule
