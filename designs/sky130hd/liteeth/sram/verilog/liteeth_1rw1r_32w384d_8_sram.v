module liteeth_1rw1r_32w384d_8_sram (
    // Port 0: RW (Write/Read Port)
    clk0,
    ce_rw1,
    we_in_rw1,
    w_mask_rw1,
    addr_rw1,
    wd_in_rw1,
    rd_out_rw1,
    // Port 1: R (Read-Only Port)
    clk1,
    ce_r1,
    addr_r1,
    rd_out_r1
);

   parameter BITS = 32;
   parameter WORD_DEPTH = 384;
   parameter ADDR_WIDTH = 9;


   // Port 0: RW
   input                    clk0;
   input                    ce_rw1;
   input                    we_in_rw1;
   input  [BITS-1:0]        w_mask_rw1;
   input  [ADDR_WIDTH-1:0]  addr_rw1;
   input  [BITS-1:0]        wd_in_rw1;
   output [BITS-1:0]        rd_out_rw1;
   
   // Port 1: R
   input                    clk1;
   input                    ce_r1;
   input  [ADDR_WIDTH-1:0]  addr_r1;
   output [BITS-1:0]        rd_out_r1;

   // Memory array
   reg    [BITS-1:0]        mem [0:WORD_DEPTH-1];

   integer i;

   always @(posedge clk0) begin
      if(ce_rw1) 
      begin
         
         if (we_in_rw1)   
         begin
            mem[addr_rw1][39:32] <= (wd_in_rw1[39:32] & w_mask_rw1[39:32]) | (mem[addr_rw1][39:32] & ~w_mask_rw1[39:32]);
         end
         rd_out_rw1 <= mem[addr_rw1];
      end
   end
   
   
   always @(posedge clk1) begin
      if (ce_r1) begin  // Active low chip select
         rd_out_r1 <= mem[addr_r1];
      end
   end
   

   `ifdef SRAM_TIMING
   reg notifier;
   specify
      // Delays from clk to outputs (registered outputs)
      (posedge clk0 *> rd_out_rw1) = (0, 0);
      (posedge clk1 *> rd_out_r1) = (0, 0);

      // Timing checks
      $width     (posedge clk0,              0, 0, notifier);
      $width     (negedge clk0,              0, 0, notifier);
      $period    (posedge clk0,              0,    notifier);
      $width     (posedge clk1,              0, 0, notifier);
      $width     (negedge clk1,              0, 0, notifier);
      $period    (posedge clk1,              0,    notifier);
      $setuphold (posedge clk0, we_in_rw1, 0, 0, notifier);
      $setuphold (posedge clk0, ce_rw1, 0, 0, notifier);
      $setuphold (posedge clk0, addr_rw1, 0, 0, notifier);
      $setuphold (posedge clk0, wd_in1, 0, 0, notifier);
      $setuphold (posedge clk0, w_mask_rw1, 0, 0, notifier);
      $setuphold (posedge clk1, ce_r1, 0, 0, notifier);
      $setuphold (posedge clk1, addr_r1, 0, 0, notifier);

   endspecify
   `endif

endmodule
