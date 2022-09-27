//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
//Date        : Thu Sep 22 17:10:26 2022
//Host        : if3111linux-09 running 64-bit Ubuntu 20.04.5 LTS
//Command     : generate_target bd_bitflip.bd
//Design      : bd_bitflip
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "bd_bitflip,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=bd_bitflip,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}" *) (* HW_HANDOFF = "bd_bitflip.hwdef" *) 
module bd_bitflip
   (ACLK_0,
    ARESETN_0);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ACLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ACLK_0, ASSOCIATED_RESET ARESETN_0, CLK_DOMAIN bd_bitflip_ACLK_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input ACLK_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.ARESETN_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.ARESETN_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input ARESETN_0;

  wire ACLK_0_1;
  wire ARESETN_0_1;
  wire [31:0]axi4stream_vip_0_M_AXIS_TDATA;
  wire axi4stream_vip_0_M_AXIS_TREADY;
  wire [0:0]axi4stream_vip_0_M_AXIS_TVALID;
  wire [31:0]axis_bitflip_0_M_AXIS_TDATA;
  wire [3:0]axis_bitflip_0_M_AXIS_TKEEP;
  wire axis_bitflip_0_M_AXIS_TLAST;
  wire [0:0]axis_bitflip_0_M_AXIS_TREADY;
  wire axis_bitflip_0_M_AXIS_TVALID;

  assign ACLK_0_1 = ACLK_0;
  assign ARESETN_0_1 = ARESETN_0;
  bd_bitflip_axi4stream_vip_0_0 axi4stream_vip_0
       (.aclk(ACLK_0_1),
        .aresetn(ARESETN_0_1),
        .m_axis_tdata(axi4stream_vip_0_M_AXIS_TDATA),
        .m_axis_tready(axi4stream_vip_0_M_AXIS_TREADY),
        .m_axis_tvalid(axi4stream_vip_0_M_AXIS_TVALID));
  bd_bitflip_axi4stream_vip_1_0 axi4stream_vip_1
       (.aclk(ACLK_0_1),
        .aresetn(ARESETN_0_1),
        .s_axis_tdata(axis_bitflip_0_M_AXIS_TDATA),
        .s_axis_tkeep(axis_bitflip_0_M_AXIS_TKEEP),
        .s_axis_tlast(axis_bitflip_0_M_AXIS_TLAST),
        .s_axis_tready(axis_bitflip_0_M_AXIS_TREADY),
        .s_axis_tvalid(axis_bitflip_0_M_AXIS_TVALID));
  bd_bitflip_axis_bitflip_0_0 axis_bitflip_0
       (.ACLK(ACLK_0_1),
        .ARESETN(ARESETN_0_1),
        .M_AXIS_TDATA(axis_bitflip_0_M_AXIS_TDATA),
        .M_AXIS_TKEEP(axis_bitflip_0_M_AXIS_TKEEP),
        .M_AXIS_TLAST(axis_bitflip_0_M_AXIS_TLAST),
        .M_AXIS_TREADY(axis_bitflip_0_M_AXIS_TREADY),
        .M_AXIS_TVALID(axis_bitflip_0_M_AXIS_TVALID),
        .S_AXIS_TDATA(axi4stream_vip_0_M_AXIS_TDATA),
        .S_AXIS_TKEEP({1'b1,1'b1,1'b1,1'b1}),
        .S_AXIS_TLAST(1'b0),
        .S_AXIS_TREADY(axi4stream_vip_0_M_AXIS_TREADY),
        .S_AXIS_TVALID(axi4stream_vip_0_M_AXIS_TVALID));
endmodule
