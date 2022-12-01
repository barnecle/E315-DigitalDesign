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
//
//////////////////////////////////////////////////////////////////////////////////


module dot_40_20_tb();

    integer                     i;
    
    // Clock signal
    bit                         clk;
    // Reset signal
    bit                         rst;

    // Incomming Matrix AXI4-Stream
    reg [31:0]                  INPUT_AXIS_TDATA;
    reg                         INPUT_AXIS_TLAST;
    reg                         INPUT_AXIS_TVALID;
    wire                        INPUT_AXIS_TREADY;
    
    // Outgoing Vector AXI4-Stream 		
    wire [31:0]                 OUTPUT_AXIS_TDATA;
    wire                        OUTPUT_AXIS_TLAST;
    wire                        OUTPUT_AXIS_TVALID;
    logic                       OUTPUT_AXIS_TREADY;

    localparam ROWS = 40;
    localparam COLS = 20;

    //used to access the FP tests table    
    bit [31:0] fp_hex;
    //used to access the FP Solutions table
    bit [31:0] sol_hex;
 
    axis_dot_40_20 DUT ( 
        .aclk(clk), 
        .aresetn(~rst), 

        .INPUT_AXIS_TDATA,
        .INPUT_AXIS_TLAST,
        .INPUT_AXIS_TVALID,
        .INPUT_AXIS_TREADY,
        
        .OUTPUT_AXIS_TDATA,
        .OUTPUT_AXIS_TLAST,
        .OUTPUT_AXIS_TVALID,
        .OUTPUT_AXIS_TREADY

    );  


    always #10 clk <= ~clk;
    
    // see dot_40_20.py for values
    task inputs_table_lookup(
        input integer id,
        output bit [31:0] hex
        );

        static real vals [0:39] = {
         -0.97324513, -0.99973542, 0.64527108,
         0.99988109, 0.99595069, -0.98408434,
         -0.9890808, -0.99955385, -0.99998705,
         -0.18774578, 0.99888307, -0.99996168,
         0.99976889, -0.96300177, -0.8224581,
         -0.99999881, -0.99803738, -0.3835353,
         0.99999954, -0.99962085, 0.97247763,
         0.99997827, 0.99999217, 0.9999999,
         0.99921018, -0.99999825, -0.99979576,
         0.37571317, -0.99966718, -0.99985736,
         0.9999999, 0.6322208, -0.99883062,
         0.99999917, -0.43211862, 0.9997527,
         0.07368133, 0.8904946, 0.9999912,
         0.77457165 
        };
        static int MAX_SIZE = 40;

        assert(id < MAX_SIZE) else $fatal(1, "Bad id");
        hex = $shortrealtobits(vals[id]);
    endtask : inputs_table_lookup  
    
    // see python
    task outputs_table_lookup(
        input integer id,
        output bit [31:0] hex
        );

        static real vals [0:19] = {
         3.394733803682449, -4.195110826909624, -2.856184972692452,
         -4.02362054468726, -4.205134893494081, -4.220923412973807,
         -4.564004365621471, -6.618344491902944, -5.570119421375833,
         -4.190088827276643, -7.072726166853906, -4.197478825035724,
         4.7107838747886595, -5.259218288826073, 3.093779915970231,
         3.790057101125754, 3.2631154713850212, 2.6904738210768393,
         -3.661295720110934, -2.3826366034958313 
        };
        static int MAX_SIZE = 20;
                
        assert(id <MAX_SIZE) else $fatal(1, "Bad id");
        hex = $shortrealtobits(vals[id]);
    endtask: outputs_table_lookup
    
    
    task send_word_axi4stream(
        input logic [31:0] data,
        input logic last
    );
    
        INPUT_AXIS_TDATA = data;
        INPUT_AXIS_TVALID='h1;
        INPUT_AXIS_TLAST = last;
        #1;
        while( INPUT_AXIS_TREADY == 'h0)  begin
            @(negedge clk);
            #1;
        end
        
        @(negedge clk);
        INPUT_AXIS_TVALID='h0;
        INPUT_AXIS_TLAST='h0;

    endtask

    task recv_word_axi4stream(
        output logic [31:0] data
    );
    
        OUTPUT_AXIS_TREADY = 'h1;
        #1;
        while (OUTPUT_AXIS_TVALID == 'h0) begin
            @(negedge clk);
            #1;
        end
        
        data = OUTPUT_AXIS_TDATA;
        @(negedge clk);
        OUTPUT_AXIS_TREADY = 'h0;
    
    endtask    

    task init();

        clk = 'h0;
        rst = 'h1;

        INPUT_AXIS_TDATA = 'h0;
        INPUT_AXIS_TLAST = 'h0;
        INPUT_AXIS_TVALID = 'h0;
        
        OUTPUT_AXIS_TREADY = 'h0;
      
       i = 0;
    endtask

    task compute();
        $display("Sending Input Vector");                
        for (i = 0; i < ROWS ; ++i) begin
            inputs_table_lookup(i, fp_hex);
            $display( "Sending %h (%f)", fp_hex, $bitstoshortreal(fp_hex) ); 
            send_word_axi4stream(fp_hex, i == 19);
        end                
              
        $display("Receiving Output Vector");
        for (i = 0; i < COLS; ++i) begin
            real mismatch; 
            
            outputs_table_lookup(i, sol_hex);
            
            recv_word_axi4stream(fp_hex);
            
            $display( "Received %h (%f)",
                fp_hex, $bitstoshortreal(fp_hex));
                
            //compute the difference between what was observed and what was
            // expected with Python
            mismatch = $bitstoshortreal(fp_hex) - $bitstoshortreal(sol_hex);
            $display("mismatch: %f", mismatch);
            
            assert( (mismatch >= -0.00001) && (mismatch <= +0.00001) ) else
                $fatal(1, "Bad Test Response %h (%f), Expected %h (%f) mismatch:%f", 
                    fp_hex, $bitstoshortreal(fp_hex), sol_hex, $bitstoshortreal(sol_hex), mismatch); 
            
        end
    endtask
    
    task timeit (
        output int cycles
        );
        
        cycles = 0;
        while ( ! (
            (OUTPUT_AXIS_TREADY === 'h1) && 
            (OUTPUT_AXIS_TVALID === 'h1) && 
            (OUTPUT_AXIS_TLAST === 'h1) ) ) begin
            cycles += 1;
            
            @(posedge clk);
            
            assert (cycles < 44100) else 
                $fatal(1, "Running too long, check OUTPUT_AXIS?");
        end
                        
    endtask
       

    //Main process
    initial begin
 
        int cycles;
        
        $timeformat (-12, 1, " ps", 1);      

        $display("Simulation Setup");
        init();
        
        $display("Holding Reset");
        for (i = 0; i < 20; i++) 
        @(negedge clk);

        rst = 0;        

        repeat(2) @(negedge clk);
        
        $display("Starting Simulation"); 
        
        fork
            compute();
            timeit(cycles);
        join                                                  
        
        $display("@@@Passed in %d Cycles (was 8821)", cycles);
        $finish;

    end

endmodule
