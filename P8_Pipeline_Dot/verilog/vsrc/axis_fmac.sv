`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2021 08:16:44 PM
// Design Name: 
// Module Name: axis_fmac
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module axis_fmac(
        input           clk, 

        input [31:0]    A_TDATA,
        input           A_TVALID,

        input [31:0]    B_TDATA,
        input           B_TVALID,

        input [31:0]    C_TDATA,
        input           C_TVALID,

        output [31:0]   OUT_TDATA,
        output          OUT_TVALID
    );
    

bd_fmac_wrapper bd_fmac(
    .aclk_0 (clk),

    .S_AXIS_A_0_tdata(A_TDATA),
    .S_AXIS_A_0_tvalid(A_TVALID), 
    .S_AXIS_B_0_tdata(B_TDATA),
    .S_AXIS_B_0_tvalid(B_TVALID),
    .S_AXIS_C_0_tdata(C_TDATA),
    .S_AXIS_C_0_tvalid(C_TVALID), 
    
    .M_AXIS_RESULT_0_tdata(OUT_TDATA),
    .M_AXIS_RESULT_0_tvalid(OUT_TVALID)
    );

endmodule
