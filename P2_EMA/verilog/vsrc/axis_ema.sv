`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2020 05:46:53 AM
// Design Name: 
// Module Name: axis_ema
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


module axis_ema_sv(
    input           ACLK,
    input           ARESETN,

    input [31:0]    S_AXIS_TDATA,
    input [3:0]     S_AXIS_TKEEP,
    input           S_AXIS_TLAST,
    input           S_AXIS_TVALID,
    output          S_AXIS_TREADY,

    output [31:0]   M_AXIS_TDATA,
    output [3:0]    M_AXIS_TKEEP,
    output          M_AXIS_TLAST,
    output          M_AXIS_TVALID,
    input           M_AXIS_TREADY

    );

    reg [31:0] old_y;
    reg [31:0] new_y;
    
    always_ff @(posedge ACLK) begin
        
        if (~ARESETN) begin
            old_y <= 1000;
        end
        else if (S_AXIS_TVALID && M_AXIS_TREADY) begin
            old_y <= new_y;
        end
        
    end
    
    always_comb begin   
        new_y = (S_AXIS_TDATA>>2) + (old_y>>2) + (old_y>>1);
    end 
    //Update me!  By default this does nothing!   
    assign M_AXIS_TDATA = new_y; 

    assign M_AXIS_TKEEP = S_AXIS_TKEEP;
    assign M_AXIS_TLAST = S_AXIS_TLAST;
    assign M_AXIS_TVALID = S_AXIS_TVALID; 
    assign S_AXIS_TREADY = M_AXIS_TREADY;   
        
            
endmodule
