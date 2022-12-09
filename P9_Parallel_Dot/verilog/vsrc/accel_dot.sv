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

    parameter ROWS = 4,
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
    if (( ROWS % 2) != 0)
        $error("ROWS must be even"); 
    logic aready0;
    logic bready0;
    logic aready1;
    logic bready1;
    
    genvar i;
    logic [31:0] n, next_n;

    logic both_valid;
//    logic both_valid1;

    logic [31:0]  j, next_j;
    logic[31:0] k;
    logic [31:0] out[0:COLS-1];
    enum {ST_IDLE, ST_INPUT,ST_ADD, ST_OUTPUT} state, next_state;
    logic validfinal;

    logic [31:0] rcount, next_rcount;
//    if ((ROWS%2) == 0) begin
        wire [31:0] weights0 [0:+ ROWS/4-1][0 :COLS-1];
        wire [31:0] weights1 [0:+ ROWS/4-1][0 :COLS-1];
        wire [31:0] weights2 [0:+ ROWS/4-1][0 :COLS-1];
        wire [31:0] weights3 [0:+ ROWS/4-1][0 :COLS-1];
        for (i = 0; i < ROWS/4; ++i) begin
            assign weights0[i] = weights[i*4];
            assign weights1[i] = weights[i*4+1];
            assign weights2[i] = weights[i*4+2];
            assign weights3[i] = weights[i*4+3];
        end
//    end else  begin //if ((ROWS%3) == 0)
   
//        wire [31:0] weights0 [0:+ 2*ROWS/3-1][0 :COLS-1];
//        wire [31:0] weights1 [0:+ ROWS/3-1][0 :COLS-1];

//        for (i = 0; i < ROWS/3; ++i) begin
//            assign weights0[i] = weights[i*2];
//            assign weights1[i] = weights[i*2+1];
//            assign weights0[i+1] = weights[i*2+2];
//        end
    
//    end 
//    else begin
//        $error("ROW # Needs to be divisible by 2 or 3");
//    end
    
    logic [31:0] outbuf [0:3];
    logic tvalid [0:3];
    logic in_tready[0:3];
    logic tready[0:3];
    logic tlast[0:3]; //throw away
    logic [31:0] in[0:3];
    logic [31:0] next_in[0:3];
    logic [31:0] in_tlast [0:3];
    logic [31:0] in_tvalid [0:3];
        
    logic [31:0] fadd_out1;
    logic [31:0] fadd_out0;
    
    logic fadd_tlast1;
    logic fadd_tvalid1;
    logic fadd_tlast0;
    logic fadd_tvalid0;
    
    logic breadyfinal;    
    logic areadyfinal;    
    logic addready [0:1];
        
        
        dot #(
        .ROWS((ROWS/4)),
        .COLS(COLS)
        
        ) dot0 (
    
        // AXI4-Stream Interface
          .clk(clk),
          .rst(rst),
        
    
          .weights(weights0),
          
        
          .INPUT_AXIS_TDATA(in[0]),
          .INPUT_AXIS_TLAST(in_tlast[0]),
          .INPUT_AXIS_TVALID(in_tvalid[0]),
          .INPUT_AXIS_TREADY(in_tready[0]),
                            
          .OUTPUT_AXIS_TDATA(outbuf[0]),
          .OUTPUT_AXIS_TLAST(tlast[0]),
          .OUTPUT_AXIS_TVALID(tvalid[0]),
          .OUTPUT_AXIS_TREADY(tready[0]) 	
    
        );
        
        
        dot #(
        .ROWS((ROWS/4)),
        .COLS(COLS)
        
        ) dot1 (
    
        // AXI4-Stream Interface
          .clk(clk),
          .rst(rst),
        
    
          .weights(weights1),
          
        
          .INPUT_AXIS_TDATA(in[1]),
          .INPUT_AXIS_TLAST(in_tlast[1]),
          .INPUT_AXIS_TVALID(in_tvalid[1]),
          .INPUT_AXIS_TREADY(in_tready[1]),
                            
          .OUTPUT_AXIS_TDATA(outbuf[1]),
          .OUTPUT_AXIS_TLAST(tlast[1]),
          .OUTPUT_AXIS_TVALID(tvalid[1]),
          .OUTPUT_AXIS_TREADY(tready[1]) 	
    
        );
        dot #(
        .ROWS((ROWS/4)),
        .COLS(COLS)
        
        ) dot3 (
    
        // AXI4-Stream Interface
          .clk(clk),
          .rst(rst),
        
    
          .weights(weights2),
          
        
          .INPUT_AXIS_TDATA(in[2]),
          .INPUT_AXIS_TLAST(in_tlast[2]),
          .INPUT_AXIS_TVALID(in_tvalid[2]),
          .INPUT_AXIS_TREADY(in_tready[2]),
                            
          .OUTPUT_AXIS_TDATA(outbuf[2]),
          .OUTPUT_AXIS_TLAST(tlast[2]),
          .OUTPUT_AXIS_TVALID(tvalid[2]),
          .OUTPUT_AXIS_TREADY(tready[2]) 	
    
        );
        dot #(
        .ROWS((ROWS/4)),
        .COLS(COLS)
        
        ) dot4 (
    
        // AXI4-Stream Interface
          .clk(clk),
          .rst(rst),
        
    
          .weights(weights3),
          
        
          .INPUT_AXIS_TDATA(in[3]),
          .INPUT_AXIS_TLAST(in_tlast[3]),
          .INPUT_AXIS_TVALID(in_tvalid[3]),
          .INPUT_AXIS_TREADY(in_tready[3]),
                            
          .OUTPUT_AXIS_TDATA(outbuf[3]),
          .OUTPUT_AXIS_TLAST(tlast[3]),
          .OUTPUT_AXIS_TVALID(tvalid[3]),
          .OUTPUT_AXIS_TREADY(tready[3]) 	
    
        );
        
        
     axis_fadd fadd0(

        .clk(clk), 

        .A_TDATA(outbuf[0]),
        .A_TLAST(tlast[0]),
        .A_TVALID(both_valid),
        .A_TREADY(aready0), 

        .B_TDATA(outbuf[1]),
        .B_TLAST(tlast[1]),
        .B_TVALID(both_valid),
        .B_TREADY(bready0), 

        .OUT_TDATA(fadd_out0),
        .OUT_TLAST(fadd_tlast0),
        .OUT_TVALID(fadd_tvalid0),
        .OUT_TREADY(addready[0])
    );
     axis_fadd fadd1(

        .clk(clk), 

        .A_TDATA(outbuf[2]),
        .A_TLAST(tlast[2]),
        .A_TVALID(both_valid),
        .A_TREADY(aready1), 

        .B_TDATA(outbuf[3]),
        .B_TLAST(tlast[3]),
        .B_TVALID(both_valid),
        .B_TREADY(bready1), 

        .OUT_TDATA(fadd_out1),
        .OUT_TLAST(fadd_tlast1),
        .OUT_TVALID(fadd_tvalid1),
        .OUT_TREADY(addready[1])
    );
     axis_fadd faddfinal(

        .clk(clk), 

        .A_TDATA(fadd_out0),
        .A_TLAST(fadd_tlast0),
        .A_TVALID(validfinal),
        .A_TREADY(areadyfinal), 

        .B_TDATA(fadd_out1),
        .B_TLAST(fadd_tlast1),
        .B_TVALID(validfinal),
        .B_TREADY(breadyfinal), 

        .OUT_TDATA(OUTPUT_AXIS_TDATA),
        .OUT_TLAST(OUTPUT_AXIS_TLAST),
        .OUT_TVALID(OUTPUT_AXIS_TVALID),
        .OUT_TREADY(OUTPUT_AXIS_TREADY)
    );
          
        always_ff@ (posedge clk) begin
            j<= next_j;
            n<=next_n;
            state<=next_state;
            rcount <= next_rcount;
            
//            for(int i = 0; i<2; i++)
//                    in[i] <= next_in[i];
            if(rst) begin
                
                j<=0;
                n<=0;
                out<='{default:32'h0};
                k<=0;
                rcount <= 0;
            end

         
        end
        
        always_comb begin
            next_j = j;
            next_n = n;
            next_state = state;
//            both_valid0 = 1'h1;
            both_valid = 1'h1;
            next_rcount = rcount;
//            both_ready = 1'h0;
//            both_last = 1'h1;
            validfinal = fadd_tvalid0 && fadd_tvalid1;
            
            
            INPUT_AXIS_TREADY = 'h0;
            
//            OUTPUT_AXIS_TDATA = out[j];
//            OUTPUT_AXIS_TLAST = 'h0;
//            OUTPUT_AXIS_TVALID = 'h0;
            for(int i = 0; i<4; i++) begin
                tready[i] = 1'h0;
                in[i] = 1'h0;
                both_valid &= tvalid[i];
                in_tvalid[i] = 1'h0;
                in_tlast[i] = 1'h0; 
                next_in[i] = in[i];
                addready[i] = 1'h0;
             end
             
//             for(int i = 0; i<2; i++) begin
//                both_valid0 &= tvalid[i];
//                both_valid1 &= tvalid[i+2];   
//             end
            
                
            case(state)
            
                ST_IDLE: begin
                    
                    if(in_tready[n])
                        //INPUT_AXIS_TREADY = 1'h1;outlast
                        next_state = ST_INPUT;
                    next_n = 0;
                    next_j = 0;
                    

//                    if(outvalid) begin
//                        next_state = ST_OUTPUT;
                        
                        
//                    end
                
                end
                
                ST_INPUT: begin
                   
                    if(in_tready[n]) begin
                        INPUT_AXIS_TREADY = 1'h1;
                        if(INPUT_AXIS_TVALID) begin
                            in_tvalid[n] = 1'h1;
                            in[n] = INPUT_AXIS_TDATA;
                            
                            if(rcount == ROWS-1) begin
                                for(int i = 0; i<4; i++)
                                    in_tlast[i] = 1'h1;
                                next_n = 0;
                                next_state = ST_ADD;
                                next_rcount = 0;
                                
                            end else if(n == 4-1)begin
                                next_n = 0;
                                next_state = ST_INPUT;
                                next_rcount = rcount+1;
                            end else begin
                                next_n = n+1;
                                next_state = ST_INPUT;
                                next_rcount= rcount+1;
                            end  
                        end
                     end
//                    end  else begin
//                        if(rcount == ROWS-1) begin
//                                for(int i = 0; i<2; i++)
//                                    in_tlast[i] = 1'h1;
//                                next_n = 0;
//                                next_state = ST_ADD;
//                                rcount = 0;
//                            end else if(n == 2-1)begin
//                                next_n = 0;
//                                next_state = ST_INPUT;
//                               // rcount++;
//                            end else begin
//                                next_n = n+1;
//                                next_state = ST_INPUT;
//                              //  rcount++;
//                            end  
//                    end
                end
                
                ST_ADD: begin
                    if(both_valid) begin
                        if(aready0 && bready0 && bready1 && aready1) begin

                            for(int i = 0; i<4; i++) 
                                tready[i] = 1'h1;
                        end
                    end
                    
                    if(validfinal) begin
                        if(areadyfinal && breadyfinal) begin

                            for(int i = 0; i<4; i++) 
                                addready[i] = 1'h1;
                        end
                    
                    end else if(OUTPUT_AXIS_TLAST) begin
                        next_state = ST_IDLE;
   
                    end
                end
//                ST_ADD: begin
//                    addready = 1'h1;
                    
//                    if(aready && bready) begin
//                        tready[n] = 1'h1;
                        
//                            if(tvalid[n])begin
//                                valid = 1'h1;
                                
//                                if(n==3-1) begin
//                                    next_n = 0;
//                                    next_j=j+1;
                                    
//                                end else
//                                    next_n = n+1;   
//                                if(j==COLS-1) begin
//                                    next_j = 0;
//                                    next_state = ST_OUTPUT;
//                                    next_col = 1'h1;
//                                end 
                                
//                        end
//                    end
                        
//                end
                
                
//                ST_OUTPUT: begin
                    
//                    if(outvalid) begin
                        
//                        OUTPUT_AXIS_TVALID = 1'h1;
                    
                    
//                        if(OUTPUT_AXIS_TREADY) begin
//                            addready = 1'h1;
//                            if(OUTPUT_AXIS_TLAST) begin
//                               //next_n = n+1;
//                               OUTPUT_AXIS_TLAST = 1'h1;
//                               next_state = ST_IDLE;
                                  
//                             end else begin  
//                                next_j = j+1;                         
//                                next_state = ST_OUTPUT;
                                
//                             end
//                        end
//                     end
//                end
                  
                  
                
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

