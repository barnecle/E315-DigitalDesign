`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2021 05:09:42 AM
// Design Name: 
// Module Name: axis_fadd
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


module axis_fadd(

        input           clk, 

        input [31:0]    A_TDATA,
        input           A_TLAST,
        input           A_TVALID,
        output          A_TREADY, 

        input [31:0]    B_TDATA,
        input           B_TLAST,
        input           B_TVALID,
        output          B_TREADY, 

        output [31:0]   OUT_TDATA,
        output          OUT_TLAST,
        output          OUT_TVALID,
        input           OUT_TREADY
    );
    

bd_fadd_wrapper bd_fadd(
    .aclk_0 (clk),

    .S_AXIS_A_0_tdata(A_TDATA),
    .S_AXIS_A_0_tlast(A_TLAST), 
    .S_AXIS_A_0_tvalid(A_TVALID), 
    .S_AXIS_A_0_tready(A_TREADY), 

    .S_AXIS_B_0_tdata(B_TDATA),
    .S_AXIS_B_0_tlast(B_TLAST), 
    .S_AXIS_B_0_tvalid(B_TVALID), 
    .S_AXIS_B_0_tready(B_TREADY), 
    
    .M_AXIS_RESULT_0_tdata(OUT_TDATA),
    .M_AXIS_RESULT_0_tlast(OUT_TLAST),
    .M_AXIS_RESULT_0_tvalid(OUT_TVALID),
    .M_AXIS_RESULT_0_tready(OUT_TREADY)
    );

endmodule

