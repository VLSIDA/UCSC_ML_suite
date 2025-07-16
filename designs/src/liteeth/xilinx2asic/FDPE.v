module FDPE #(
    parameter INIT = 1'b1
)(
    input  wire C,      // Clock
    input  wire PRE,    // Asynchronous preset (active high)
    input  wire CE,     // Clock enable
    input  wire D,      // Data input
    output reg  Q       // Output
);

    // Initialize Q to INIT
    initial Q = INIT;

    always @(posedge C or posedge PRE) begin
        if (PRE)
            Q <= 1'b1;
        else if (CE)
            Q <= D;             // Clocked assignment when CE is high
    end

endmodule
