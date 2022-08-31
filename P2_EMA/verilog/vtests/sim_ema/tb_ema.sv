`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2020 06:04:02 AM
// Design Name: 
// Module Name: testbench
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

// Based on a Xilinx testbench detailed here:
// https://www.xilinx.com/support/documentation/ip_documentation/axi4stream_vip/v1_1/pg277-axi4stream-vip.pdf

import axi4stream_vip_pkg::*;
import bd_ema_axi4stream_vip_0_0_pkg::*;
import bd_ema_axi4stream_vip_1_0_pkg::*;

module tb_ema();

    integer                             i;
    
    // Clock signal
    bit                                 clk;
    // Reset signal
    bit                                 rst;

    //master agent
    bd_ema_axi4stream_vip_0_0_mst_t  mst_agent;
    //slave agent
    bd_ema_axi4stream_vip_1_0_slv_t  slv_agent;
    
    bit [31:0]                          test_write_data;
    bit [31:0]                          test_read_data;
    bit [31:0]                          last_read_data;
 

    // instantiate bd
    bd_ema_wrapper DUT(
      .ACLK_0(clk),
      .ARESETN_0(~rst)
    );

    
    always #10 clk <= ~clk;
     
  
    task send_data (
        input bit[31:0] data
    );
        axi4stream_transaction                  wr_transaction; 
        axi4stream_transaction               resp_transaction; 

        wr_transaction = mst_agent.driver.create_transaction("Master VIP write transaction");
        resp_transaction = mst_agent.driver.create_transaction("Master VIP write response");
        SEND_PACKET_FAILURE: assert(wr_transaction.randomize());
        //wr_transaction.set_data( {data[31:24], data[23:16], data[15:8], data[7:0]} );
        wr_transaction.set_data( {data[7:0], data[15:8], data[23:16],data[31:24] } );
        mst_agent.driver.send(wr_transaction);
    endtask

    task read_data(
        output bit [31:0]       rd_data
    );
        //warning:  don't call unless there is a valid packet waiting!

        //read transaction
        axi4stream_transaction                  rd_transaction;
        xil_axi4stream_data_byte 	              rd_data_bytes [4]; 

        slv_agent.monitor.item_collected_port.get(rd_transaction);
        rd_transaction.get_data( rd_data_bytes );
        //https://www.amiq.com/consulting/2017/05/29/how-to-pack-data-using-systemverilog-streaming-operators/
        rd_data = {>>{rd_data_bytes}}; 
        rd_data = {rd_data[7:0], rd_data[15:8], rd_data[23:16], rd_data[31:24] };
      
    endtask      

    
    task setup ();

        axi4stream_ready_gen                           ready_gen;

        mst_agent = new("master vip agent",DUT.bd_ema_i.axi4stream_vip_0.inst.IF);
        slv_agent = new("slave vip agent",DUT.bd_ema_i.axi4stream_vip_1.inst.IF);
        
        /***************************************************************************************************
        * When bus is in idle, it must drive everything to 0.otherwise it will 
        * trigger false assertion failure from axi_protocol_chekcer
        ***************************************************************************************************/

        mst_agent.vif_proxy.set_dummy_drive_type(XIL_AXI4STREAM_VIF_DRIVE_NONE);
        slv_agent.vif_proxy.set_dummy_drive_type(XIL_AXI4STREAM_VIF_DRIVE_NONE);

        /***************************************************************************************************
        * Set tag for agents for easy debug,if not set here, it will be hard to tell which driver is filing 
        * if multiple agents are called in one testbench
        ***************************************************************************************************/

        mst_agent.set_agent_tag("Master VIP");
        slv_agent.set_agent_tag("Slave VIP");

        // set print out verbosity level.
        mst_agent.set_verbosity(400);
        slv_agent.set_verbosity(400);

        /***************************************************************************************************
        * Master,slave agents start to run 
        * Turn on passthrough agent monitor 
        ***************************************************************************************************/

        mst_agent.start_master();
        slv_agent.start_slave();
        slv_agent.start_monitor();
        
    endtask


    task slv_gen_tready();
        axi4stream_ready_gen                           ready_gen;
        ready_gen = slv_agent.driver.create_ready("ready_gen");
        ready_gen.set_ready_policy(XIL_AXI4STREAM_READY_GEN_NO_BACKPRESSURE);
        //ready_gen.set_low_time(2);
        //ready_gen.set_high_time(6);
        slv_agent.driver.send_tready(ready_gen);
    endtask :slv_gen_tready


    //Main process
    initial begin
        $timeformat (-12, 1, " ps", 1);


        clk <= 0;
        rst <= 1;       
        
        $display("Simulation Setup");
        setup();
        
        $display("Holding Reset");
        for (i = 0; i < 20; i++) 
        @(negedge clk);

        rst <= 0;
        slv_gen_tready();

        @(negedge clk);
        @(negedge clk);

        $display("Starting Simulation");        
        
        //tell the master to transmit data 
        //test_write_data = 32'hff00ff00;     
        //$display("Writing Data: %h", test_write_data);
        //send_data(test_write_data);
        
        //ask the slave what they received
        //read_data( test_read_data );        
        //$display( "Read Data: %h", test_read_data );
        //assert( test_read_data == 32'h0) else $fatal("Bad Test Response");
        
        last_read_data = 32'h3E8;
        for ( i = 100; i < 32'h640; i=i+100) begin
            test_write_data = i;
            $display("Writing Data: %h", test_write_data);
            send_data(test_write_data);
            
            //ask the slave what they received
            read_data( test_read_data );       
            $display( "Read Data: %h", test_read_data );
            assert( test_read_data == ((test_write_data >> 2) + (last_read_data >> 2) + (last_read_data >> 1)))
                else $fatal(1, "Bad Test Response: %h != %h", test_read_data, 
                ((test_write_data >> 2) + (last_read_data >> 2) + (last_read_data >> 1)) );
            last_read_data = test_read_data;
        end
        
        $display("@@@Passed");
        
        $finish;

    end

endmodule
