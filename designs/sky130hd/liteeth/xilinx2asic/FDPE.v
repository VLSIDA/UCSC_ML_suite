///////////////////////////////////////////////////////////////////////////////
//    Copyright (c) 1995/2016 Xilinx, Inc.
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
// \   \   \/     Version : 2017.1
//  \   \         Description : Xilinx Unified Simulation Library Component
//  /   /                  D Flip-Flop with Clock Enable and Asynchronous Preset
// /___/   /\     Filename : FDPE.v
// \   \  /  \
//  \___\/\___\
//
// Revision:
//    08/25/10 - Initial version.
//    10/20/10 - remove unused pin line from table.
//    11/01/11 - Disable timing check when set reset active (CR632017)
//    12/08/11 - add MSGON and XON attributes (CR636891)
//    01/16/12 - 640813 - add MSGON and XON functionality
//    04/16/13 - PR683925 - add invertible pin support.
//    10/13/25 - ASIC synthesizable.
// End Revision
///////////////////////////////////////////////////////////////////////////////

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
