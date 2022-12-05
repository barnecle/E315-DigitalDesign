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
    
//    assign reg MODNUM = 2;
    logic [31:0]  j, next_j;
    logic [31:0] outbuf [0:1];
    logic tvalid [0:1];
    logic in_tready[0:1];
    logic tready[0:1];
    logic tlast[0:1]; //throw away
    logic [31:0] n, next_n;
    logic both_ready;
    
    enum {ST_IDLE, ST_RUN, ST_OUTPUT} state, next_state;
    
    
    wire [31:0] weights0 [0:ROWS-1][0 :+ COLS/2-1];
    wire [31:0] weights1 [0:ROWS-1][0 :+ COLS/2-1];
    
    //logic [31:0] outputs [0:COLS-1];
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
    

      .weights(weights0),
      
    
      .INPUT_AXIS_TDATA(INPUT_AXIS_TDATA),
      .INPUT_AXIS_TLAST(INPUT_AXIS_TLAST),
      .INPUT_AXIS_TVALID(INPUT_AXIS_TVALID),
      .INPUT_AXIS_TREADY(in_tready[0]),
                        
      .OUTPUT_AXIS_TDATA(outbuf[0]),
      .OUTPUT_AXIS_TLAST(tlast[0]),
      .OUTPUT_AXIS_TVALID(tvalid[0]),
      .OUTPUT_AXIS_TREADY(tready[0]) 	

    );
    
    
    dot #(
    .ROWS(ROWS),
    .COLS((COLS/2))
    
    ) dot1 (

    // AXI4-Stream Interface
      .clk(clk),
      .rst(rst),
    

      .weights(weights1),
      
    
      .INPUT_AXIS_TDATA(INPUT_AXIS_TDATA),
      .INPUT_AXIS_TLAST(INPUT_AXIS_TLAST),
      .INPUT_AXIS_TVALID(INPUT_AXIS_TVALID),
      .INPUT_AXIS_TREADY(in_tready[1]),
                        
      .OUTPUT_AXIS_TDATA(outbuf[1]),
      .OUTPUT_AXIS_TLAST(tlast[1]),
      .OUTPUT_AXIS_TVALID(tvalid[1]),
      .OUTPUT_AXIS_TREADY(tready[1]) 	

    );
    
    
     
    always_ff@ (posedge clk) begin
        j<= next_j;
        n<=next_n;
        state<=next_state;
//        for (int i=0; i<COLS/2; i++)
//            outbuf[i] <=  next_outbuf[i];
        if(rst) begin
            for(int i = 0; i<2; i++)
                outbuf[i] <= '{default:32'h0};
            j<=0;
            n<=0;
        end
//        end else if (tvalid[n]) begin
//             outbuf[n];
//        end 
    end
    
    always_comb begin
        next_j = j;
        next_n = n;
        next_state = state;
        both_ready = 1'h1;
        INPUT_AXIS_TREADY = 'h0;
        
        OUTPUT_AXIS_TDATA = outbuf[n];
        OUTPUT_AXIS_TLAST = 'h0;
        OUTPUT_AXIS_TVALID = 'h0;
        for(int i = 0; i<2; i++) begin
            tready[i] = 1'h0;
         end   
            
        case(state)
        
            ST_IDLE: begin
                for (int i = 0; i<2; i++)
                    both_ready &= in_tready[i];
                if(both_ready)
                    INPUT_AXIS_TREADY = 1'h1;
                next_n = 0;
                next_j = 0;
                if(tvalid[n]) begin
                        OUTPUT_AXIS_TVALID = 1'h1;                        
                        tready[n] = 1'h1;
                        next_state = ST_OUTPUT;
                    
                    
                end
            
            end
            
            ST_OUTPUT: begin
                OUTPUT_AXIS_TVALID = 1'h1;
                
                
                if(tvalid[n]) begin
                    if(OUTPUT_AXIS_TREADY) begin
                        tready[n] = 1'h1;
                        if(tlast[n]) begin
                           next_n = n+1;
//                           next_state = ST_IDLE;
                           if(n == 2-1) begin
                                next_state = ST_IDLE;
                                next_n = 0;
                                OUTPUT_AXIS_TLAST = 1'h1;
                              
                            end else begin                           
                                next_state = ST_OUTPUT;
                         
                            end
                         end
                    end
                end
              end
              
            
      endcase
    end
    //if you want to cut the weights in half horizontally
    // This does every-other row horizontally
    //genvar i;
    //for (i = 0; i < ROWS/2; ++i) begin
    //    assign weights0[i] = weights[i*2];
    //    assign weights0[i] = weights[i*2+1];
    //end

    
    

endmodule

