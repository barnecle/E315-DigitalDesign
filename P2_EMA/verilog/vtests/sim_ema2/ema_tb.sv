`timescale 1ns/1ps

module ema_tb();

logic           ACLK;
logic           ARESETN;

logic [31:0]    S_AXIS_TDATA;
logic [3:0]     S_AXIS_TKEEP;
logic           S_AXIS_TLAST;
logic           S_AXIS_TVALID;
wire            S_AXIS_TREADY;

wire [31:0]     M_AXIS_TDATA;
wire [3:0]      M_AXIS_TKEEP;
wire            M_AXIS_TLAST;
wire            M_AXIS_TVALID;
logic           M_AXIS_TREADY;

axis_ema_sv ema0(
    .ACLK(ACLK),
    .ARESETN(ARESETN),

    .S_AXIS_TDATA(S_AXIS_TDATA),
    .S_AXIS_TKEEP(S_AXIS_TKEEP),
    .S_AXIS_TLAST(S_AXIS_TLAST),
    .S_AXIS_TVALID(S_AXIS_TVALID),
    .S_AXIS_TREADY(S_AXIS_TREADY),

    .M_AXIS_TDATA(M_AXIS_TDATA),
    .M_AXIS_TKEEP(M_AXIS_TKEEP),
    .M_AXIS_TLAST(M_AXIS_TLAST),
    .M_AXIS_TVALID(M_AXIS_TVALID),
    .M_AXIS_TREADY(M_AXIS_TREADY)
    );

always #10 ACLK=~ACLK;

   integer   i;
   reg [31:0] test_write_data;
   reg [31:0] last_read_data;
   logic [31:0] recv;    


task init_signals();
    ACLK='h0;
    ARESETN='h0;

    S_AXIS_TDATA='h0;
    S_AXIS_TKEEP='h0;
    S_AXIS_TLAST='h0;
    S_AXIS_TVALID='h0;

    M_AXIS_TREADY='h0;
    
   last_read_data = 32'h3E8;
   i = 0;
   test_write_data = 0;
endtask

task send_word(
    input logic [31:0] data,
    input logic last
    );
    
    S_AXIS_TDATA = data;
    S_AXIS_TKEEP = 'hf;
    S_AXIS_TVALID='h1;
    S_AXIS_TLAST = last;
    #1;
    while( S_AXIS_TREADY == 'h0)  begin
        @(negedge ACLK);
        #1;
    end
    
    @(negedge ACLK);
    S_AXIS_TVALID='h0;
    S_AXIS_TLAST='h0;
endtask

task recv_word(
    output logic [31:0] data
    );
    
    M_AXIS_TREADY = 'h1;
    #1;
    while (M_AXIS_TVALID == 'h0) begin
        @(negedge ACLK);
        #1;
    end
    
    //@(negedge ACLK);
    data = M_AXIS_TDATA;
    @(negedge ACLK);
    M_AXIS_TREADY = 'h0;
    
endtask    

task send_and_recv(
    input logic [31:0] send_data,
    input logic        send_last,
    output logic [31:0] recv_data
    );
    fork
        send_word(send_data, send_last);
        recv_word(recv_data);
    join
endtask

initial begin
    init_signals();
    for (int i = 0;i < 16;i++) 
        @(negedge ACLK);
    ARESETN=1;
    
    @(negedge ACLK);
    
    //send_and_recv( 32'h0001000, 0, recv);
    //$display("recv: %h", recv);
    // send_and_recv( 32'h0002000, 1, recv);
    // $display("recv: %h", recv);
    //test sequence here!
    for ( i = 100; i < 32'h640; i=i+100) begin
        test_write_data = i;
        $display("Writing Data: %h", test_write_data);
        send_and_recv(test_write_data, 0, recv);
        $display( "Read Data: %h", recv );

        assert( recv == ((test_write_data >> 2) + (last_read_data >> 2) + (last_read_data >> 1)))
            else $fatal(1, "Bad Test Response: %h != %h", recv,
            ((test_write_data >> 2) + (last_read_data >> 2) + (last_read_data >> 1)) );
        last_read_data = recv;
    end
    
    @(negedge ACLK);
    $display("Testing for correct TVALID and TDATA");
    
    for ( i = 100; i < 32'h640; i=i+100) begin
        S_AXIS_TDATA = 'h0; //i[31:0];
        S_AXIS_TKEEP = 'hf;
        S_AXIS_TVALID='h1;
        M_AXIS_TREADY = 'h0;
        @(negedge ACLK);
    end
    
    for ( i = 100; i < 32'h640; i=i+100) begin
        S_AXIS_TDATA = 'h0; //i[31:0];
        S_AXIS_TKEEP = 'hf;
        S_AXIS_TVALID='h0;
        M_AXIS_TREADY = 'h1;
        @(negedge ACLK);
    end
    
    test_write_data = 32'hffff;
    $display("Writing Data: %h", test_write_data);
    send_and_recv(test_write_data, 0, recv);
    $display( "Read Data: %h", recv );

    assert( recv == ((test_write_data >> 2) + (last_read_data >> 2) + (last_read_data >> 1)))
            else $fatal(1, "Bad Test Response: %h != %h", recv,
            ((test_write_data >> 2) + (last_read_data >> 2) + (last_read_data >> 1)) );
   
    $display("@@@Passed");
    $finish;
end

endmodule
