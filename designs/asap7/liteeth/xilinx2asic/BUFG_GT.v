///////////////////////////////////////////////////////////////////////////////
//     Copyright (c) 1995/2019 Xilinx, Inc.
// 
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
// 
//        http://www.apache.org/licenses/LICENSE-2.0
// 
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /     Vendor      : Xilinx
// \   \   \/      Version     : 2020.1
//  \   \          Description : Xilinx Unified Simulation Library Component
//  /   /                        BUFG_GT
// /___/   /\      Filename    : BUFG_GT.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//    10/13/25 - ASIC synthesizable.
//
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

module BUFG_GT
(
    input        CE,
    input        CEMASK,
    input        CLR,
    input        CLRMASK,
    input [2:0]  DIV,
    input        I,
    output       O
);

    wire ce_active, clr_active;
    wire clk_enabled, clk_divided;
    reg [2:0] div_counter;
    reg clk_div_reg;
    
    assign ce_active = CEMASK ? ~CE : CE;
    assign clr_active = CLRMASK ? ~CLR : CLR;
    
    wire [2:0] div_value = DIV + 3'b001;
    
    always @(posedge I or posedge clr_active) begin
        if (clr_active) begin
            div_counter <= 3'b000;
            clk_div_reg <= 1'b0;
        end else begin
            if (div_value == 3'b001) begin
                clk_div_reg <= 1'b1;
            end else begin
                if (div_counter == (div_value - 1)) begin
                    div_counter <= 3'b000;
                    clk_div_reg <= ~clk_div_reg;
                end else begin
                    div_counter <= div_counter + 1'b1;
                end
            end
        end
    end
    assign clk_divided = (div_value == 3'b001) ? I : clk_div_reg;
    
    wire clk_gated;

    AND2x2_ASAP7_75t_R clk_and_gate (
        .A(clk_divided),
        .B(1'b1),
        .Y(clk_gated)
    );
    
    wire clk_final;
    assign clk_final = clr_active ? 1'b0 : clk_gated;
    

    BUFx2_ASAP7_75t_R  clk_buf0 (.A(clk_final), .Y(O));
    // BUFx3_ASAP7_75t_R  clk_buf0 (.A(clk_final), .Y(O));
    // BUFx4_ASAP7_75t_R  clk_buf0 (.A(clk_final), .Y(O));

endmodule
