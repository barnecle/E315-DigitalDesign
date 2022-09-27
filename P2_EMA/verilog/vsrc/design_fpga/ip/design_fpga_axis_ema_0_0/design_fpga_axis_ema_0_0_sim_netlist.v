// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Thu Sep 22 17:14:16 2022
// Host        : if3111linux-09 running 64-bit Ubuntu 20.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /nfs/nfs2/home/barnecle/E315-Digital-Design/P2_EMA/verilog/vsrc/design_fpga/ip/design_fpga_axis_ema_0_0/design_fpga_axis_ema_0_0_sim_netlist.v
// Design      : design_fpga_axis_ema_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_fpga_axis_ema_0_0,axis_ema,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "axis_ema,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module design_fpga_axis_ema_0_0
   (ACLK,
    ARESETN,
    S_AXIS_TDATA,
    S_AXIS_TKEEP,
    S_AXIS_TLAST,
    S_AXIS_TVALID,
    S_AXIS_TREADY,
    M_AXIS_TDATA,
    M_AXIS_TKEEP,
    M_AXIS_TLAST,
    M_AXIS_TVALID,
    M_AXIS_TREADY);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ACLK, ASSOCIATED_BUSIF M_AXIS:S_AXIS, ASSOCIATED_RESET ARESETN, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_fpga_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input ACLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input ARESETN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TDATA" *) input [31:0]S_AXIS_TDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TKEEP" *) input [3:0]S_AXIS_TKEEP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TLAST" *) input S_AXIS_TLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TVALID" *) input S_AXIS_TVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_fpga_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0" *) output S_AXIS_TREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TDATA" *) output [31:0]M_AXIS_TDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TKEEP" *) output [3:0]M_AXIS_TKEEP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TLAST" *) output M_AXIS_TLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TVALID" *) output M_AXIS_TVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_fpga_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0" *) input M_AXIS_TREADY;

  wire ACLK;
  wire ARESETN;
  wire [31:0]M_AXIS_TDATA;
  wire M_AXIS_TREADY;
  wire [31:0]S_AXIS_TDATA;
  wire [3:0]S_AXIS_TKEEP;
  wire S_AXIS_TLAST;
  wire S_AXIS_TVALID;

  assign M_AXIS_TKEEP[3:0] = S_AXIS_TKEEP;
  assign M_AXIS_TLAST = S_AXIS_TLAST;
  assign M_AXIS_TVALID = S_AXIS_TVALID;
  assign S_AXIS_TREADY = M_AXIS_TREADY;
  design_fpga_axis_ema_0_0_axis_ema inst
       (.ACLK(ACLK),
        .ARESETN(ARESETN),
        .M_AXIS_TDATA(M_AXIS_TDATA),
        .M_AXIS_TREADY(M_AXIS_TREADY),
        .S_AXIS_TDATA(S_AXIS_TDATA[31:2]),
        .S_AXIS_TVALID(S_AXIS_TVALID));
endmodule

(* ORIG_REF_NAME = "axis_ema" *) 
module design_fpga_axis_ema_0_0_axis_ema
   (M_AXIS_TDATA,
    S_AXIS_TDATA,
    ACLK,
    ARESETN,
    S_AXIS_TVALID,
    M_AXIS_TREADY);
  output [31:0]M_AXIS_TDATA;
  input [29:0]S_AXIS_TDATA;
  input ACLK;
  input ARESETN;
  input S_AXIS_TVALID;
  input M_AXIS_TREADY;

  wire ACLK;
  wire ARESETN;
  wire [31:0]M_AXIS_TDATA;
  wire M_AXIS_TREADY;
  wire [29:0]S_AXIS_TDATA;
  wire S_AXIS_TVALID;

  design_fpga_axis_ema_0_0_axis_ema_sv ema0
       (.ACLK(ACLK),
        .ARESETN(ARESETN),
        .M_AXIS_TDATA(M_AXIS_TDATA),
        .M_AXIS_TREADY(M_AXIS_TREADY),
        .S_AXIS_TDATA(S_AXIS_TDATA),
        .S_AXIS_TVALID(S_AXIS_TVALID));
endmodule

(* ORIG_REF_NAME = "axis_ema_sv" *) 
module design_fpga_axis_ema_0_0_axis_ema_sv
   (M_AXIS_TDATA,
    S_AXIS_TDATA,
    ACLK,
    ARESETN,
    S_AXIS_TVALID,
    M_AXIS_TREADY);
  output [31:0]M_AXIS_TDATA;
  input [29:0]S_AXIS_TDATA;
  input ACLK;
  input ARESETN;
  input S_AXIS_TVALID;
  input M_AXIS_TREADY;

  wire ACLK;
  wire ARESETN;
  wire [31:0]M_AXIS_TDATA;
  wire \M_AXIS_TDATA[0]_INST_0_i_1_n_0 ;
  wire \M_AXIS_TDATA[0]_INST_0_i_2_n_0 ;
  wire \M_AXIS_TDATA[0]_INST_0_i_3_n_0 ;
  wire \M_AXIS_TDATA[0]_INST_0_i_4_n_0 ;
  wire \M_AXIS_TDATA[0]_INST_0_i_5_n_0 ;
  wire \M_AXIS_TDATA[0]_INST_0_i_6_n_0 ;
  wire \M_AXIS_TDATA[0]_INST_0_i_7_n_0 ;
  wire \M_AXIS_TDATA[0]_INST_0_n_0 ;
  wire \M_AXIS_TDATA[0]_INST_0_n_1 ;
  wire \M_AXIS_TDATA[0]_INST_0_n_2 ;
  wire \M_AXIS_TDATA[0]_INST_0_n_3 ;
  wire \M_AXIS_TDATA[12]_INST_0_i_1_n_0 ;
  wire \M_AXIS_TDATA[12]_INST_0_i_2_n_0 ;
  wire \M_AXIS_TDATA[12]_INST_0_i_3_n_0 ;
  wire \M_AXIS_TDATA[12]_INST_0_i_4_n_0 ;
  wire \M_AXIS_TDATA[12]_INST_0_i_5_n_0 ;
  wire \M_AXIS_TDATA[12]_INST_0_i_6_n_0 ;
  wire \M_AXIS_TDATA[12]_INST_0_i_7_n_0 ;
  wire \M_AXIS_TDATA[12]_INST_0_i_8_n_0 ;
  wire \M_AXIS_TDATA[12]_INST_0_n_0 ;
  wire \M_AXIS_TDATA[12]_INST_0_n_1 ;
  wire \M_AXIS_TDATA[12]_INST_0_n_2 ;
  wire \M_AXIS_TDATA[12]_INST_0_n_3 ;
  wire \M_AXIS_TDATA[16]_INST_0_i_1_n_0 ;
  wire \M_AXIS_TDATA[16]_INST_0_i_2_n_0 ;
  wire \M_AXIS_TDATA[16]_INST_0_i_3_n_0 ;
  wire \M_AXIS_TDATA[16]_INST_0_i_4_n_0 ;
  wire \M_AXIS_TDATA[16]_INST_0_i_5_n_0 ;
  wire \M_AXIS_TDATA[16]_INST_0_i_6_n_0 ;
  wire \M_AXIS_TDATA[16]_INST_0_i_7_n_0 ;
  wire \M_AXIS_TDATA[16]_INST_0_i_8_n_0 ;
  wire \M_AXIS_TDATA[16]_INST_0_n_0 ;
  wire \M_AXIS_TDATA[16]_INST_0_n_1 ;
  wire \M_AXIS_TDATA[16]_INST_0_n_2 ;
  wire \M_AXIS_TDATA[16]_INST_0_n_3 ;
  wire \M_AXIS_TDATA[20]_INST_0_i_1_n_0 ;
  wire \M_AXIS_TDATA[20]_INST_0_i_2_n_0 ;
  wire \M_AXIS_TDATA[20]_INST_0_i_3_n_0 ;
  wire \M_AXIS_TDATA[20]_INST_0_i_4_n_0 ;
  wire \M_AXIS_TDATA[20]_INST_0_i_5_n_0 ;
  wire \M_AXIS_TDATA[20]_INST_0_i_6_n_0 ;
  wire \M_AXIS_TDATA[20]_INST_0_i_7_n_0 ;
  wire \M_AXIS_TDATA[20]_INST_0_i_8_n_0 ;
  wire \M_AXIS_TDATA[20]_INST_0_n_0 ;
  wire \M_AXIS_TDATA[20]_INST_0_n_1 ;
  wire \M_AXIS_TDATA[20]_INST_0_n_2 ;
  wire \M_AXIS_TDATA[20]_INST_0_n_3 ;
  wire \M_AXIS_TDATA[24]_INST_0_i_1_n_0 ;
  wire \M_AXIS_TDATA[24]_INST_0_i_2_n_0 ;
  wire \M_AXIS_TDATA[24]_INST_0_i_3_n_0 ;
  wire \M_AXIS_TDATA[24]_INST_0_i_4_n_0 ;
  wire \M_AXIS_TDATA[24]_INST_0_i_5_n_0 ;
  wire \M_AXIS_TDATA[24]_INST_0_i_6_n_0 ;
  wire \M_AXIS_TDATA[24]_INST_0_i_7_n_0 ;
  wire \M_AXIS_TDATA[24]_INST_0_i_8_n_0 ;
  wire \M_AXIS_TDATA[24]_INST_0_n_0 ;
  wire \M_AXIS_TDATA[24]_INST_0_n_1 ;
  wire \M_AXIS_TDATA[24]_INST_0_n_2 ;
  wire \M_AXIS_TDATA[24]_INST_0_n_3 ;
  wire \M_AXIS_TDATA[28]_INST_0_i_1_n_0 ;
  wire \M_AXIS_TDATA[28]_INST_0_i_2_n_0 ;
  wire \M_AXIS_TDATA[28]_INST_0_i_3_n_0 ;
  wire \M_AXIS_TDATA[28]_INST_0_i_4_n_0 ;
  wire \M_AXIS_TDATA[28]_INST_0_i_5_n_0 ;
  wire \M_AXIS_TDATA[28]_INST_0_i_6_n_0 ;
  wire \M_AXIS_TDATA[28]_INST_0_i_7_n_0 ;
  wire \M_AXIS_TDATA[28]_INST_0_n_1 ;
  wire \M_AXIS_TDATA[28]_INST_0_n_2 ;
  wire \M_AXIS_TDATA[28]_INST_0_n_3 ;
  wire \M_AXIS_TDATA[4]_INST_0_i_1_n_0 ;
  wire \M_AXIS_TDATA[4]_INST_0_i_2_n_0 ;
  wire \M_AXIS_TDATA[4]_INST_0_i_3_n_0 ;
  wire \M_AXIS_TDATA[4]_INST_0_i_4_n_0 ;
  wire \M_AXIS_TDATA[4]_INST_0_i_5_n_0 ;
  wire \M_AXIS_TDATA[4]_INST_0_i_6_n_0 ;
  wire \M_AXIS_TDATA[4]_INST_0_i_7_n_0 ;
  wire \M_AXIS_TDATA[4]_INST_0_i_8_n_0 ;
  wire \M_AXIS_TDATA[4]_INST_0_n_0 ;
  wire \M_AXIS_TDATA[4]_INST_0_n_1 ;
  wire \M_AXIS_TDATA[4]_INST_0_n_2 ;
  wire \M_AXIS_TDATA[4]_INST_0_n_3 ;
  wire \M_AXIS_TDATA[8]_INST_0_i_1_n_0 ;
  wire \M_AXIS_TDATA[8]_INST_0_i_2_n_0 ;
  wire \M_AXIS_TDATA[8]_INST_0_i_3_n_0 ;
  wire \M_AXIS_TDATA[8]_INST_0_i_4_n_0 ;
  wire \M_AXIS_TDATA[8]_INST_0_i_5_n_0 ;
  wire \M_AXIS_TDATA[8]_INST_0_i_6_n_0 ;
  wire \M_AXIS_TDATA[8]_INST_0_i_7_n_0 ;
  wire \M_AXIS_TDATA[8]_INST_0_i_8_n_0 ;
  wire \M_AXIS_TDATA[8]_INST_0_n_0 ;
  wire \M_AXIS_TDATA[8]_INST_0_n_1 ;
  wire \M_AXIS_TDATA[8]_INST_0_n_2 ;
  wire \M_AXIS_TDATA[8]_INST_0_n_3 ;
  wire M_AXIS_TREADY;
  wire [29:0]S_AXIS_TDATA;
  wire S_AXIS_TVALID;
  wire [31:1]old_y;
  wire \old_y[31]_i_2_n_0 ;
  wire p_0_in;
  wire [3:3]\NLW_M_AXIS_TDATA[28]_INST_0_CO_UNCONNECTED ;

  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \M_AXIS_TDATA[0]_INST_0 
       (.CI(1'b0),
        .CO({\M_AXIS_TDATA[0]_INST_0_n_0 ,\M_AXIS_TDATA[0]_INST_0_n_1 ,\M_AXIS_TDATA[0]_INST_0_n_2 ,\M_AXIS_TDATA[0]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({\M_AXIS_TDATA[0]_INST_0_i_1_n_0 ,\M_AXIS_TDATA[0]_INST_0_i_2_n_0 ,\M_AXIS_TDATA[0]_INST_0_i_3_n_0 ,S_AXIS_TDATA[0]}),
        .O(M_AXIS_TDATA[3:0]),
        .S({\M_AXIS_TDATA[0]_INST_0_i_4_n_0 ,\M_AXIS_TDATA[0]_INST_0_i_5_n_0 ,\M_AXIS_TDATA[0]_INST_0_i_6_n_0 ,\M_AXIS_TDATA[0]_INST_0_i_7_n_0 }));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[0]_INST_0_i_1 
       (.I0(old_y[4]),
        .I1(old_y[2]),
        .I2(S_AXIS_TDATA[2]),
        .O(\M_AXIS_TDATA[0]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h69)) 
    \M_AXIS_TDATA[0]_INST_0_i_2 
       (.I0(old_y[2]),
        .I1(old_y[4]),
        .I2(S_AXIS_TDATA[2]),
        .O(\M_AXIS_TDATA[0]_INST_0_i_2_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \M_AXIS_TDATA[0]_INST_0_i_3 
       (.I0(old_y[1]),
        .I1(old_y[2]),
        .O(\M_AXIS_TDATA[0]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[0]_INST_0_i_4 
       (.I0(S_AXIS_TDATA[2]),
        .I1(old_y[2]),
        .I2(old_y[4]),
        .I3(old_y[3]),
        .I4(old_y[5]),
        .I5(S_AXIS_TDATA[3]),
        .O(\M_AXIS_TDATA[0]_INST_0_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h69966969)) 
    \M_AXIS_TDATA[0]_INST_0_i_5 
       (.I0(old_y[2]),
        .I1(old_y[4]),
        .I2(S_AXIS_TDATA[2]),
        .I3(old_y[3]),
        .I4(S_AXIS_TDATA[1]),
        .O(\M_AXIS_TDATA[0]_INST_0_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h2DD2)) 
    \M_AXIS_TDATA[0]_INST_0_i_6 
       (.I0(old_y[2]),
        .I1(old_y[1]),
        .I2(old_y[3]),
        .I3(S_AXIS_TDATA[1]),
        .O(\M_AXIS_TDATA[0]_INST_0_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \M_AXIS_TDATA[0]_INST_0_i_7 
       (.I0(old_y[2]),
        .I1(old_y[1]),
        .I2(S_AXIS_TDATA[0]),
        .O(\M_AXIS_TDATA[0]_INST_0_i_7_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \M_AXIS_TDATA[12]_INST_0 
       (.CI(\M_AXIS_TDATA[8]_INST_0_n_0 ),
        .CO({\M_AXIS_TDATA[12]_INST_0_n_0 ,\M_AXIS_TDATA[12]_INST_0_n_1 ,\M_AXIS_TDATA[12]_INST_0_n_2 ,\M_AXIS_TDATA[12]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({\M_AXIS_TDATA[12]_INST_0_i_1_n_0 ,\M_AXIS_TDATA[12]_INST_0_i_2_n_0 ,\M_AXIS_TDATA[12]_INST_0_i_3_n_0 ,\M_AXIS_TDATA[12]_INST_0_i_4_n_0 }),
        .O(M_AXIS_TDATA[15:12]),
        .S({\M_AXIS_TDATA[12]_INST_0_i_5_n_0 ,\M_AXIS_TDATA[12]_INST_0_i_6_n_0 ,\M_AXIS_TDATA[12]_INST_0_i_7_n_0 ,\M_AXIS_TDATA[12]_INST_0_i_8_n_0 }));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[12]_INST_0_i_1 
       (.I0(old_y[16]),
        .I1(old_y[14]),
        .I2(S_AXIS_TDATA[14]),
        .O(\M_AXIS_TDATA[12]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[12]_INST_0_i_2 
       (.I0(old_y[15]),
        .I1(old_y[13]),
        .I2(S_AXIS_TDATA[13]),
        .O(\M_AXIS_TDATA[12]_INST_0_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[12]_INST_0_i_3 
       (.I0(old_y[14]),
        .I1(old_y[12]),
        .I2(S_AXIS_TDATA[12]),
        .O(\M_AXIS_TDATA[12]_INST_0_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[12]_INST_0_i_4 
       (.I0(old_y[13]),
        .I1(old_y[11]),
        .I2(S_AXIS_TDATA[11]),
        .O(\M_AXIS_TDATA[12]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[12]_INST_0_i_5 
       (.I0(S_AXIS_TDATA[14]),
        .I1(old_y[14]),
        .I2(old_y[16]),
        .I3(old_y[15]),
        .I4(old_y[17]),
        .I5(S_AXIS_TDATA[15]),
        .O(\M_AXIS_TDATA[12]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[12]_INST_0_i_6 
       (.I0(S_AXIS_TDATA[13]),
        .I1(old_y[13]),
        .I2(old_y[15]),
        .I3(old_y[14]),
        .I4(old_y[16]),
        .I5(S_AXIS_TDATA[14]),
        .O(\M_AXIS_TDATA[12]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[12]_INST_0_i_7 
       (.I0(S_AXIS_TDATA[12]),
        .I1(old_y[12]),
        .I2(old_y[14]),
        .I3(old_y[13]),
        .I4(old_y[15]),
        .I5(S_AXIS_TDATA[13]),
        .O(\M_AXIS_TDATA[12]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[12]_INST_0_i_8 
       (.I0(S_AXIS_TDATA[11]),
        .I1(old_y[11]),
        .I2(old_y[13]),
        .I3(old_y[12]),
        .I4(old_y[14]),
        .I5(S_AXIS_TDATA[12]),
        .O(\M_AXIS_TDATA[12]_INST_0_i_8_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \M_AXIS_TDATA[16]_INST_0 
       (.CI(\M_AXIS_TDATA[12]_INST_0_n_0 ),
        .CO({\M_AXIS_TDATA[16]_INST_0_n_0 ,\M_AXIS_TDATA[16]_INST_0_n_1 ,\M_AXIS_TDATA[16]_INST_0_n_2 ,\M_AXIS_TDATA[16]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({\M_AXIS_TDATA[16]_INST_0_i_1_n_0 ,\M_AXIS_TDATA[16]_INST_0_i_2_n_0 ,\M_AXIS_TDATA[16]_INST_0_i_3_n_0 ,\M_AXIS_TDATA[16]_INST_0_i_4_n_0 }),
        .O(M_AXIS_TDATA[19:16]),
        .S({\M_AXIS_TDATA[16]_INST_0_i_5_n_0 ,\M_AXIS_TDATA[16]_INST_0_i_6_n_0 ,\M_AXIS_TDATA[16]_INST_0_i_7_n_0 ,\M_AXIS_TDATA[16]_INST_0_i_8_n_0 }));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[16]_INST_0_i_1 
       (.I0(old_y[20]),
        .I1(old_y[18]),
        .I2(S_AXIS_TDATA[18]),
        .O(\M_AXIS_TDATA[16]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[16]_INST_0_i_2 
       (.I0(old_y[19]),
        .I1(old_y[17]),
        .I2(S_AXIS_TDATA[17]),
        .O(\M_AXIS_TDATA[16]_INST_0_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[16]_INST_0_i_3 
       (.I0(old_y[18]),
        .I1(old_y[16]),
        .I2(S_AXIS_TDATA[16]),
        .O(\M_AXIS_TDATA[16]_INST_0_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[16]_INST_0_i_4 
       (.I0(old_y[17]),
        .I1(old_y[15]),
        .I2(S_AXIS_TDATA[15]),
        .O(\M_AXIS_TDATA[16]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[16]_INST_0_i_5 
       (.I0(S_AXIS_TDATA[18]),
        .I1(old_y[18]),
        .I2(old_y[20]),
        .I3(old_y[19]),
        .I4(old_y[21]),
        .I5(S_AXIS_TDATA[19]),
        .O(\M_AXIS_TDATA[16]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[16]_INST_0_i_6 
       (.I0(S_AXIS_TDATA[17]),
        .I1(old_y[17]),
        .I2(old_y[19]),
        .I3(old_y[18]),
        .I4(old_y[20]),
        .I5(S_AXIS_TDATA[18]),
        .O(\M_AXIS_TDATA[16]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[16]_INST_0_i_7 
       (.I0(S_AXIS_TDATA[16]),
        .I1(old_y[16]),
        .I2(old_y[18]),
        .I3(old_y[17]),
        .I4(old_y[19]),
        .I5(S_AXIS_TDATA[17]),
        .O(\M_AXIS_TDATA[16]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[16]_INST_0_i_8 
       (.I0(S_AXIS_TDATA[15]),
        .I1(old_y[15]),
        .I2(old_y[17]),
        .I3(old_y[16]),
        .I4(old_y[18]),
        .I5(S_AXIS_TDATA[16]),
        .O(\M_AXIS_TDATA[16]_INST_0_i_8_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \M_AXIS_TDATA[20]_INST_0 
       (.CI(\M_AXIS_TDATA[16]_INST_0_n_0 ),
        .CO({\M_AXIS_TDATA[20]_INST_0_n_0 ,\M_AXIS_TDATA[20]_INST_0_n_1 ,\M_AXIS_TDATA[20]_INST_0_n_2 ,\M_AXIS_TDATA[20]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({\M_AXIS_TDATA[20]_INST_0_i_1_n_0 ,\M_AXIS_TDATA[20]_INST_0_i_2_n_0 ,\M_AXIS_TDATA[20]_INST_0_i_3_n_0 ,\M_AXIS_TDATA[20]_INST_0_i_4_n_0 }),
        .O(M_AXIS_TDATA[23:20]),
        .S({\M_AXIS_TDATA[20]_INST_0_i_5_n_0 ,\M_AXIS_TDATA[20]_INST_0_i_6_n_0 ,\M_AXIS_TDATA[20]_INST_0_i_7_n_0 ,\M_AXIS_TDATA[20]_INST_0_i_8_n_0 }));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[20]_INST_0_i_1 
       (.I0(old_y[24]),
        .I1(old_y[22]),
        .I2(S_AXIS_TDATA[22]),
        .O(\M_AXIS_TDATA[20]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[20]_INST_0_i_2 
       (.I0(old_y[23]),
        .I1(old_y[21]),
        .I2(S_AXIS_TDATA[21]),
        .O(\M_AXIS_TDATA[20]_INST_0_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[20]_INST_0_i_3 
       (.I0(old_y[22]),
        .I1(old_y[20]),
        .I2(S_AXIS_TDATA[20]),
        .O(\M_AXIS_TDATA[20]_INST_0_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[20]_INST_0_i_4 
       (.I0(old_y[21]),
        .I1(old_y[19]),
        .I2(S_AXIS_TDATA[19]),
        .O(\M_AXIS_TDATA[20]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[20]_INST_0_i_5 
       (.I0(S_AXIS_TDATA[22]),
        .I1(old_y[22]),
        .I2(old_y[24]),
        .I3(old_y[23]),
        .I4(old_y[25]),
        .I5(S_AXIS_TDATA[23]),
        .O(\M_AXIS_TDATA[20]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[20]_INST_0_i_6 
       (.I0(S_AXIS_TDATA[21]),
        .I1(old_y[21]),
        .I2(old_y[23]),
        .I3(old_y[22]),
        .I4(old_y[24]),
        .I5(S_AXIS_TDATA[22]),
        .O(\M_AXIS_TDATA[20]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[20]_INST_0_i_7 
       (.I0(S_AXIS_TDATA[20]),
        .I1(old_y[20]),
        .I2(old_y[22]),
        .I3(old_y[21]),
        .I4(old_y[23]),
        .I5(S_AXIS_TDATA[21]),
        .O(\M_AXIS_TDATA[20]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[20]_INST_0_i_8 
       (.I0(S_AXIS_TDATA[19]),
        .I1(old_y[19]),
        .I2(old_y[21]),
        .I3(old_y[20]),
        .I4(old_y[22]),
        .I5(S_AXIS_TDATA[20]),
        .O(\M_AXIS_TDATA[20]_INST_0_i_8_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \M_AXIS_TDATA[24]_INST_0 
       (.CI(\M_AXIS_TDATA[20]_INST_0_n_0 ),
        .CO({\M_AXIS_TDATA[24]_INST_0_n_0 ,\M_AXIS_TDATA[24]_INST_0_n_1 ,\M_AXIS_TDATA[24]_INST_0_n_2 ,\M_AXIS_TDATA[24]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({\M_AXIS_TDATA[24]_INST_0_i_1_n_0 ,\M_AXIS_TDATA[24]_INST_0_i_2_n_0 ,\M_AXIS_TDATA[24]_INST_0_i_3_n_0 ,\M_AXIS_TDATA[24]_INST_0_i_4_n_0 }),
        .O(M_AXIS_TDATA[27:24]),
        .S({\M_AXIS_TDATA[24]_INST_0_i_5_n_0 ,\M_AXIS_TDATA[24]_INST_0_i_6_n_0 ,\M_AXIS_TDATA[24]_INST_0_i_7_n_0 ,\M_AXIS_TDATA[24]_INST_0_i_8_n_0 }));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[24]_INST_0_i_1 
       (.I0(old_y[28]),
        .I1(old_y[26]),
        .I2(S_AXIS_TDATA[26]),
        .O(\M_AXIS_TDATA[24]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[24]_INST_0_i_2 
       (.I0(old_y[27]),
        .I1(old_y[25]),
        .I2(S_AXIS_TDATA[25]),
        .O(\M_AXIS_TDATA[24]_INST_0_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[24]_INST_0_i_3 
       (.I0(old_y[26]),
        .I1(old_y[24]),
        .I2(S_AXIS_TDATA[24]),
        .O(\M_AXIS_TDATA[24]_INST_0_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[24]_INST_0_i_4 
       (.I0(old_y[25]),
        .I1(old_y[23]),
        .I2(S_AXIS_TDATA[23]),
        .O(\M_AXIS_TDATA[24]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[24]_INST_0_i_5 
       (.I0(S_AXIS_TDATA[26]),
        .I1(old_y[26]),
        .I2(old_y[28]),
        .I3(old_y[27]),
        .I4(old_y[29]),
        .I5(S_AXIS_TDATA[27]),
        .O(\M_AXIS_TDATA[24]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[24]_INST_0_i_6 
       (.I0(S_AXIS_TDATA[25]),
        .I1(old_y[25]),
        .I2(old_y[27]),
        .I3(old_y[26]),
        .I4(old_y[28]),
        .I5(S_AXIS_TDATA[26]),
        .O(\M_AXIS_TDATA[24]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[24]_INST_0_i_7 
       (.I0(S_AXIS_TDATA[24]),
        .I1(old_y[24]),
        .I2(old_y[26]),
        .I3(old_y[25]),
        .I4(old_y[27]),
        .I5(S_AXIS_TDATA[25]),
        .O(\M_AXIS_TDATA[24]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[24]_INST_0_i_8 
       (.I0(S_AXIS_TDATA[23]),
        .I1(old_y[23]),
        .I2(old_y[25]),
        .I3(old_y[24]),
        .I4(old_y[26]),
        .I5(S_AXIS_TDATA[24]),
        .O(\M_AXIS_TDATA[24]_INST_0_i_8_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \M_AXIS_TDATA[28]_INST_0 
       (.CI(\M_AXIS_TDATA[24]_INST_0_n_0 ),
        .CO({\NLW_M_AXIS_TDATA[28]_INST_0_CO_UNCONNECTED [3],\M_AXIS_TDATA[28]_INST_0_n_1 ,\M_AXIS_TDATA[28]_INST_0_n_2 ,\M_AXIS_TDATA[28]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\M_AXIS_TDATA[28]_INST_0_i_1_n_0 ,\M_AXIS_TDATA[28]_INST_0_i_2_n_0 ,\M_AXIS_TDATA[28]_INST_0_i_3_n_0 }),
        .O(M_AXIS_TDATA[31:28]),
        .S({\M_AXIS_TDATA[28]_INST_0_i_4_n_0 ,\M_AXIS_TDATA[28]_INST_0_i_5_n_0 ,\M_AXIS_TDATA[28]_INST_0_i_6_n_0 ,\M_AXIS_TDATA[28]_INST_0_i_7_n_0 }));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[28]_INST_0_i_1 
       (.I0(old_y[31]),
        .I1(old_y[29]),
        .I2(S_AXIS_TDATA[29]),
        .O(\M_AXIS_TDATA[28]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[28]_INST_0_i_2 
       (.I0(old_y[30]),
        .I1(old_y[28]),
        .I2(S_AXIS_TDATA[28]),
        .O(\M_AXIS_TDATA[28]_INST_0_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[28]_INST_0_i_3 
       (.I0(old_y[29]),
        .I1(old_y[27]),
        .I2(S_AXIS_TDATA[27]),
        .O(\M_AXIS_TDATA[28]_INST_0_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \M_AXIS_TDATA[28]_INST_0_i_4 
       (.I0(old_y[30]),
        .I1(old_y[31]),
        .O(\M_AXIS_TDATA[28]_INST_0_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h8E71)) 
    \M_AXIS_TDATA[28]_INST_0_i_5 
       (.I0(S_AXIS_TDATA[29]),
        .I1(old_y[29]),
        .I2(old_y[31]),
        .I3(old_y[30]),
        .O(\M_AXIS_TDATA[28]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[28]_INST_0_i_6 
       (.I0(S_AXIS_TDATA[28]),
        .I1(old_y[28]),
        .I2(old_y[30]),
        .I3(old_y[29]),
        .I4(old_y[31]),
        .I5(S_AXIS_TDATA[29]),
        .O(\M_AXIS_TDATA[28]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[28]_INST_0_i_7 
       (.I0(S_AXIS_TDATA[27]),
        .I1(old_y[27]),
        .I2(old_y[29]),
        .I3(old_y[28]),
        .I4(old_y[30]),
        .I5(S_AXIS_TDATA[28]),
        .O(\M_AXIS_TDATA[28]_INST_0_i_7_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \M_AXIS_TDATA[4]_INST_0 
       (.CI(\M_AXIS_TDATA[0]_INST_0_n_0 ),
        .CO({\M_AXIS_TDATA[4]_INST_0_n_0 ,\M_AXIS_TDATA[4]_INST_0_n_1 ,\M_AXIS_TDATA[4]_INST_0_n_2 ,\M_AXIS_TDATA[4]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({\M_AXIS_TDATA[4]_INST_0_i_1_n_0 ,\M_AXIS_TDATA[4]_INST_0_i_2_n_0 ,\M_AXIS_TDATA[4]_INST_0_i_3_n_0 ,\M_AXIS_TDATA[4]_INST_0_i_4_n_0 }),
        .O(M_AXIS_TDATA[7:4]),
        .S({\M_AXIS_TDATA[4]_INST_0_i_5_n_0 ,\M_AXIS_TDATA[4]_INST_0_i_6_n_0 ,\M_AXIS_TDATA[4]_INST_0_i_7_n_0 ,\M_AXIS_TDATA[4]_INST_0_i_8_n_0 }));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[4]_INST_0_i_1 
       (.I0(old_y[8]),
        .I1(old_y[6]),
        .I2(S_AXIS_TDATA[6]),
        .O(\M_AXIS_TDATA[4]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[4]_INST_0_i_2 
       (.I0(old_y[7]),
        .I1(old_y[5]),
        .I2(S_AXIS_TDATA[5]),
        .O(\M_AXIS_TDATA[4]_INST_0_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[4]_INST_0_i_3 
       (.I0(old_y[6]),
        .I1(old_y[4]),
        .I2(S_AXIS_TDATA[4]),
        .O(\M_AXIS_TDATA[4]_INST_0_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[4]_INST_0_i_4 
       (.I0(old_y[5]),
        .I1(old_y[3]),
        .I2(S_AXIS_TDATA[3]),
        .O(\M_AXIS_TDATA[4]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[4]_INST_0_i_5 
       (.I0(S_AXIS_TDATA[6]),
        .I1(old_y[6]),
        .I2(old_y[8]),
        .I3(old_y[7]),
        .I4(old_y[9]),
        .I5(S_AXIS_TDATA[7]),
        .O(\M_AXIS_TDATA[4]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[4]_INST_0_i_6 
       (.I0(S_AXIS_TDATA[5]),
        .I1(old_y[5]),
        .I2(old_y[7]),
        .I3(old_y[6]),
        .I4(old_y[8]),
        .I5(S_AXIS_TDATA[6]),
        .O(\M_AXIS_TDATA[4]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[4]_INST_0_i_7 
       (.I0(S_AXIS_TDATA[4]),
        .I1(old_y[4]),
        .I2(old_y[6]),
        .I3(old_y[5]),
        .I4(old_y[7]),
        .I5(S_AXIS_TDATA[5]),
        .O(\M_AXIS_TDATA[4]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[4]_INST_0_i_8 
       (.I0(S_AXIS_TDATA[3]),
        .I1(old_y[3]),
        .I2(old_y[5]),
        .I3(old_y[4]),
        .I4(old_y[6]),
        .I5(S_AXIS_TDATA[4]),
        .O(\M_AXIS_TDATA[4]_INST_0_i_8_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \M_AXIS_TDATA[8]_INST_0 
       (.CI(\M_AXIS_TDATA[4]_INST_0_n_0 ),
        .CO({\M_AXIS_TDATA[8]_INST_0_n_0 ,\M_AXIS_TDATA[8]_INST_0_n_1 ,\M_AXIS_TDATA[8]_INST_0_n_2 ,\M_AXIS_TDATA[8]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({\M_AXIS_TDATA[8]_INST_0_i_1_n_0 ,\M_AXIS_TDATA[8]_INST_0_i_2_n_0 ,\M_AXIS_TDATA[8]_INST_0_i_3_n_0 ,\M_AXIS_TDATA[8]_INST_0_i_4_n_0 }),
        .O(M_AXIS_TDATA[11:8]),
        .S({\M_AXIS_TDATA[8]_INST_0_i_5_n_0 ,\M_AXIS_TDATA[8]_INST_0_i_6_n_0 ,\M_AXIS_TDATA[8]_INST_0_i_7_n_0 ,\M_AXIS_TDATA[8]_INST_0_i_8_n_0 }));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[8]_INST_0_i_1 
       (.I0(old_y[12]),
        .I1(old_y[10]),
        .I2(S_AXIS_TDATA[10]),
        .O(\M_AXIS_TDATA[8]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[8]_INST_0_i_2 
       (.I0(old_y[11]),
        .I1(old_y[9]),
        .I2(S_AXIS_TDATA[9]),
        .O(\M_AXIS_TDATA[8]_INST_0_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[8]_INST_0_i_3 
       (.I0(old_y[10]),
        .I1(old_y[8]),
        .I2(S_AXIS_TDATA[8]),
        .O(\M_AXIS_TDATA[8]_INST_0_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hD4)) 
    \M_AXIS_TDATA[8]_INST_0_i_4 
       (.I0(old_y[9]),
        .I1(old_y[7]),
        .I2(S_AXIS_TDATA[7]),
        .O(\M_AXIS_TDATA[8]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[8]_INST_0_i_5 
       (.I0(S_AXIS_TDATA[10]),
        .I1(old_y[10]),
        .I2(old_y[12]),
        .I3(old_y[11]),
        .I4(old_y[13]),
        .I5(S_AXIS_TDATA[11]),
        .O(\M_AXIS_TDATA[8]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[8]_INST_0_i_6 
       (.I0(S_AXIS_TDATA[9]),
        .I1(old_y[9]),
        .I2(old_y[11]),
        .I3(old_y[10]),
        .I4(old_y[12]),
        .I5(S_AXIS_TDATA[10]),
        .O(\M_AXIS_TDATA[8]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[8]_INST_0_i_7 
       (.I0(S_AXIS_TDATA[8]),
        .I1(old_y[8]),
        .I2(old_y[10]),
        .I3(old_y[9]),
        .I4(old_y[11]),
        .I5(S_AXIS_TDATA[9]),
        .O(\M_AXIS_TDATA[8]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h8E71718E718E8E71)) 
    \M_AXIS_TDATA[8]_INST_0_i_8 
       (.I0(S_AXIS_TDATA[7]),
        .I1(old_y[7]),
        .I2(old_y[9]),
        .I3(old_y[8]),
        .I4(old_y[10]),
        .I5(S_AXIS_TDATA[8]),
        .O(\M_AXIS_TDATA[8]_INST_0_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \old_y[31]_i_1 
       (.I0(ARESETN),
        .O(p_0_in));
  LUT2 #(
    .INIT(4'h8)) 
    \old_y[31]_i_2 
       (.I0(S_AXIS_TVALID),
        .I1(M_AXIS_TREADY),
        .O(\old_y[31]_i_2_n_0 ));
  FDRE \old_y_reg[10] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[10]),
        .Q(old_y[10]),
        .R(p_0_in));
  FDRE \old_y_reg[11] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[11]),
        .Q(old_y[11]),
        .R(p_0_in));
  FDRE \old_y_reg[12] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[12]),
        .Q(old_y[12]),
        .R(p_0_in));
  FDRE \old_y_reg[13] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[13]),
        .Q(old_y[13]),
        .R(p_0_in));
  FDRE \old_y_reg[14] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[14]),
        .Q(old_y[14]),
        .R(p_0_in));
  FDRE \old_y_reg[15] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[15]),
        .Q(old_y[15]),
        .R(p_0_in));
  FDRE \old_y_reg[16] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[16]),
        .Q(old_y[16]),
        .R(p_0_in));
  FDRE \old_y_reg[17] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[17]),
        .Q(old_y[17]),
        .R(p_0_in));
  FDRE \old_y_reg[18] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[18]),
        .Q(old_y[18]),
        .R(p_0_in));
  FDRE \old_y_reg[19] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[19]),
        .Q(old_y[19]),
        .R(p_0_in));
  FDRE \old_y_reg[1] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[1]),
        .Q(old_y[1]),
        .R(p_0_in));
  FDRE \old_y_reg[20] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[20]),
        .Q(old_y[20]),
        .R(p_0_in));
  FDRE \old_y_reg[21] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[21]),
        .Q(old_y[21]),
        .R(p_0_in));
  FDRE \old_y_reg[22] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[22]),
        .Q(old_y[22]),
        .R(p_0_in));
  FDRE \old_y_reg[23] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[23]),
        .Q(old_y[23]),
        .R(p_0_in));
  FDRE \old_y_reg[24] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[24]),
        .Q(old_y[24]),
        .R(p_0_in));
  FDRE \old_y_reg[25] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[25]),
        .Q(old_y[25]),
        .R(p_0_in));
  FDRE \old_y_reg[26] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[26]),
        .Q(old_y[26]),
        .R(p_0_in));
  FDRE \old_y_reg[27] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[27]),
        .Q(old_y[27]),
        .R(p_0_in));
  FDRE \old_y_reg[28] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[28]),
        .Q(old_y[28]),
        .R(p_0_in));
  FDRE \old_y_reg[29] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[29]),
        .Q(old_y[29]),
        .R(p_0_in));
  FDRE \old_y_reg[2] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[2]),
        .Q(old_y[2]),
        .R(p_0_in));
  FDRE \old_y_reg[30] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[30]),
        .Q(old_y[30]),
        .R(p_0_in));
  FDRE \old_y_reg[31] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[31]),
        .Q(old_y[31]),
        .R(p_0_in));
  FDSE \old_y_reg[3] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[3]),
        .Q(old_y[3]),
        .S(p_0_in));
  FDRE \old_y_reg[4] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[4]),
        .Q(old_y[4]),
        .R(p_0_in));
  FDSE \old_y_reg[5] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[5]),
        .Q(old_y[5]),
        .S(p_0_in));
  FDSE \old_y_reg[6] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[6]),
        .Q(old_y[6]),
        .S(p_0_in));
  FDSE \old_y_reg[7] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[7]),
        .Q(old_y[7]),
        .S(p_0_in));
  FDSE \old_y_reg[8] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[8]),
        .Q(old_y[8]),
        .S(p_0_in));
  FDSE \old_y_reg[9] 
       (.C(ACLK),
        .CE(\old_y[31]_i_2_n_0 ),
        .D(M_AXIS_TDATA[9]),
        .Q(old_y[9]),
        .S(p_0_in));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
