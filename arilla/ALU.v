// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"
// CREATED		"Sun Aug 15 15:38:18 2021"

module ALU(
	A,
	B,
	op,
	op11,
	zero,
	C
);


input wire	[31:0] A;
input wire	[31:0] B;
input wire	[3:0] op;
input wire	[3:0] op11;
output wire	zero;
output wire	[31:0] C;

wire	[31:0] C_ALTERA_SYNTHESIZED;
wire	[31:0] SYNTHESIZED_WIRE_28;
wire	[31:0] SYNTHESIZED_WIRE_1;
wire	[31:0] SYNTHESIZED_WIRE_29;
wire	[31:0] SYNTHESIZED_WIRE_3;
wire	[31:0] SYNTHESIZED_WIRE_4;
wire	[31:0] SYNTHESIZED_WIRE_5;
wire	[31:0] SYNTHESIZED_WIRE_7;
wire	[31:0] SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_30;
wire	SYNTHESIZED_WIRE_31;
wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_32;
wire	SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_18;





MUX16_32	b2v_inst(
	.data0x(SYNTHESIZED_WIRE_28),
	
	
	
	.data13x(SYNTHESIZED_WIRE_1),
	
	
	.data1x(SYNTHESIZED_WIRE_29),
	.data2x(SYNTHESIZED_WIRE_3),
	.data3x(SYNTHESIZED_WIRE_4),
	.data4x(SYNTHESIZED_WIRE_5),
	.data5x(SYNTHESIZED_WIRE_29),
	.data6x(SYNTHESIZED_WIRE_7),
	.data7x(SYNTHESIZED_WIRE_8),
	.data8x(SYNTHESIZED_WIRE_28),
	
	.sel(op),
	.result(C_ALTERA_SYNTHESIZED));


CMP32_ZERO	b2v_inst10(
	.dataa(C_ALTERA_SYNTHESIZED),
	.aeb(SYNTHESIZED_WIRE_32));

assign	SYNTHESIZED_WIRE_5 = A ^ B;

assign	SYNTHESIZED_WIRE_8 = A & B;

assign	SYNTHESIZED_WIRE_7 = B | A;


ZEROEXT	b2v_inst15(
	.I(SYNTHESIZED_WIRE_30),
	.O(SYNTHESIZED_WIRE_4));
	defparam	b2v_inst15.in_width = 1;
	defparam	b2v_inst15.out_width = 32;


ZEROEXT	b2v_inst16(
	.I(SYNTHESIZED_WIRE_31),
	.O(SYNTHESIZED_WIRE_3));
	defparam	b2v_inst16.in_width = 1;
	defparam	b2v_inst16.out_width = 32;


CMP_32_ALU	b2v_inst18(
	.dataa(A),
	.datab(B),
	.aeb(SYNTHESIZED_WIRE_18),
	.aneb(SYNTHESIZED_WIRE_17),
	.ageb(SYNTHESIZED_WIRE_15),
	.alb(SYNTHESIZED_WIRE_31));


ADDSUB_32	b2v_inst3(
	.add_sub(op[3]),
	.dataa(A),
	.datab(B),
	.result(SYNTHESIZED_WIRE_28));


SHIFT_32_L	b2v_inst4(
	.direction(op[2]),
	.data(A),
	.distance(B[4:0]),
	.result(SYNTHESIZED_WIRE_29));


SHIFTR_32_A	b2v_inst5(
	.data(A),
	.distance(B[4:0]),
	.result(SYNTHESIZED_WIRE_1));


CMP_32_ALU_UNSIGNED	b2v_inst7(
	.dataa(A),
	.datab(B),
	.ageb(SYNTHESIZED_WIRE_12),
	.alb(SYNTHESIZED_WIRE_30));


MUX16_1	b2v_inst9(
	.data15(SYNTHESIZED_WIRE_12),
	.data14(SYNTHESIZED_WIRE_30),
	.data13(SYNTHESIZED_WIRE_32),
	.data12(SYNTHESIZED_WIRE_15),
	.data11(SYNTHESIZED_WIRE_31),
	.data10(SYNTHESIZED_WIRE_17),
	.data9(SYNTHESIZED_WIRE_18),
	.data8(SYNTHESIZED_WIRE_32),
	.data7(SYNTHESIZED_WIRE_32),
	.data6(SYNTHESIZED_WIRE_32),
	.data5(SYNTHESIZED_WIRE_32),
	.data4(SYNTHESIZED_WIRE_32),
	.data3(SYNTHESIZED_WIRE_32),
	.data2(SYNTHESIZED_WIRE_32),
	.data1(SYNTHESIZED_WIRE_32),
	.data0(SYNTHESIZED_WIRE_32),
	.sel(op11),
	.result(zero));

assign	C = C_ALTERA_SYNTHESIZED;

endmodule
