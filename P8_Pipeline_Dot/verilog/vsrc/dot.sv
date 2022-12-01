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

module dot #(   

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

    //weight matrix
    input [31:0]                    weights [0:ROWS-1] [0:COLS-1], 
    
    // Outgoing Vector AXI4-Stream 		
    output logic [31:0]             OUTPUT_AXIS_TDATA,
    output logic                    OUTPUT_AXIS_TLAST,
    output logic                    OUTPUT_AXIS_TVALID,
    input                           OUTPUT_AXIS_TREADY

    );  

    //output vector array (also used for dot calculations)
    logic [31:0] outputs [0:COLS-1];       
    //bulk clear the entire output array 
    logic clear_outputs;

    //buffer for the most recient input
    logic [31:0] inbuf, next_inbuf;     

    //ask for the Floating-Point Multiply-Accumulate module to be run
    logic run_fmac;

    //tracks the row/column location of weight matrix values headed to the fmac
    logic [31:0]  i, next_i;
    logic [31:0]  j, next_j;

    //tracks the row/column local of returning fmac values 
    logic [31:0] rxi, rxj;
    
    //signal when the last values has been recieved from the fmac
    wire rx_done;
           
    /////////////////////////////////////////////
    //
    // Floating Point Multiply Accumulate (FMAC)
    //
    /////////////////////////////////////////////

    wire [31:0] fmac_tdata;
    wire        fmac_tvalid; 

    axis_fmac fmac0(
        .clk, 

        .A_TDATA(weights[i][j]),
        .A_TVALID(run_fmac), 

        .B_TDATA(inbuf), 
        .B_TVALID(run_fmac),

        .C_TDATA(outputs[j]), 
        .C_TVALID(run_fmac), 

        .OUT_TDATA(fmac_tdata), 
        .OUT_TVALID(fmac_tvalid)

        );




    /////////////////////////////////////////////
    //
    // Input Vector Receive +
    // Send-to-FPU Control  + 
    // Output Vector Transmit
    //
    /////////////////////////////////////////////

    
    //FMAC has a 8 cycle latency 
    localparam FMAC_DELAY = 8; 
    //a timer to track the FPU delays
    localparam TIMER_SZ = $clog2(FMAC_DELAY + 1);
    logic [TIMER_SZ-1:0] fpu_timer, next_fpu_timer; 
    

    // STATES
    enum { ST_IDLE, ST_RUN_FMAC, ST_FMAC, ST_STEP_ROW, 
                    ST_TERM_ROW, ST_OUTPUT } state, next_state;

    //sequential block
    always_ff@(posedge clk) begin

        if (rst) begin
            state <= ST_IDLE;
            fpu_timer <= 'h0; 
            i <= 0;
            j <= 0;
            inbuf <= 32'h0;            
    
        end else begin
            state <= next_state;           
            fpu_timer <= next_fpu_timer;
            i <= next_i;
            j <= next_j;
            inbuf <= next_inbuf;             
        end 
        
    end 
    
    //combinational block                
    always_comb begin        
        next_state = state;
        //try to count down if the timer isn't already 0
        next_fpu_timer = (fpu_timer == 'h0 ? 'h0 : fpu_timer - 'h1);

        next_i = i; 
        next_j = j;  
        next_inbuf = inbuf; 

        run_fmac = 'h0;

        clear_outputs = 1'h0;

        //input control
        INPUT_AXIS_TREADY = 'h0; 
        
        //output control
        OUTPUT_AXIS_TDATA = outputs[j];
        OUTPUT_AXIS_TLAST = 'h0;
        OUTPUT_AXIS_TVALID = 'h0;
    
        case (state)

            ST_IDLE:  begin
                INPUT_AXIS_TREADY = 'h1; 
                //we've got valid data
                if (INPUT_AXIS_TVALID ) begin
                    next_i = 0;
                    next_j = 0;
                    next_inbuf = INPUT_AXIS_TDATA;
                    next_fpu_timer = FMAC_DELAY;
                    next_state = ST_FMAC;
                end
                
            end
           
//            ST_RUN_FMAC: begin
//                //timer for when the first results are back
                
//                run_fmac = 'h1;
//                next_j = j + 1;
//                next_state = ST_FMAC; 
//            end

           
            ST_FMAC: begin
                run_fmac = 'h1;
                if (j == COLS-1) begin
                    if (fpu_timer <= 1) begin
                    // end of a row? 
                        next_state = ST_TERM_ROW;
                    // go on to the next value in the row
                    end
                end else begin
                    
                    next_j = j + 1;
                    next_state = ST_FMAC;                   
  //                  next_state = ST_RUN_FMAC;    
                 end
                
              end
//            ST_STEP_ROW:  begin
//                next_j = j + 1;
//                next_state = ST_RUN_FMAC;
//            end

            ST_TERM_ROW: begin
            
                //start on the next row
                if (i < ROWS - 1) begin
                
                    INPUT_AXIS_TREADY = 'h1;
                    
                    if (INPUT_AXIS_TVALID) begin
                                                                        
                        next_i = i + 1;
                        next_j = 0;
                        next_fpu_timer = FMAC_DELAY;
                        next_inbuf = INPUT_AXIS_TDATA;
                        next_state = ST_FMAC;
                    end
                //done with inputs, start sending out outputs
                end else begin
                    run_fmac = 'h0;
                    next_i = 0;
                    next_j = 0;
                    next_state = ST_OUTPUT; 
                end
             end                         
            
             ST_OUTPUT: begin
                OUTPUT_AXIS_TVALID = 'h1;
                OUTPUT_AXIS_TLAST = (j == COLS - 1 ? 1'h1 : 1'h0);
                
                if ( OUTPUT_AXIS_TREADY ) begin
                
                    if (j == COLS-1) begin
                        //be done
                        next_j = 0;
                        clear_outputs = 'h1;
                        next_state = ST_IDLE;
                        
                    end else begin
                        // transmit the next output vector element 
                        next_j = j +1;
                    end
                end
            end
             
       endcase
    end


/////////////////////////////////////////////
//
// Recv from FMAC Control 
//
/////////////////////////////////////////////

always_ff@(posedge clk) begin
    
    if (rst) begin
        rxi <= 0;
        rxj <= 0;
        outputs <= '{default:32'h0};
        
    end else if (clear_outputs) begin
        outputs <= '{default:32'h0};

    // this waits until the FPU gives a valid result
    // then stores it back into the outputs buffer
    end else if (fmac_tvalid) begin
        outputs[rxi] <= fmac_tdata;
        rxi <= ( rxi < COLS -1 ? rxi + 1 : 0);
        rxj <= ( rxi < COLS -1 ? rxj :
                    (rxj < ROWS - 1 ? rxj + 1 :
                                    0 ));
    end
end

//we got the last value from the FPU.  
assign rx_done = fmac_tvalid && (rxi == COLS - 1) && (rxj == ROWS -1);

endmodule
