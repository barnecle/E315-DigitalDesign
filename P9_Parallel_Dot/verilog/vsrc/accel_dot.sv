`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
// Created for Indiana University's E315 Class
//
// 
// Andrew Lukefahr
// lukefahr@iu.edu
//
// 2021-03-24
// 2020-02-25
//
//////////////////////////////////////////////////////////////////////////////////

module accel_dot #(   

    parameter ROWS = 3,
    parameter COLS = 4
     
    )(

    input clk, 
    input rst, 

    // Incomming Matrix AXI4-Stream
    input [31:0]                    INPUT_AXIS_TDATA,
    input                           INPUT_AXIS_TLAST,
    input                           INPUT_AXIS_TVALID,
    output logic                    INPUT_AXIS_TREADY,

    //the weight matrix
    input logic [31:0]               weights [0:ROWS-1] [0:COLS-1],
    
    // Outgoing Vector AXI4-Stream 		
    output logic [31:0]             OUTPUT_AXIS_TDATA,
    output logic                    OUTPUT_AXIS_TLAST,
    output logic                    OUTPUT_AXIS_TVALID,
    input                           OUTPUT_AXIS_TREADY

    );  

    //assumes even number of COLUMNS
    if (( COLS % 2) != 0)
        $error("COLS must be even"); 
    
    genvar i;
//    if ((COLS%4) == 0) begin
//        wire [31:0] weights0 [0:ROWS-1][0 :+ COLS/4-1];
//        wire [31:0] weights1 [0:ROWS-1][0 :+ COLS/4-1];
//        wire [31:0] weights2 [0:ROWS-1][0 :+ COLS/4-1];
//        wire [31:0] weights3 [0:ROWS-1][0 :+ COLS/4-1];
//        for (i = 0; i < ROWS; ++i) begin
//            assign weights0[i] = weights[i][0       : COLS/4-1  ];
//            assign weights1[i] = weights[i][COLS/4  : ((COLS/4)*2-1)   ];
//            assign weights2[i] = weights[i][(COLS/4)*2       : (COLS/4)*3-1  ];
//            assign weights3[i] = weights[i][(COLS/4)*3  : COLS-1    ];
//        end
        
//        dot #(
//        .ROWS(ROWS),
//        .COLS((COLS/2))
        
//        ) dot0 (
    
//		// AXI4-Stream Interface
//		.clk(clk),
//		.rst(rst),
		
//		.MATRIX_NUM(4),
//		.weights0(weights0),
//		.weights1(weights1),
//		.weights2(weights2),
//		.weights3(weights3),
		
//        .INPUT_AXIS_TDATA(INPUT_AXIS_TDATA),
//        .INPUT_AXIS_TLAST(INPUT_AXIS_TLAST),
//        .INPUT_AXIS_TVALID(INPUT_AXIS_TVALID),
//        .INPUT_AXIS_TREADY(INPUT_AXIS_TREADY),
                            
//        .OUTPUT_AXIS_TDATA(OUTPUT_AXIS_TDATA),
//        .OUTPUT_AXIS_TLAST(OUTPUT_AXIS_TLAST),
//        .OUTPUT_AXIS_TVALID(OUTPUT_AXIS_TVALID),
//        .OUTPUT_AXIS_TREADY(OUTPUT_AXIS_TREADY) 	

//        );
//    end else begin
        wire [31:0] weights0 [0:ROWS-1][0 :+ COLS/2-1];
        wire [31:0] weights1 [0:ROWS-1][0 :+ COLS/2-1];
        for (i = 0; i < ROWS; ++i) begin
            assign weights0[i] = weights[i][0       : COLS/2-1  ];
            assign weights1[i] = weights[i][COLS/2  : COLS-1    ];
        end
        
        dot #(
        .ROWS(ROWS),
        .COLS((COLS/2))
        
        ) dot0 (
    
		// AXI4-Stream Interface
		  .clk(clk),
		  .rst(rst),
		
//		  .MATRIX_NUM(2),
		  .weights0(weights0),
		  .weights1(weights1),
		
          .INPUT_AXIS_TDATA(INPUT_AXIS_TDATA),
          .INPUT_AXIS_TLAST(INPUT_AXIS_TLAST),
          .INPUT_AXIS_TVALID(INPUT_AXIS_TVALID),
          .INPUT_AXIS_TREADY(INPUT_AXIS_TREADY),
                            
          .OUTPUT_AXIS_TDATA(OUTPUT_AXIS_TDATA),
          .OUTPUT_AXIS_TLAST(OUTPUT_AXIS_TLAST),
          .OUTPUT_AXIS_TVALID(OUTPUT_AXIS_TVALID),
          .OUTPUT_AXIS_TREADY(OUTPUT_AXIS_TREADY) 	

        );
//    end
    //if you want to cut the weights in half vertically
    
    
   
    //if you want to cut the weights in half horizontally
    // This does every-other row horizontally
    //genvar i;
    //for (i = 0; i < ROWS/2; ++i) begin
    //    assign weights0[i] = weights[i*2];
    //    assign weights0[i] = weights[i*2+1];
    //end
    
    
    

endmodule

