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


module dot_20_10_tb();

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
    reg                         OUTPUT_AXIS_TREADY;


    //used to access the FP tests table    
    bit [31:0] fp_hex;
    //used to access the FP Solutions table
    bit [31:0] sol_hex;
 
    axis_dot_20_10 DUT ( 
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
    
    // see python/dot_20_10.py for values
    task inputs_table_lookup(
        input integer id,
        output bit [31:0] hex
        );

        static bit [31:0] fpHex [0:19] = {
         $shortrealtobits(0.9992157677176247), $shortrealtobits(-0.9992391649984632), $shortrealtobits(-0.996713106729648),
         $shortrealtobits(-0.9989178474188565), $shortrealtobits(-0.9991897304310112), $shortrealtobits(-0.9992238976312111),
         $shortrealtobits(-0.999874794745124), $shortrealtobits(-0.9999983469326711), $shortrealtobits(-0.9999823366958234),
         $shortrealtobits(-0.9993464993540697), $shortrealtobits(-0.99999895931321), $shortrealtobits(-0.9994030383922219),
         $shortrealtobits(0.999932362106602), $shortrealtobits(-0.9999615682027578), $shortrealtobits(0.9981479711735248),
         $shortrealtobits(0.9997359101642), $shortrealtobits(0.9966997506542944), $shortrealtobits(0.9973577360650924),
         $shortrealtobits(-0.9991081374552344), $shortrealtobits(-0.9924563156913059)
        };
        static int MAX_SIZE = 20;

        assert(id < MAX_SIZE) else $fatal(1, "Bad id");
        hex = fpHex[id];
    endtask : inputs_table_lookup  
    
    // see python/dot_20_10.py for values
    task outputs_table_lookup(
        input integer id,
        output bit [31:0] hex
        );

        static bit [31:0] fpHex [0:9] = {
         $shortrealtobits(-0.39490294817324495), $shortrealtobits(-0.4558233633141949), $shortrealtobits(-0.3374061380803292),
         $shortrealtobits(-0.463853652749869), $shortrealtobits(-0.3244523604970557), $shortrealtobits(0.29448396778040775),
         $shortrealtobits(1.215281511185426), $shortrealtobits(-0.1505974181548544), $shortrealtobits(-0.17037033565393786),
         $shortrealtobits(-0.1341205480148839)
        };
        static int MAX_SIZE = 10;

                
        assert(id <MAX_SIZE) else $fatal(1, "Bad id");
        hex = fpHex[id];
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
        for (i = 0; i < 20; ++i) begin
            inputs_table_lookup(i, fp_hex);
            $display( "Sending %h (%f)", fp_hex, $bitstoshortreal(fp_hex) ); 
            send_word_axi4stream(fp_hex, i == 19);
        end                
              
        $display("Receiving Output Vector");
        for (i = 0; i < 10; ++i) begin
            real error; 
            
            outputs_table_lookup(i, sol_hex);
            
            recv_word_axi4stream(fp_hex);
            
            $display( "Received %h (%f)",
                fp_hex, $bitstoshortreal(fp_hex));
                
            //skip bit 0 to tolerate off-by-1-LSB rounding errors
            error = $bitstoshortreal(fp_hex) - $bitstoshortreal(sol_hex);
            $display("Error: %f", error);
            
            assert( (error > -0.000001) && (error < +0.000001) ) else
                $fatal(1, "Bad Test Response %h (%f), Expected %h (%f) Error:%f", 
                    fp_hex, $bitstoshortreal(fp_hex), sol_hex, $bitstoshortreal(sol_hex), error); 
            
        end
    endtask
    
    task timeit (
        output int cycles
        );
        
        cycles = 0;
        while (OUTPUT_AXIS_TLAST == 'h0) begin
            cycles += 1;
            @(negedge clk);
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
        
        $display("@@@Passed in %d Cycles (was 2210)", cycles);
        
        $finish;

    end

endmodule
