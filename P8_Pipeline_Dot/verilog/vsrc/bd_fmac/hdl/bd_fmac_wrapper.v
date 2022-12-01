//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
//Date        : Fri Nov 18 14:53:41 2022
//Host        : if3111linux-16 running 64-bit Ubuntu 20.04.5 LTS
//Command     : generate_target bd_fmac_wrapper.bd
//Design      : bd_fmac_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module bd_fmac_wrapper
   (M_AXIS_RESULT_0_tdata,
    M_AXIS_RESULT_0_tvalid,
    S_AXIS_A_0_tdata,
    S_AXIS_A_0_tvalid,
    S_AXIS_B_0_tdata,
    S_AXIS_B_0_tvalid,
    S_AXIS_C_0_tdata,
    S_AXIS_C_0_tvalid,
    aclk_0);
  output [31:0]M_AXIS_RESULT_0_tdata;
  output M_AXIS_RESULT_0_tvalid;
  input [31:0]S_AXIS_A_0_tdata;
  input S_AXIS_A_0_tvalid;
  input [31:0]S_AXIS_B_0_tdata;
  input S_AXIS_B_0_tvalid;
  input [31:0]S_AXIS_C_0_tdata;
  input S_AXIS_C_0_tvalid;
  input aclk_0;

  wire [31:0]M_AXIS_RESULT_0_tdata;
  wire M_AXIS_RESULT_0_tvalid;
  wire [31:0]S_AXIS_A_0_tdata;
  wire S_AXIS_A_0_tvalid;
  wire [31:0]S_AXIS_B_0_tdata;
  wire S_AXIS_B_0_tvalid;
  wire [31:0]S_AXIS_C_0_tdata;
  wire S_AXIS_C_0_tvalid;
  wire aclk_0;

  bd_fmac bd_fmac_i
       (.M_AXIS_RESULT_0_tdata(M_AXIS_RESULT_0_tdata),
        .M_AXIS_RESULT_0_tvalid(M_AXIS_RESULT_0_tvalid),
        .S_AXIS_A_0_tdata(S_AXIS_A_0_tdata),
        .S_AXIS_A_0_tvalid(S_AXIS_A_0_tvalid),
        .S_AXIS_B_0_tdata(S_AXIS_B_0_tdata),
        .S_AXIS_B_0_tvalid(S_AXIS_B_0_tvalid),
        .S_AXIS_C_0_tdata(S_AXIS_C_0_tdata),
        .S_AXIS_C_0_tvalid(S_AXIS_C_0_tvalid),
        .aclk_0(aclk_0));
endmodule
