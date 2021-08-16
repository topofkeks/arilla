// megafunction wizard: %LPM_DECODE%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: LPM_DECODE 

// ============================================================
// File Name: DC3.v
// Megafunction Name(s):
// 			LPM_DECODE
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 13.1.0 Build 162 10/23/2013 SJ Web Edition
// ************************************************************


//Copyright (C) 1991-2013 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


//lpm_decode DEVICE_FAMILY="Cyclone III" LPM_DECODES=8 LPM_WIDTH=3 data eq
//VERSION_BEGIN 13.1 cbx_cycloneii 2013:10:23:18:05:48:SJ cbx_lpm_add_sub 2013:10:23:18:05:48:SJ cbx_lpm_compare 2013:10:23:18:05:48:SJ cbx_lpm_decode 2013:10:23:18:05:48:SJ cbx_mgl 2013:10:23:18:06:54:SJ cbx_stratix 2013:10:23:18:05:48:SJ cbx_stratixii 2013:10:23:18:05:48:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463


//synthesis_resources = lut 8 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  DC3_decode
	( 
	data,
	eq) /* synthesis synthesis_clearbox=1 */;
	input   [2:0]  data;
	output   [7:0]  eq;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   [2:0]  data;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [2:0]  data_wire;
	wire  [7:0]  eq_node;
	wire  [7:0]  eq_wire;
	wire  [3:0]  w_anode19w;
	wire  [3:0]  w_anode1w;
	wire  [3:0]  w_anode30w;
	wire  [3:0]  w_anode41w;
	wire  [3:0]  w_anode52w;
	wire  [3:0]  w_anode63w;
	wire  [3:0]  w_anode74w;
	wire  [3:0]  w_anode85w;

	assign
		data_wire = data,
		eq = eq_node,
		eq_node = eq_wire[7:0],
		eq_wire = {w_anode85w[3], w_anode74w[3], w_anode63w[3], w_anode52w[3], w_anode41w[3], w_anode30w[3], w_anode19w[3], w_anode1w[3]},
		w_anode19w = {(w_anode19w[2] & (~ data_wire[2])), (w_anode19w[1] & (~ data_wire[1])), (w_anode19w[0] & data_wire[0]), 1'b1},
		w_anode1w = {(w_anode1w[2] & (~ data_wire[2])), (w_anode1w[1] & (~ data_wire[1])), (w_anode1w[0] & (~ data_wire[0])), 1'b1},
		w_anode30w = {(w_anode30w[2] & (~ data_wire[2])), (w_anode30w[1] & data_wire[1]), (w_anode30w[0] & (~ data_wire[0])), 1'b1},
		w_anode41w = {(w_anode41w[2] & (~ data_wire[2])), (w_anode41w[1] & data_wire[1]), (w_anode41w[0] & data_wire[0]), 1'b1},
		w_anode52w = {(w_anode52w[2] & data_wire[2]), (w_anode52w[1] & (~ data_wire[1])), (w_anode52w[0] & (~ data_wire[0])), 1'b1},
		w_anode63w = {(w_anode63w[2] & data_wire[2]), (w_anode63w[1] & (~ data_wire[1])), (w_anode63w[0] & data_wire[0]), 1'b1},
		w_anode74w = {(w_anode74w[2] & data_wire[2]), (w_anode74w[1] & data_wire[1]), (w_anode74w[0] & (~ data_wire[0])), 1'b1},
		w_anode85w = {(w_anode85w[2] & data_wire[2]), (w_anode85w[1] & data_wire[1]), (w_anode85w[0] & data_wire[0]), 1'b1};
endmodule //DC3_decode
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module DC3 (
	data,
	eq1,
	eq2,
	eq3,
	eq4,
	eq5)/* synthesis synthesis_clearbox = 1 */;

	input	[2:0]  data;
	output	  eq1;
	output	  eq2;
	output	  eq3;
	output	  eq4;
	output	  eq5;

	wire [7:0] sub_wire0;
	wire [5:5] sub_wire5 = sub_wire0[5:5];
	wire [3:3] sub_wire4 = sub_wire0[3:3];
	wire [1:1] sub_wire3 = sub_wire0[1:1];
	wire [4:4] sub_wire2 = sub_wire0[4:4];
	wire [2:2] sub_wire1 = sub_wire0[2:2];
	wire  eq2 = sub_wire1;
	wire  eq4 = sub_wire2;
	wire  eq1 = sub_wire3;
	wire  eq3 = sub_wire4;
	wire  eq5 = sub_wire5;

	DC3_decode	DC3_decode_component (
				.data (data),
				.eq (sub_wire0));

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: BaseDec NUMERIC "1"
// Retrieval info: PRIVATE: EnableInput NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
// Retrieval info: PRIVATE: LPM_PIPELINE NUMERIC "0"
// Retrieval info: PRIVATE: Latency NUMERIC "0"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "1"
// Retrieval info: PRIVATE: aclr NUMERIC "0"
// Retrieval info: PRIVATE: clken NUMERIC "0"
// Retrieval info: PRIVATE: eq0 NUMERIC "0"
// Retrieval info: PRIVATE: eq1 NUMERIC "1"
// Retrieval info: PRIVATE: eq2 NUMERIC "1"
// Retrieval info: PRIVATE: eq3 NUMERIC "1"
// Retrieval info: PRIVATE: eq4 NUMERIC "1"
// Retrieval info: PRIVATE: eq5 NUMERIC "1"
// Retrieval info: PRIVATE: eq6 NUMERIC "0"
// Retrieval info: PRIVATE: eq7 NUMERIC "0"
// Retrieval info: PRIVATE: nBit NUMERIC "3"
// Retrieval info: PRIVATE: new_diagram STRING "1"
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: CONSTANT: LPM_DECODES NUMERIC "8"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_DECODE"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "3"
// Retrieval info: USED_PORT: @eq 0 0 8 0 OUTPUT NODEFVAL "@eq[7..0]"
// Retrieval info: USED_PORT: data 0 0 3 0 INPUT NODEFVAL "data[2..0]"
// Retrieval info: USED_PORT: eq1 0 0 0 0 OUTPUT NODEFVAL "eq1"
// Retrieval info: USED_PORT: eq2 0 0 0 0 OUTPUT NODEFVAL "eq2"
// Retrieval info: USED_PORT: eq3 0 0 0 0 OUTPUT NODEFVAL "eq3"
// Retrieval info: USED_PORT: eq4 0 0 0 0 OUTPUT NODEFVAL "eq4"
// Retrieval info: USED_PORT: eq5 0 0 0 0 OUTPUT NODEFVAL "eq5"
// Retrieval info: CONNECT: @data 0 0 3 0 data 0 0 3 0
// Retrieval info: CONNECT: eq1 0 0 0 0 @eq 0 0 1 1
// Retrieval info: CONNECT: eq2 0 0 0 0 @eq 0 0 1 2
// Retrieval info: CONNECT: eq3 0 0 0 0 @eq 0 0 1 3
// Retrieval info: CONNECT: eq4 0 0 0 0 @eq 0 0 1 4
// Retrieval info: CONNECT: eq5 0 0 0 0 @eq 0 0 1 5
// Retrieval info: GEN_FILE: TYPE_NORMAL DC3.vhd TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL DC3.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL DC3.cmp TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL DC3.bsf TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL DC3_inst.vhd FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL DC3_syn.v TRUE
// Retrieval info: LIB_FILE: lpm
