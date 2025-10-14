///////////////////////////////////////////////////////////////////////////////
//    Copyright (c) 1995/2005 Xilinx, Inc.
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
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 10.1
//  \   \         Description : Xilinx Unified Simulation Library Component
//  /   /                  Dual Data Rate Output D Flip-Flop
// /___/   /\     Filename : ODDR.v
// \   \  /  \    
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Added LOC parameter, removed GSR ports and initialized outputs.
//    05/29/07 - Added wire declaration for internal signals
//    04/17/08 - CR 468871 Negative SetupHold fix
//    05/12/08 - CR 455447 add XON MSGON property to support async reg
//    12/03/08 - CR 498674 added pulldown on R/S.
//    07/28/09 - CR 527698 According to holistic, CE has to be high for both rise/fall CLK
//             - If CE is low on the rising edge, it has an effect of no change in the falling CLK.
//    06/23/10 - CR 566394 Removed extra recrem checks
//    12/13/11 - Added `celldefine and `endcelldefine (CR 524859).
//    04/13/12 - CR 591320 fixed SU/H checks in OPPOSITE edge mode.
//    10/22/14 - Added #1 to $finish (CR 808642).
//    10/13/25 - ASIC synthesizable.
// End Revision
///////////////////////////////////////////////////////////////////////////////

module ODDR #(
    parameter DDR_CLK_EDGE = "OPPOSITE_EDGE",
    parameter INIT = 1'b0,
    parameter SRTYPE = "SYNC"
)(
    input  wire C,
    input  wire CE,     
    input  wire D1,
    input  wire D2,
    input  wire R,
    input  wire S,
    output reg  Q       
);

    reg d1_reg;
    reg d2_reg;
    reg clk_toggle;

    initial begin
        d1_reg = INIT;
        d2_reg = INIT;
        Q = INIT;
        clk_toggle = 1'b0;
    end

    generate
        if (DDR_CLK_EDGE == "OPPOSITE_EDGE") begin
            
            if (SRTYPE == "ASYNC") begin
                always @(posedge C or posedge R) begin
                    if (R)
                        clk_toggle <= 1'b0;
                    else if (CE)
                        clk_toggle <= ~clk_toggle;
                end
                
                always @(posedge C or posedge S or posedge R) begin
                    if (R)
                        d1_reg <= 1'b0;
                    else if (S)
                        d1_reg <= 1'b1;
                    else if (CE)
                        d1_reg <= D1;
                end
                
                always @(posedge C or posedge S or posedge R) begin
                    if (R)
                        d2_reg <= 1'b0;
                    else if (S)
                        d2_reg <= 1'b1;
                    else if (CE && clk_toggle)
                        d2_reg <= D2;
                end
                
                always @(posedge C or posedge S or posedge R) begin
                    if (R)
                        Q <= 1'b0;
                    else if (S)
                        Q <= 1'b1;
                    else if (CE) begin
                        if (clk_toggle)
                            Q <= d2_reg;
                        else
                            Q <= d1_reg;
                    end
                end
                
            end else begin
                always @(posedge C) begin
                    if (R)
                        clk_toggle <= 1'b0;
                    else if (CE)
                        clk_toggle <= ~clk_toggle;
                end
                
                always @(posedge C) begin
                    if (R)
                        d1_reg <= 1'b0;
                    else if (S)
                        d1_reg <= 1'b1;
                    else if (CE)
                        d1_reg <= D1;
                end
                
                always @(posedge C) begin
                    if (R)
                        d2_reg <= 1'b0;
                    else if (S)
                        d2_reg <= 1'b1;
                    else if (CE && clk_toggle)
                        d2_reg <= D2;
                end
                
                always @(posedge C) begin
                    if (R)
                        Q <= 1'b0;
                    else if (S)
                        Q <= 1'b1;
                    else if (CE) begin
                        if (clk_toggle)
                            Q <= d2_reg;
                        else
                            Q <= d1_reg;
                    end
                end
            end
            
        end else begin        
            if (SRTYPE == "ASYNC") begin
                always @(posedge C or posedge S or posedge R) begin
                    if (R) begin
                        d1_reg <= 1'b0;
                        d2_reg <= 1'b0;
                        Q <= 1'b0;
                        clk_toggle <= 1'b0;
                    end else if (S) begin
                        d1_reg <= 1'b1;
                        d2_reg <= 1'b1;
                        Q <= 1'b1;
                    end else if (CE) begin
                        d1_reg <= D1;
                        d2_reg <= D2;
                        clk_toggle <= ~clk_toggle;
                        Q <= clk_toggle ? D2 : D1;
                    end
                end
                
            end else begin
                always @(posedge C) begin
                    if (R) begin
                        d1_reg <= 1'b0;
                        d2_reg <= 1'b0;
                        Q <= 1'b0;
                        clk_toggle <= 1'b0;
                    end else if (S) begin
                        d1_reg <= 1'b1;
                        d2_reg <= 1'b1;
                        Q <= 1'b1;
                    end else if (CE) begin
                        d1_reg <= D1;
                        d2_reg <= D2;
                        clk_toggle <= ~clk_toggle;
                        Q <= clk_toggle ? D2 : D1;
                    end
                end
            end
        end
    endgenerate

endmodule
