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
    logic aready;
    logic bready;
    logic next_col;
    logic[31:0] next_out;
    logic outlast;
    logic outvalid;
    logic addready;
    genvar i;
    logic [31:0] n, next_n;
    logic both_ready;
    logic both_valid;
    logic both_last;
    logic [31:0]  j, next_j;
    logic[31:0] k;
    logic [31:0] out[0:COLS-1];
    enum {ST_IDLE, ST_INPUT,ST_ADD, ST_OUTPUT} state, next_state;
    logic valid;

    if ((ROWS%3) == 0) begin
    //    assign reg MODNUM = 2;
        
        logic [31:0] outbuf [0:2];
        logic tvalid [0:2];
        logic in_tready[0:2];
        logic tready[0:2];
        logic tlast[0:2]; //throw away
        logic [31:0] in[0:2];
        logic [31:0] in_tlast [0:2];
        logic [31:0] in_tvalid [0:2];
        
        
        wire [31:0] weights0 [0:+ ROWS/3-1][0 :COLS-1];
        wire [31:0] weights1 [0:+ ROWS/3-1][0 :COLS-1];
        wire [31:0] weights2 [0:+ ROWS/3-1][0 :COLS-1];
        //logic [31:0] outputs [0:COLS-1];
        for (i = 0; i < ROWS/3; ++i) begin
            assign weights0[i] = weights[i*2];
            assign weights1[i] = weights[i*2+1];
            assign weights2[i] = weights[i*2+2];
        end
        
        
        dot #(
        .ROWS((ROWS/3)),
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
        .ROWS((ROWS/3)),
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
        .ROWS((ROWS/3)),
        .COLS(COLS)
        
        )dot2 (
    
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
        
        
        
     axis_fadd fadd0(

        .clk(clk), 

        .A_TDATA(outbuf[n]),
        .A_TLAST(next_col),
        .A_TVALID(valid),
        .A_TREADY(aready), 

        .B_TDATA(out[k]),
        .B_TLAST(next_col),
        .B_TVALID(valid),
        .B_TREADY(bready), 

        .OUT_TDATA(next_out),
        .OUT_TLAST(outlast),
        .OUT_TVALID(outvalid),
        .OUT_TREADY(addready)
    );
        always_ff@ (posedge clk) begin
            j<= next_j;
            n<=next_n;
            state<=next_state;
            
    //        for (int i=0; i<COLS/2; i++)
    //            outbuf[i] <=  next_outbuf[i];
            if(rst) begin
                for(int i = 0; i<3; i++)
                    outbuf[i] <= '{default:32'h0};
                j<=0;
                n<=0;
                out<='{default:32'h0};
                k<=0;
            end else if(outvalid && addready) begin
                out[k] = next_out;
                k <= ( k < COLS -1 ? k + 1 : 0);
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
            both_valid = 1'h1;
            both_last = 1'h1;
            valid = 1'h0;
            next_col = 1'h0;
            addready = 1'h0;
            INPUT_AXIS_TREADY = 'h0;
            
            OUTPUT_AXIS_TDATA = out[j];
            OUTPUT_AXIS_TLAST = 'h0;
            OUTPUT_AXIS_TVALID = 'h0;
            for(int i = 0; i<3; i++) begin
                tready[i] = 1'h0;
                //in[i] = 1'h0;
                in_tvalid[i] = 1'h0;
                in_tlast[i] = 1'h0; 
             end   
                
            case(state)
            
                ST_IDLE: begin

                    if(in_tready[n])
                        //INPUT_AXIS_TREADY = 1'h1;
                        next_state = ST_INPUT;
                    next_n = 0;
                    next_j = 0;
                    

                    if(tvalid[0]) begin
                        next_state = ST_ADD;
                        
                        
                    end
                
                end
                
                ST_INPUT: begin
                    if(in_tready[n]) begin
                        INPUT_AXIS_TREADY = 1'h1;
                        if(INPUT_AXIS_TVALID) begin
                            in_tvalid[n] = 1'h1;
                            in[n] = INPUT_AXIS_TDATA;
                            in_tlast[n] = 1'h1;
                            if(n == 3-1) begin
                                next_n = 0;
                                next_state = ST_IDLE;
                            end else begin
                                next_n = n+1;
                                next_state = ST_INPUT;
                            end  
                        end
                    end  
                end
                
                
                ST_ADD: begin
                    addready = 1'h1;
                    if(aready && bready) begin
                        tready[n] = 1'h1;
                        
                            if(tvalid[n])begin
                                valid = 1'h1;
                                
                                if(n==3-1) begin
                                    next_n = 0;
                                    next_j=j+1;
                                    
                                end else
                                    next_n = n+1;   
                                if(j==COLS-1) begin
                                    next_j = 0;
                                    next_state = ST_OUTPUT;
                                    next_col = 1'h1;
                                end 
                                
                        end
                    end
                        
                end
                
                
                ST_OUTPUT: begin
                    if(outvalid) begin
                        addready = 1'h1;
                        OUTPUT_AXIS_TVALID = 1'h1;
                    
                    
                        if(OUTPUT_AXIS_TREADY) begin
                            
                            if(outlast) begin
                               //next_n = n+1;
                               OUTPUT_AXIS_TLAST = 1'h1;
                               next_state = ST_IDLE;
                                  
                             end else begin  
                                next_j = j+1;                         
                                next_state = ST_OUTPUT;
                                
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
    end else if((ROWS%2) ==0) begin
        $error("dont go here rn");
    end else begin
        $error("ROW # Needs to be divisible by 2 or 3");
    end
    

endmodule

