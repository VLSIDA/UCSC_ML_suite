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
endmodule
