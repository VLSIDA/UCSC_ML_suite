module sram_1r1w_1x256 (
	clk,
	read_en,
	read_addr,
	read_data,
	write_en,
	write_addr,
	write_data
);
	parameter DATA_WIDTH = 1;
	parameter SIZE = 256;
	parameter READ_DURING_WRITE = "NEW_DATA";
	parameter ADDR_WIDTH = $clog2(SIZE);
	input clk;
	input read_en;
	input [ADDR_WIDTH - 1:0] read_addr;
	output reg [DATA_WIDTH - 1:0] read_data;
	input write_en;
	input [ADDR_WIDTH - 1:0] write_addr;
	input [DATA_WIDTH - 1:0] write_data;
	sram_1x256_1r1w sram (
		.clk       (clk),
		.rd_out_r1 (read_data),
		.addr_r1   (read_addr),
		.addr_w1   (write_addr),
		.we_in_w1  (write_en),
		.wd_in_w1  (write_data),
   		.ce_r1 	   (1'b1),
   		.ce_w1	   (1'b1)
	);
endmodule
module sram_1r1w_16x52 (
	clk,
	read_en,
	read_addr,
	read_data,
	write_en,
	write_addr,
	write_data
);
	parameter DATA_WIDTH = 16;
	parameter SIZE = 52;
	parameter READ_DURING_WRITE = "NEW_DATA";
	parameter ADDR_WIDTH = $clog2(SIZE);
	input clk;
	input read_en;
	input [ADDR_WIDTH - 1:0] read_addr;
	output reg [DATA_WIDTH - 1:0] read_data;
	input write_en;
	input [ADDR_WIDTH - 1:0] write_addr;
	input [DATA_WIDTH - 1:0] write_data;
	sram_16x52_1r1w sram (
		.clk       (clk),
		.rd_out_r1 (read_data),
		.addr_r1   (read_addr),
		.addr_w1   (write_addr),
		.we_in_w1  (write_en),
		.wd_in_w1  (write_data),
   		.ce_r1 	   (1'b1),
   		.ce_w1	   (1'b1)
	);
endmodule
module sram_1r1w_20x64 (
	clk,
	read_en,
	read_addr,
	read_data,
	write_en,
	write_addr,
	write_data
);
	parameter DATA_WIDTH = 20;
	parameter SIZE = 64;
	parameter READ_DURING_WRITE = "NEW_DATA";
	parameter ADDR_WIDTH = $clog2(SIZE);
	input clk;
	input read_en;
	input [ADDR_WIDTH - 1:0] read_addr;
	output reg [DATA_WIDTH - 1:0] read_data;
	input write_en;
	input [ADDR_WIDTH - 1:0] write_addr;
	input [DATA_WIDTH - 1:0] write_data;
	sram_20x64_1r1w sram (
		.clk       (clk),
		.rd_out_r1 (read_data),
		.addr_r1   (read_addr),
		.addr_w1   (write_addr),
		.we_in_w1  (write_en),
		.wd_in_w1  (write_data),
   		.ce_r1 	   (1'b1),
   		.ce_w1	   (1'b1)
	);
endmodule
module sram_1r1w_512x256 (
	clk,
	read_en,
	read_addr,
	read_data,
	write_en,
	write_addr,
	write_data
);
	parameter DATA_WIDTH = 512;
	parameter SIZE = 256;
	parameter READ_DURING_WRITE = "NEW_DATA";
	parameter ADDR_WIDTH = $clog2(SIZE);
	input clk;
	input read_en;
	input [ADDR_WIDTH - 1:0] read_addr;
	output reg [DATA_WIDTH - 1:0] read_data;
	input write_en;
	input [ADDR_WIDTH - 1:0] write_addr;
	input [DATA_WIDTH - 1:0] write_data;
	sram_512x256_1r1w sram (
		.clk       (clk),
		.rd_out_r1 (read_data),
		.addr_r1   (read_addr),
		.addr_w1   (write_addr),
		.we_in_w1  (write_en),
		.wd_in_w1  (write_data),
   		.ce_r1 	   (1'b1),
   		.ce_w1	   (1'b1)
	);
endmodule
module sram_1r1w_3x1 (
	clk,
	read_en,
	read_addr,
	read_data,
	write_en,
	write_addr,
	write_data
);
	parameter DATA_WIDTH = 3;
	parameter SIZE = 64;
	parameter READ_DURING_WRITE = "NEW_DATA";
	parameter ADDR_WIDTH = $clog2(SIZE);
	input clk;
	input read_en;
	input [ADDR_WIDTH - 1:0] read_addr;
	output reg [DATA_WIDTH - 1:0] read_data;
	input write_en;
	input [ADDR_WIDTH - 1:0] write_addr;
	input [DATA_WIDTH - 1:0] write_data;
	sram_3x1_1r1w sram (
		.clk       (clk),
		.rd_out_r1 (read_data),
		.addr_r1   (read_addr),
		.addr_w1   (write_addr),
		.we_in_w1  (write_en),
		.wd_in_w1  (write_data),
   		.ce_r1 	   (1'b1),
   		.ce_w1	   (1'b1)
	);
endmodule
module sram_1r1w_512x1024 (
	clk,
	read_en,
	read_addr,
	read_data,
	write_en,
	write_addr,
	write_data
);
	parameter DATA_WIDTH = 512;
	parameter SIZE = 1024;
	parameter READ_DURING_WRITE = "NEW_DATA";
	parameter ADDR_WIDTH = $clog2(SIZE);
	input clk;
	input read_en;
	input [ADDR_WIDTH - 1:0] read_addr;
	output reg [DATA_WIDTH - 1:0] read_data;
	input write_en;
	input [ADDR_WIDTH - 1:0] write_addr;
	input [DATA_WIDTH - 1:0] write_data;
	sram_512x1024_1r1w sram (
		.clk       (clk),
		.rd_out_r1 (read_data),
		.addr_r1   (read_addr),
		.addr_w1   (write_addr),
		.we_in_w1  (write_en),
		.wd_in_w1  (write_data),
   		.ce_r1 	   (1'b1),
   		.ce_w1	   (1'b1)
	);
endmodule
module sram_1r1w_512x2048 (
	clk,
	read_en,
	read_addr,
	read_data,
	write_en,
	write_addr,
	write_data
);
	parameter DATA_WIDTH = 512;
	parameter SIZE = 2048;
	parameter READ_DURING_WRITE = "NEW_DATA";
	parameter ADDR_WIDTH = $clog2(SIZE);
	input clk;
	input read_en;
	input [ADDR_WIDTH - 1:0] read_addr;
	output reg [DATA_WIDTH - 1:0] read_data;
	input write_en;
	input [ADDR_WIDTH - 1:0] write_addr;
	input [DATA_WIDTH - 1:0] write_data;
	sram_512x2048_1r1w sram (
		.clk       (clk),
		.rd_out_r1 (read_data),
		.addr_r1   (read_addr),
		.addr_w1   (write_addr),
		.we_in_w1  (write_en),
		.wd_in_w1  (write_data),
   		.ce_r1 	   (1'b1),
   		.ce_w1	   (1'b1)
	);
endmodule
module sram_2r1w_20x64 (
	clk,
	read1_en,
	read1_addr,
	read1_data,
	read2_en,
	read2_addr,
	read2_data,
	write_en,
	write_addr,
	write_data
);
	parameter DATA_WIDTH = 20;
	parameter SIZE = 64;
	parameter READ_DURING_WRITE = "NEW_DATA";
	parameter ADDR_WIDTH = $clog2(SIZE);
	input clk;
	input read1_en;
	input [ADDR_WIDTH - 1:0] read1_addr;
	output reg [DATA_WIDTH - 1:0] read1_data;
	input read2_en;
	input [ADDR_WIDTH - 1:0] read2_addr;
	output reg [DATA_WIDTH - 1:0] read2_data;
	input write_en;
	input [ADDR_WIDTH - 1:0] write_addr;
	input [DATA_WIDTH - 1:0] write_data;
	sram_20x64_2r1w sram (
		.clk        (clk),
		.ce_r1      (read1_en),
		.addr_r1    (read1_addr),
		.rd_out_r1  (read1_data),
		.ce_r2      (read2_en),
		.addr_r2    (read2_addr),
		.rd_out_r2  (read2_data),
		.ce_w1      (write_en),
		.addr_w1    (write_addr),
		.wd_in_w1   (write_data)
	);
endmodule
module sram_2r1w_32x128 (
	clk,
	read1_en,
	read1_addr,
	read1_data,
	read2_en,
	read2_addr,
	read2_data,
	write_en,
	write_addr,
	write_data
);
	parameter DATA_WIDTH = 32;
	parameter SIZE = 128;
	parameter READ_DURING_WRITE = "NEW_DATA";
	parameter ADDR_WIDTH = $clog2(SIZE);
	input clk;
	input read1_en;
	input [ADDR_WIDTH - 1:0] read1_addr;
	output reg [DATA_WIDTH - 1:0] read1_data;
	input read2_en;
	input [ADDR_WIDTH - 1:0] read2_addr;
	output reg [DATA_WIDTH - 1:0] read2_data;
	input write_en;
	input [ADDR_WIDTH - 1:0] write_addr;
	input [DATA_WIDTH - 1:0] write_data;
	sram_32x128_2r1w sram (
		.clk        (clk),
		.ce_r1      (read1_en),
		.addr_r1    (read1_addr),
		.rd_out_r1  (read1_data),
		.ce_r2      (read2_en),
		.addr_r2    (read2_addr),
		.rd_out_r2  (read2_data),
		.ce_w1      (write_en),
		.addr_w1    (write_addr),
		.wd_in_w1   (write_data)
	);
endmodule