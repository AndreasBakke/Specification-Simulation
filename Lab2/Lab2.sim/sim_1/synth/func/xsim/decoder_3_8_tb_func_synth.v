// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Wed Oct  5 21:01:52 2022
// Host        : Andreasb running 64-bit Ubuntu 22.04.1 LTS
// Command     : write_verilog -mode funcsim -nolib -force -file
//               /home/andreasb/Lab2/Lab2.sim/sim_1/synth/func/xsim/decoder_3_8_tb_func_synth.v
// Design      : decoder_3_8
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k70tfbv676-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* NotValidForBitStream *)
module decoder_3_8
   (i,
    o);
  input [2:0]i;
  output [0:7]o;

  wire [2:0]i;
  wire [2:0]i_IBUF;
  wire [0:7]o;
  wire [0:7]o_OBUF;

  IBUF \i_IBUF[0]_inst 
       (.I(i[0]),
        .O(i_IBUF[0]));
  IBUF \i_IBUF[1]_inst 
       (.I(i[1]),
        .O(i_IBUF[1]));
  IBUF \i_IBUF[2]_inst 
       (.I(i[2]),
        .O(i_IBUF[2]));
  OBUF \o_OBUF[0]_inst 
       (.I(o_OBUF[0]),
        .O(o[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \o_OBUF[0]_inst_i_1 
       (.I0(i_IBUF[1]),
        .I1(i_IBUF[2]),
        .I2(i_IBUF[0]),
        .O(o_OBUF[0]));
  OBUF \o_OBUF[1]_inst 
       (.I(o_OBUF[1]),
        .O(o[1]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \o_OBUF[1]_inst_i_1 
       (.I0(i_IBUF[0]),
        .I1(i_IBUF[2]),
        .I2(i_IBUF[1]),
        .O(o_OBUF[1]));
  OBUF \o_OBUF[2]_inst 
       (.I(o_OBUF[2]),
        .O(o[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \o_OBUF[2]_inst_i_1 
       (.I0(i_IBUF[1]),
        .I1(i_IBUF[2]),
        .I2(i_IBUF[0]),
        .O(o_OBUF[2]));
  OBUF \o_OBUF[3]_inst 
       (.I(o_OBUF[3]),
        .O(o[3]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \o_OBUF[3]_inst_i_1 
       (.I0(i_IBUF[0]),
        .I1(i_IBUF[2]),
        .I2(i_IBUF[1]),
        .O(o_OBUF[3]));
  OBUF \o_OBUF[4]_inst 
       (.I(o_OBUF[4]),
        .O(o[4]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \o_OBUF[4]_inst_i_1 
       (.I0(i_IBUF[1]),
        .I1(i_IBUF[2]),
        .I2(i_IBUF[0]),
        .O(o_OBUF[4]));
  OBUF \o_OBUF[5]_inst 
       (.I(o_OBUF[5]),
        .O(o[5]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \o_OBUF[5]_inst_i_1 
       (.I0(i_IBUF[2]),
        .I1(i_IBUF[1]),
        .I2(i_IBUF[0]),
        .O(o_OBUF[5]));
  OBUF \o_OBUF[6]_inst 
       (.I(o_OBUF[6]),
        .O(o[6]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h10)) 
    \o_OBUF[6]_inst_i_1 
       (.I0(i_IBUF[2]),
        .I1(i_IBUF[1]),
        .I2(i_IBUF[0]),
        .O(o_OBUF[6]));
  OBUF \o_OBUF[7]_inst 
       (.I(o_OBUF[7]),
        .O(o[7]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \o_OBUF[7]_inst_i_1 
       (.I0(i_IBUF[1]),
        .I1(i_IBUF[0]),
        .I2(i_IBUF[2]),
        .O(o_OBUF[7]));
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
