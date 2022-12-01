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


module dot_80_40_tb();

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

    localparam ROWS = 80;
    localparam COLS = 40;

    //used to access the FP tests table    
    bit [31:0] fp_hex;
    //used to access the FP Solutions table
    bit [31:0] sol_hex;
 
    axis_dot_80_40 DUT ( 
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
    
    // see dot_80_40.py for values
    task inputs_table_lookup(
        input integer id,
        output bit [31:0] hex
        );
        static real vals [0:79] = {
         -0.99993666, -1.0, 0.99574487,
         0.99999998, 1.0, -0.99992773,
         -0.99989264, 0.9999982, -0.9980847,
         0.99999904, -0.99996662, -1.0,
         -0.99999904, 0.99391772, 0.99999968,
         0.99946278, 0.99999916, 0.94903642,
         -0.6753862, 1.0, 0.27159184,
         0.99999856, -0.99999996, -0.99999979,
         -0.99420035, -0.98742864, 1.0,
         -0.99843872, 0.87078123, -0.99999737,
         -1.0, 0.99986937, 0.88564952,
         0.99999087, 0.99999999, 0.98621496,
         -0.99999994, -0.99999639, 0.9999453,
         -0.99219803, 0.99993526, 0.99898589,
         -0.99993727, 0.95033335, -0.99998736,
         0.90820362, -0.99998004, -0.95612777,
         -0.97395696, 0.99999955, 0.99947614,
         0.99999562, 0.99999966, -0.99749103,
         0.99982622, 0.99583578, -0.9530266,
         0.6071803, 0.83315984, -0.99995934,
         0.99956971, -0.99987226, -0.73595215,
         0.99999985, 0.99999999, 0.99998076,
         0.03367572, -0.99914213, -0.99982505,
         -0.99999983, 0.99999999, 0.99999946,
         0.97750493, -0.76672308, -0.99782618,
         -0.99999737, 0.99998291, -0.99995543,
         -1.0, -0.85942883 
        };
        static int MAX_SIZE = 80;

        assert(id < MAX_SIZE) else $fatal(1, "Bad id");
        hex = $shortrealtobits(vals[id]);
    endtask : inputs_table_lookup  
    
    // see python
    task outputs_table_lookup(
        input integer id,
        output bit [31:0] hex
        );
            static real vals [0:39] = {
             -2.56295186722496, -4.106480599588279, 0.8597011309717095,
             4.730296379530421, 3.446830785928043, -2.6935402053409967,
             -2.5766060018004047, -4.117526174542005, -5.455922429679368,
             0.1649768066340762, 4.0823316720724145, -5.16598168005933,
             4.225582675190466, -1.8932889473232173, -0.9591924116183381,
             -6.7866314841366036, -3.773932392807668, -0.2938132037372191,
             7.163449367981975, -4.746335391310771, 2.3858416738036228,
             5.354935307735332, 6.309808424817137, 7.867790706984355,
             4.078022898616856, -6.927577414388174, -4.2827903899029325,
             -0.10892438200657761, -3.7731060298055907, -4.251436854810837,
             8.481967576306966, 0.24938915838097087, -3.553463480634921,
             6.842945316836492, -0.9251580903143795, 4.252005630535563,
             -0.374815101535909, 1.2048675971225664, 5.676014215078173,
             0.6482551462313731 
            };
        static int MAX_SIZE = 40;
  
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
        
        $display("@@@Passed in %d Cycles (was 35241)", cycles);
        $finish;

    end

endmodule
