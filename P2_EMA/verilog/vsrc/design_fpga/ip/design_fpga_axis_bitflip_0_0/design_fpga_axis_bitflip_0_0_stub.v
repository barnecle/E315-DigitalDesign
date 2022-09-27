// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Thu Sep 22 17:14:14 2022
// Host        : if3111linux-09 running 64-bit Ubuntu 20.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /nfs/nfs2/home/barnecle/E315-Digital-Design/P2_EMA/verilog/vsrc/design_fpga/ip/design_fpga_axis_bitflip_0_0/design_fpga_axis_bitflip_0_0_stub.v
// Design      : design_fpga_axis_bitflip_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "axis_bitflip,Vivado 2020.2" *)
module design_fpga_axis_bitflip_0_0(ACLK, ARESETN, S_AXIS_TDATA, S_AXIS_TKEEP, 
  S_AXIS_TLAST, S_AXIS_TVALID, S_AXIS_TREADY, M_AXIS_TDATA, M_AXIS_TKEEP, M_AXIS_TLAST, 
  M_AXIS_TVALID, M_AXIS_TREADY)
/* synthesis syn_black_box black_box_pad_pin="ACLK,ARESETN,S_AXIS_TDATA[31:0],S_AXIS_TKEEP[3:0],S_AXIS_TLAST,S_AXIS_TVALID,S_AXIS_TREADY,M_AXIS_TDATA[31:0],M_AXIS_TKEEP[3:0],M_AXIS_TLAST,M_AXIS_TVALID,M_AXIS_TREADY" */;
  input ACLK;
  input ARESETN;
  input [31:0]S_AXIS_TDATA;
  input [3:0]S_AXIS_TKEEP;
  input S_AXIS_TLAST;
  input S_AXIS_TVALID;
  output S_AXIS_TREADY;
  output [31:0]M_AXIS_TDATA;
  output [3:0]M_AXIS_TKEEP;
  output M_AXIS_TLAST;
  output M_AXIS_TVALID;
  input M_AXIS_TREADY;
endmodule
