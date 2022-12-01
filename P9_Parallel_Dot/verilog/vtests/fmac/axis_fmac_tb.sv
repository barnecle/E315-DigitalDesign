`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2021 10:42:49 AM
// Design Name: 
// Module Name: axis_fmac_tb
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


module axis_fmac_tb(

    );
    
    reg clk;
    reg [31:0] A_TDATA, B_TDATA, C_TDATA;
    reg TVALID;
    
    wire [31:0] OUT_TDATA;
    wire        OUT_TVALID;
    
    real OUT;
    
    axis_fmac fmac0(
        .clk,
        .A_TDATA,
        .A_TVALID(TVALID),
        .B_TDATA,
        .B_TVALID(TVALID),
        .C_TDATA,
        .C_TVALID(TVALID),
        .OUT_TDATA,
        .OUT_TVALID
        );
        
    always #10 clk = ~clk;
    
    always_comb OUT = $bitstoshortreal(OUT_TDATA);
    
    initial begin
        clk = 'h0;
        TVALID = 'h0;
        A_TDATA = 'h0;
        B_TDATA = 'h0;
        C_TDATA = 'h0;
    end
    
    task send_data(
        input real A, B, C);
        
        A_TDATA = $shortrealtobits(A);
        B_TDATA = $shortrealtobits(B);
        C_TDATA = $shortrealtobits(C);
        TVALID = 'h1;
        @(negedge clk);
        TVALID = 'h0;
        
    endtask 
    
    initial begin
    
        @(negedge clk);
        
        send_data(0.1, 1.0, 0.0); 
        send_data(0.1, 2.0, 0.0);
        send_data(0.1, 3.0, 0.0);
        send_data(0.1, 4.0, 0.0);  
        repeat (4) @(negedge clk);
        send_data(0.2, 5.0, 0.1);  
        send_data(0.2, 6.0, 0.2);
        send_data(0.2, 7.0, 0.3);
        send_data(0.2, 8.0, 0.4);
        repeat (3) @(negedge clk);
        send_data(0.3, 9.0, 1.1);   
        
        repeat (100) @(negedge clk);
        
        $finish;
    
    end
endmodule
