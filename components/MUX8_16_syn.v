// megafunction wizard: %LPM_MUX%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: LPM_MUX 

// ============================================================
// File Name: MUX8_16.v
// Megafunction Name(s):
// 			LPM_MUX
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


//lpm_mux DEVICE_FAMILY="Cyclone III" LPM_SIZE=8 LPM_WIDTH=16 LPM_WIDTHS=3 data result sel
//VERSION_BEGIN 13.1 cbx_lpm_mux 2013:10:23:18:05:48:SJ cbx_mgl 2013:10:23:18:06:54:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463


//synthesis_resources = lut 80 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  MUX8_16_mux
	( 
	data,
	result,
	sel) /* synthesis synthesis_clearbox=1 */;
	input   [127:0]  data;
	output   [15:0]  result;
	input   [2:0]  sel;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   [127:0]  data;
	tri0   [2:0]  sel;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [15:0]  result_node;
	wire  [2:0]  sel_ffs_wire;
	wire  [2:0]  sel_node;
	wire  [3:0]  w_data1000w;
	wire  [3:0]  w_data102w;
	wire  [3:0]  w_data103w;
	wire  [7:0]  w_data1046w;
	wire  [3:0]  w_data1068w;
	wire  [3:0]  w_data1069w;
	wire  [7:0]  w_data149w;
	wire  [3:0]  w_data171w;
	wire  [3:0]  w_data172w;
	wire  [7:0]  w_data218w;
	wire  [3:0]  w_data240w;
	wire  [3:0]  w_data241w;
	wire  [7:0]  w_data287w;
	wire  [3:0]  w_data309w;
	wire  [3:0]  w_data310w;
	wire  [3:0]  w_data31w;
	wire  [3:0]  w_data32w;
	wire  [7:0]  w_data356w;
	wire  [3:0]  w_data378w;
	wire  [3:0]  w_data379w;
	wire  [7:0]  w_data425w;
	wire  [3:0]  w_data447w;
	wire  [3:0]  w_data448w;
	wire  [7:0]  w_data494w;
	wire  [3:0]  w_data516w;
	wire  [3:0]  w_data517w;
	wire  [7:0]  w_data563w;
	wire  [3:0]  w_data585w;
	wire  [3:0]  w_data586w;
	wire  [7:0]  w_data632w;
	wire  [3:0]  w_data654w;
	wire  [3:0]  w_data655w;
	wire  [7:0]  w_data701w;
	wire  [3:0]  w_data723w;
	wire  [3:0]  w_data724w;
	wire  [7:0]  w_data770w;
	wire  [3:0]  w_data792w;
	wire  [3:0]  w_data793w;
	wire  [7:0]  w_data80w;
	wire  [7:0]  w_data839w;
	wire  [3:0]  w_data861w;
	wire  [3:0]  w_data862w;
	wire  [7:0]  w_data908w;
	wire  [3:0]  w_data930w;
	wire  [3:0]  w_data931w;
	wire  [7:0]  w_data977w;
	wire  [3:0]  w_data999w;
	wire  [7:0]  w_data9w;
	wire  [1:0]  w_sel1001w;
	wire  [1:0]  w_sel104w;
	wire  [1:0]  w_sel1070w;
	wire  [1:0]  w_sel173w;
	wire  [1:0]  w_sel242w;
	wire  [1:0]  w_sel311w;
	wire  [1:0]  w_sel33w;
	wire  [1:0]  w_sel380w;
	wire  [1:0]  w_sel449w;
	wire  [1:0]  w_sel518w;
	wire  [1:0]  w_sel587w;
	wire  [1:0]  w_sel656w;
	wire  [1:0]  w_sel725w;
	wire  [1:0]  w_sel794w;
	wire  [1:0]  w_sel863w;
	wire  [1:0]  w_sel932w;

	assign
		result = result_node,
		result_node = {((sel_node[2] & (((w_data1069w[1] & w_sel1070w[0]) & (~ (((w_data1069w[0] & (~ w_sel1070w[1])) & (~ w_sel1070w[0])) | (w_sel1070w[1] & (w_sel1070w[0] | w_data1069w[2]))))) | ((((w_data1069w[0] & (~ w_sel1070w[1])) & (~ w_sel1070w[0])) | (w_sel1070w[1] & (w_sel1070w[0] | w_data1069w[2]))) & (w_data1069w[3] | (~ w_sel1070w[0]))))) | ((~ sel_node[2]) & (((w_data1068w[1] & w_sel1070w[0]) & (~ (((w_data1068w[0] & (~ w_sel1070w[1])) & (~ w_sel1070w[0])) | (w_sel1070w[1] & (w_sel1070w[0] | w_data1068w[2]))))) | ((((w_data1068w[0] & (~ w_sel1070w[1])) & (~ w_sel1070w[0])) | (w_sel1070w[1] & (w_sel1070w[0] | w_data1068w[2]))) & (w_data1068w[3] | (~ w_sel1070w[0])))))), ((sel_node[2] & (((w_data1000w[1] & w_sel1001w[0]) & (~ (((w_data1000w[0] & (~ w_sel1001w[1])) & (~ w_sel1001w[0])) | (w_sel1001w[1] & (w_sel1001w[0] | w_data1000w[2]))))) | ((((w_data1000w[0] & (~ w_sel1001w[1])) & (~ w_sel1001w[0])) | (w_sel1001w[1] & (w_sel1001w[0] | w_data1000w[2]))) & (w_data1000w[3] | (~ w_sel1001w[0]))))) | ((~ sel_node[2]) & (((w_data999w[1] & w_sel1001w[0]) & (~ (((w_data999w[0] & (~ w_sel1001w[1])) & (~ w_sel1001w[0])) | (w_sel1001w[1] & (w_sel1001w[0] | w_data999w[2]))))) | ((((w_data999w[0] & (~ w_sel1001w[1])) & (~ w_sel1001w[0])) | (w_sel1001w[1] & (w_sel1001w[0] | w_data999w[2]))) & (w_data999w[3] | (~ w_sel1001w[0])))))), ((sel_node[2] & (((w_data931w[1] & w_sel932w[0]) & (~ (((w_data931w[0] & (~ w_sel932w[1])) & (~ w_sel932w[0])) | (w_sel932w[1] & (w_sel932w[0] | w_data931w[2]))))) | ((((w_data931w[0] & (~ w_sel932w[1])) & (~ w_sel932w[0])) | (w_sel932w[1] & (w_sel932w[0] | w_data931w[2]))) & (w_data931w[3] | (~ w_sel932w[0]))))) | ((~ sel_node[2]) & (((w_data930w[1] & w_sel932w[0]) & (~ (((w_data930w[0] & (~ w_sel932w[1])) & (~ w_sel932w[0])) | (w_sel932w[1] & (w_sel932w[0] | w_data930w[2]))))) | ((((w_data930w[0] & (~ w_sel932w[1])) & (~ w_sel932w[0])) | (w_sel932w[1] & (w_sel932w[0] | w_data930w[2]))) & (w_data930w[3] | (~ w_sel932w[0])))))), ((sel_node[2] & (((w_data862w[1] & w_sel863w[0]) & (~ (((w_data862w[0]
 & (~ w_sel863w[1])) & (~ w_sel863w[0])) | (w_sel863w[1] & (w_sel863w[0] | w_data862w[2]))))) | ((((w_data862w[0] & (~ w_sel863w[1])) & (~ w_sel863w[0])) | (w_sel863w[1] & (w_sel863w[0] | w_data862w[2]))) & (w_data862w[3] | (~ w_sel863w[0]))))) | ((~ sel_node[2]) & (((w_data861w[1] & w_sel863w[0]) & (~ (((w_data861w[0] & (~ w_sel863w[1])) & (~ w_sel863w[0])) | (w_sel863w[1] & (w_sel863w[0] | w_data861w[2]))))) | ((((w_data861w[0] & (~ w_sel863w[1])) & (~ w_sel863w[0])) | (w_sel863w[1] & (w_sel863w[0] | w_data861w[2]))) & (w_data861w[3] | (~ w_sel863w[0])))))), ((sel_node[2] & (((w_data793w[1] & w_sel794w[0]) & (~ (((w_data793w[0] & (~ w_sel794w[1])) & (~ w_sel794w[0])) | (w_sel794w[1] & (w_sel794w[0] | w_data793w[2]))))) | ((((w_data793w[0] & (~ w_sel794w[1])) & (~ w_sel794w[0])) | (w_sel794w[1] & (w_sel794w[0] | w_data793w[2]))) & (w_data793w[3] | (~ w_sel794w[0]))))) | ((~ sel_node[2]) & (((w_data792w[1] & w_sel794w[0]) & (~ (((w_data792w[0] & (~ w_sel794w[1])) & (~ w_sel794w[0])) | (w_sel794w[1] & (w_sel794w[0] | w_data792w[2]))))) | ((((w_data792w[0] & (~ w_sel794w[1])) & (~ w_sel794w[0])) | (w_sel794w[1] & (w_sel794w[0] | w_data792w[2]))) & (w_data792w[3] | (~ w_sel794w[0])))))), ((sel_node[2] & (((w_data724w[1] & w_sel725w[0]) & (~ (((w_data724w[0] & (~ w_sel725w[1])) & (~ w_sel725w[0])) | (w_sel725w[1] & (w_sel725w[0] | w_data724w[2]))))) | ((((w_data724w[0] & (~ w_sel725w[1])) & (~ w_sel725w[0])) | (w_sel725w[1] & (w_sel725w[0] | w_data724w[2]))) & (w_data724w[3] | (~ w_sel725w[0]))))) | ((~ sel_node[2]) & (((w_data723w[1] & w_sel725w[0]) & (~ (((w_data723w[0] & (~ w_sel725w[1])) & (~ w_sel725w[0])) | (w_sel725w[1] & (w_sel725w[0] | w_data723w[2]))))) | ((((w_data723w[0] & (~ w_sel725w[1])) & (~ w_sel725w[0])) | (w_sel725w[1] & (w_sel725w[0] | w_data723w[2]))) & (w_data723w[3] | (~ w_sel725w[0])))))), ((sel_node[2] & (((w_data655w[1] & w_sel656w[0]) & (~ (((w_data655w[0] & (~ w_sel656w[1])) & (~ w_sel656w[0])) | (w_sel656w[1] & (w_sel656w[0] | w_data655w[2]))))) | ((((w_data655w[0] & (~ w_sel656w[1])) & (~
 w_sel656w[0])) | (w_sel656w[1] & (w_sel656w[0] | w_data655w[2]))) & (w_data655w[3] | (~ w_sel656w[0]))))) | ((~ sel_node[2]) & (((w_data654w[1] & w_sel656w[0]) & (~ (((w_data654w[0] & (~ w_sel656w[1])) & (~ w_sel656w[0])) | (w_sel656w[1] & (w_sel656w[0] | w_data654w[2]))))) | ((((w_data654w[0] & (~ w_sel656w[1])) & (~ w_sel656w[0])) | (w_sel656w[1] & (w_sel656w[0] | w_data654w[2]))) & (w_data654w[3] | (~ w_sel656w[0])))))), ((sel_node[2] & (((w_data586w[1] & w_sel587w[0]) & (~ (((w_data586w[0] & (~ w_sel587w[1])) & (~ w_sel587w[0])) | (w_sel587w[1] & (w_sel587w[0] | w_data586w[2]))))) | ((((w_data586w[0] & (~ w_sel587w[1])) & (~ w_sel587w[0])) | (w_sel587w[1] & (w_sel587w[0] | w_data586w[2]))) & (w_data586w[3] | (~ w_sel587w[0]))))) | ((~ sel_node[2]) & (((w_data585w[1] & w_sel587w[0]) & (~ (((w_data585w[0] & (~ w_sel587w[1])) & (~ w_sel587w[0])) | (w_sel587w[1] & (w_sel587w[0] | w_data585w[2]))))) | ((((w_data585w[0] & (~ w_sel587w[1])) & (~ w_sel587w[0])) | (w_sel587w[1] & (w_sel587w[0] | w_data585w[2]))) & (w_data585w[3] | (~ w_sel587w[0])))))), ((sel_node[2] & (((w_data517w[1] & w_sel518w[0]) & (~ (((w_data517w[0] & (~ w_sel518w[1])) & (~ w_sel518w[0])) | (w_sel518w[1] & (w_sel518w[0] | w_data517w[2]))))) | ((((w_data517w[0] & (~ w_sel518w[1])) & (~ w_sel518w[0])) | (w_sel518w[1] & (w_sel518w[0] | w_data517w[2]))) & (w_data517w[3] | (~ w_sel518w[0]))))) | ((~ sel_node[2]) & (((w_data516w[1] & w_sel518w[0]) & (~ (((w_data516w[0] & (~ w_sel518w[1])) & (~ w_sel518w[0])) | (w_sel518w[1] & (w_sel518w[0] | w_data516w[2]))))) | ((((w_data516w[0] & (~ w_sel518w[1])) & (~ w_sel518w[0])) | (w_sel518w[1] & (w_sel518w[0] | w_data516w[2]))) & (w_data516w[3] | (~ w_sel518w[0])))))), ((sel_node[2] & (((w_data448w[1] & w_sel449w[0]) & (~ (((w_data448w[0] & (~ w_sel449w[1])) & (~ w_sel449w[0])) | (w_sel449w[1] & (w_sel449w[0] | w_data448w[2]))))) | ((((w_data448w[0] & (~ w_sel449w[1])) & (~ w_sel449w[0])) | (w_sel449w[1] & (w_sel449w[0] | w_data448w[2]))) & (w_data448w[3] | (~ w_sel449w[0]))))) | ((~ sel_node[2]) & (((w_data447w[1]
 & w_sel449w[0]) & (~ (((w_data447w[0] & (~ w_sel449w[1])) & (~ w_sel449w[0])) | (w_sel449w[1] & (w_sel449w[0] | w_data447w[2]))))) | ((((w_data447w[0] & (~ w_sel449w[1])) & (~ w_sel449w[0])) | (w_sel449w[1] & (w_sel449w[0] | w_data447w[2]))) & (w_data447w[3] | (~ w_sel449w[0])))))), ((sel_node[2] & (((w_data379w[1] & w_sel380w[0]) & (~ (((w_data379w[0] & (~ w_sel380w[1])) & (~ w_sel380w[0])) | (w_sel380w[1] & (w_sel380w[0] | w_data379w[2]))))) | ((((w_data379w[0] & (~ w_sel380w[1])) & (~ w_sel380w[0])) | (w_sel380w[1] & (w_sel380w[0] | w_data379w[2]))) & (w_data379w[3] | (~ w_sel380w[0]))))) | ((~ sel_node[2]) & (((w_data378w[1] & w_sel380w[0]) & (~ (((w_data378w[0] & (~ w_sel380w[1])) & (~ w_sel380w[0])) | (w_sel380w[1] & (w_sel380w[0] | w_data378w[2]))))) | ((((w_data378w[0] & (~ w_sel380w[1])) & (~ w_sel380w[0])) | (w_sel380w[1] & (w_sel380w[0] | w_data378w[2]))) & (w_data378w[3] | (~ w_sel380w[0])))))), ((sel_node[2] & (((w_data310w[1] & w_sel311w[0]) & (~ (((w_data310w[0] & (~ w_sel311w[1])) & (~ w_sel311w[0])) | (w_sel311w[1] & (w_sel311w[0] | w_data310w[2]))))) | ((((w_data310w[0] & (~ w_sel311w[1])) & (~ w_sel311w[0])) | (w_sel311w[1] & (w_sel311w[0] | w_data310w[2]))) & (w_data310w[3] | (~ w_sel311w[0]))))) | ((~ sel_node[2]) & (((w_data309w[1] & w_sel311w[0]) & (~ (((w_data309w[0] & (~ w_sel311w[1])) & (~ w_sel311w[0])) | (w_sel311w[1] & (w_sel311w[0] | w_data309w[2]))))) | ((((w_data309w[0] & (~ w_sel311w[1])) & (~ w_sel311w[0])) | (w_sel311w[1] & (w_sel311w[0] | w_data309w[2]))) & (w_data309w[3] | (~ w_sel311w[0])))))), ((sel_node[2] & (((w_data241w[1] & w_sel242w[0]) & (~ (((w_data241w[0] & (~ w_sel242w[1])) & (~ w_sel242w[0])) | (w_sel242w[1] & (w_sel242w[0] | w_data241w[2]))))) | ((((w_data241w[0] & (~ w_sel242w[1])) & (~ w_sel242w[0])) | (w_sel242w[1] & (w_sel242w[0] | w_data241w[2]))) & (w_data241w[3] | (~ w_sel242w[0]))))) | ((~ sel_node[2]) & (((w_data240w[1] & w_sel242w[0]) & (~ (((w_data240w[0] & (~ w_sel242w[1])) & (~ w_sel242w[0])) | (w_sel242w[1] & (w_sel242w[0] | w_data240w[2]))))) | (((
(w_data240w[0] & (~ w_sel242w[1])) & (~ w_sel242w[0])) | (w_sel242w[1] & (w_sel242w[0] | w_data240w[2]))) & (w_data240w[3] | (~ w_sel242w[0])))))), ((sel_node[2] & (((w_data172w[1] & w_sel173w[0]) & (~ (((w_data172w[0] & (~ w_sel173w[1])) & (~ w_sel173w[0])) | (w_sel173w[1] & (w_sel173w[0] | w_data172w[2]))))) | ((((w_data172w[0] & (~ w_sel173w[1])) & (~ w_sel173w[0])) | (w_sel173w[1] & (w_sel173w[0] | w_data172w[2]))) & (w_data172w[3] | (~ w_sel173w[0]))))) | ((~ sel_node[2]) & (((w_data171w[1] & w_sel173w[0]) & (~ (((w_data171w[0] & (~ w_sel173w[1])) & (~ w_sel173w[0])) | (w_sel173w[1] & (w_sel173w[0] | w_data171w[2]))))) | ((((w_data171w[0] & (~ w_sel173w[1])) & (~ w_sel173w[0])) | (w_sel173w[1] & (w_sel173w[0] | w_data171w[2]))) & (w_data171w[3] | (~ w_sel173w[0])))))), ((sel_node[2] & (((w_data103w[1] & w_sel104w[0]) & (~ (((w_data103w[0] & (~ w_sel104w[1])) & (~ w_sel104w[0])) | (w_sel104w[1] & (w_sel104w[0] | w_data103w[2]))))) | ((((w_data103w[0] & (~ w_sel104w[1])) & (~ w_sel104w[0])) | (w_sel104w[1] & (w_sel104w[0] | w_data103w[2]))) & (w_data103w[3] | (~ w_sel104w[0]))))) | ((~ sel_node[2]) & (((w_data102w[1] & w_sel104w[0]) & (~ (((w_data102w[0] & (~ w_sel104w[1])) & (~ w_sel104w[0])) | (w_sel104w[1] & (w_sel104w[0] | w_data102w[2]))))) | ((((w_data102w[0] & (~ w_sel104w[1])) & (~ w_sel104w[0])) | (w_sel104w[1] & (w_sel104w[0] | w_data102w[2]))) & (w_data102w[3] | (~ w_sel104w[0])))))), ((sel_node[2] & (((w_data32w[1] & w_sel33w[0]) & (~ (((w_data32w[0] & (~ w_sel33w[1])) & (~ w_sel33w[0])) | (w_sel33w[1] & (w_sel33w[0] | w_data32w[2]))))) | ((((w_data32w[0] & (~ w_sel33w[1])) & (~ w_sel33w[0])) | (w_sel33w[1] & (w_sel33w[0] | w_data32w[2]))) & (w_data32w[3] | (~ w_sel33w[0]))))) | ((~ sel_node[2]) & (((w_data31w[1] & w_sel33w[0]) & (~ (((w_data31w[0] & (~ w_sel33w[1])) & (~ w_sel33w[0])) | (w_sel33w[1] & (w_sel33w[0] | w_data31w[2]))))) | ((((w_data31w[0] & (~ w_sel33w[1])) & (~ w_sel33w[0])) | (w_sel33w[1] & (w_sel33w[0] | w_data31w[2]))) & (w_data31w[3] | (~ w_sel33w[0]))))))},
		sel_ffs_wire = {sel[2:0]},
		sel_node = {sel_ffs_wire[2], sel[1:0]},
		w_data1000w = w_data977w[7:4],
		w_data102w = w_data80w[3:0],
		w_data103w = w_data80w[7:4],
		w_data1046w = {data[127], data[111], data[95], data[79], data[63], data[47], data[31], data[15]},
		w_data1068w = w_data1046w[3:0],
		w_data1069w = w_data1046w[7:4],
		w_data149w = {data[114], data[98], data[82], data[66], data[50], data[34], data[18], data[2]},
		w_data171w = w_data149w[3:0],
		w_data172w = w_data149w[7:4],
		w_data218w = {data[115], data[99], data[83], data[67], data[51], data[35], data[19], data[3]},
		w_data240w = w_data218w[3:0],
		w_data241w = w_data218w[7:4],
		w_data287w = {data[116], data[100], data[84], data[68], data[52], data[36], data[20], data[4]},
		w_data309w = w_data287w[3:0],
		w_data310w = w_data287w[7:4],
		w_data31w = w_data9w[3:0],
		w_data32w = w_data9w[7:4],
		w_data356w = {data[117], data[101], data[85], data[69], data[53], data[37], data[21], data[5]},
		w_data378w = w_data356w[3:0],
		w_data379w = w_data356w[7:4],
		w_data425w = {data[118], data[102], data[86], data[70], data[54], data[38], data[22], data[6]},
		w_data447w = w_data425w[3:0],
		w_data448w = w_data425w[7:4],
		w_data494w = {data[119], data[103], data[87], data[71], data[55], data[39], data[23], data[7]},
		w_data516w = w_data494w[3:0],
		w_data517w = w_data494w[7:4],
		w_data563w = {data[120], data[104], data[88], data[72], data[56], data[40], data[24], data[8]},
		w_data585w = w_data563w[3:0],
		w_data586w = w_data563w[7:4],
		w_data632w = {data[121], data[105], data[89], data[73], data[57], data[41], data[25], data[9]},
		w_data654w = w_data632w[3:0],
		w_data655w = w_data632w[7:4],
		w_data701w = {data[122], data[106], data[90], data[74], data[58], data[42], data[26], data[10]},
		w_data723w = w_data701w[3:0],
		w_data724w = w_data701w[7:4],
		w_data770w = {data[123], data[107], data[91], data[75], data[59], data[43], data[27], data[11]},
		w_data792w = w_data770w[3:0],
		w_data793w = w_data770w[7:4],
		w_data80w = {data[113], data[97], data[81], data[65], data[49], data[33], data[17], data[1]},
		w_data839w = {data[124], data[108], data[92], data[76], data[60], data[44], data[28], data[12]},
		w_data861w = w_data839w[3:0],
		w_data862w = w_data839w[7:4],
		w_data908w = {data[125], data[109], data[93], data[77], data[61], data[45], data[29], data[13]},
		w_data930w = w_data908w[3:0],
		w_data931w = w_data908w[7:4],
		w_data977w = {data[126], data[110], data[94], data[78], data[62], data[46], data[30], data[14]},
		w_data999w = w_data977w[3:0],
		w_data9w = {data[112], data[96], data[80], data[64], data[48], data[32], data[16], data[0]},
		w_sel1001w = sel_node[1:0],
		w_sel104w = sel_node[1:0],
		w_sel1070w = sel_node[1:0],
		w_sel173w = sel_node[1:0],
		w_sel242w = sel_node[1:0],
		w_sel311w = sel_node[1:0],
		w_sel33w = sel_node[1:0],
		w_sel380w = sel_node[1:0],
		w_sel449w = sel_node[1:0],
		w_sel518w = sel_node[1:0],
		w_sel587w = sel_node[1:0],
		w_sel656w = sel_node[1:0],
		w_sel725w = sel_node[1:0],
		w_sel794w = sel_node[1:0],
		w_sel863w = sel_node[1:0],
		w_sel932w = sel_node[1:0];
endmodule //MUX8_16_mux
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module MUX8_16 (
	data0x,
	data1x,
	data2x,
	data3x,
	data4x,
	data5x,
	data6x,
	data7x,
	sel,
	result)/* synthesis synthesis_clearbox = 1 */;

	input	[15:0]  data0x;
	input	[15:0]  data1x;
	input	[15:0]  data2x;
	input	[15:0]  data3x;
	input	[15:0]  data4x;
	input	[15:0]  data5x;
	input	[15:0]  data6x;
	input	[15:0]  data7x;
	input	[2:0]  sel;
	output	[15:0]  result;

	wire [15:0] sub_wire0;
	wire [15:0] sub_wire9 = data0x[15:0];
	wire [15:0] sub_wire8 = data1x[15:0];
	wire [15:0] sub_wire7 = data2x[15:0];
	wire [15:0] sub_wire6 = data3x[15:0];
	wire [15:0] sub_wire5 = data4x[15:0];
	wire [15:0] sub_wire4 = data5x[15:0];
	wire [15:0] sub_wire3 = data6x[15:0];
	wire [15:0] result = sub_wire0[15:0];
	wire [15:0] sub_wire1 = data7x[15:0];
	wire [127:0] sub_wire2 = {sub_wire9, sub_wire8, sub_wire7, sub_wire6, sub_wire5, sub_wire4, sub_wire3, sub_wire1};

	MUX8_16_mux	MUX8_16_mux_component (
				.data (sub_wire2),
				.sel (sel),
				.result (sub_wire0));

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "1"
// Retrieval info: PRIVATE: new_diagram STRING "1"
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: CONSTANT: LPM_SIZE NUMERIC "8"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_MUX"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "16"
// Retrieval info: CONSTANT: LPM_WIDTHS NUMERIC "3"
// Retrieval info: USED_PORT: data0x 0 0 16 0 INPUT NODEFVAL "data0x[15..0]"
// Retrieval info: USED_PORT: data1x 0 0 16 0 INPUT NODEFVAL "data1x[15..0]"
// Retrieval info: USED_PORT: data2x 0 0 16 0 INPUT NODEFVAL "data2x[15..0]"
// Retrieval info: USED_PORT: data3x 0 0 16 0 INPUT NODEFVAL "data3x[15..0]"
// Retrieval info: USED_PORT: data4x 0 0 16 0 INPUT NODEFVAL "data4x[15..0]"
// Retrieval info: USED_PORT: data5x 0 0 16 0 INPUT NODEFVAL "data5x[15..0]"
// Retrieval info: USED_PORT: data6x 0 0 16 0 INPUT NODEFVAL "data6x[15..0]"
// Retrieval info: USED_PORT: data7x 0 0 16 0 INPUT NODEFVAL "data7x[15..0]"
// Retrieval info: USED_PORT: result 0 0 16 0 OUTPUT NODEFVAL "result[15..0]"
// Retrieval info: USED_PORT: sel 0 0 3 0 INPUT NODEFVAL "sel[2..0]"
// Retrieval info: CONNECT: @data 1 0 16 0 data0x 0 0 16 0
// Retrieval info: CONNECT: @data 1 1 16 0 data1x 0 0 16 0
// Retrieval info: CONNECT: @data 1 2 16 0 data2x 0 0 16 0
// Retrieval info: CONNECT: @data 1 3 16 0 data3x 0 0 16 0
// Retrieval info: CONNECT: @data 1 4 16 0 data4x 0 0 16 0
// Retrieval info: CONNECT: @data 1 5 16 0 data5x 0 0 16 0
// Retrieval info: CONNECT: @data 1 6 16 0 data6x 0 0 16 0
// Retrieval info: CONNECT: @data 1 7 16 0 data7x 0 0 16 0
// Retrieval info: CONNECT: @sel 0 0 3 0 sel 0 0 3 0
// Retrieval info: CONNECT: result 0 0 16 0 @result 0 0 16 0
// Retrieval info: GEN_FILE: TYPE_NORMAL MUX8_16.vhd TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL MUX8_16.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL MUX8_16.cmp TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL MUX8_16.bsf TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL MUX8_16_inst.vhd FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL MUX8_16_syn.v TRUE
// Retrieval info: LIB_FILE: lpm
