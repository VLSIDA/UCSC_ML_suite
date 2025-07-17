module lfsr_top (
    input wire clk,
    input wire rst,
    input wire [7:0] data_in,
    output wire [7:0] data_out
);

parameter LFSR_WIDTH = 31;

reg [LFSR_WIDTH-1:0] lfsr_state_reg = 0;
wire [LFSR_WIDTH-1:0] lfsr_state_next;

lfsr #(
    .LFSR_WIDTH(LFSR_WIDTH),
    .LFSR_POLY(31'h10000001),
    .LFSR_CONFIG("FIBONACCI"),
    .DATA_WIDTH(8)
) lfsr_inst (
    .data_in(data_in),
    .state_in(lfsr_state_reg),
    .data_out(data_out),
    .state_out(lfsr_state_next)
);

always @(posedge clk or posedge rst) begin
    if (rst)
        lfsr_state_reg <= {LFSR_WIDTH{1'b1}};
    else
        lfsr_state_reg <= lfsr_state_next;
end

endmodule
