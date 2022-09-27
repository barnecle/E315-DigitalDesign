//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
//Date        : Thu Sep 22 17:10:26 2022
//Host        : if3111linux-09 running 64-bit Ubuntu 20.04.5 LTS
//Command     : generate_target bd_bitflip_wrapper.bd
//Design      : bd_bitflip_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module bd_bitflip_wrapper
   (ACLK_0,
    ARESETN_0);
  input ACLK_0;
  input ARESETN_0;

  wire ACLK_0;
  wire ARESETN_0;

  bd_bitflip bd_bitflip_i
       (.ACLK_0(ACLK_0),
        .ARESETN_0(ARESETN_0));
endmodule
