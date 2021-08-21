-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"
-- CREATED		"Sat Aug 21 03:59:07 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ArillaCore IS 
	PORT
	(
		FPGA_CLK :  IN  STD_LOGIC;
		BUTTON :  IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		MemoryDataOut :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		SW :  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
		MemoryWrite :  OUT  STD_LOGIC;
		MemoryRead :  OUT  STD_LOGIC;
		HEX0_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX1_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX2_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX3_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		LED :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		MemoryAddress :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		MemoryByteEnable :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		MemoryDataIn :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ArillaCore;

ARCHITECTURE bdf_type OF ArillaCore IS 

COMPONENT ldcreg
GENERIC (clear_value : INTEGER;
			default_value : INTEGER;
			size : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 cl : IN STD_LOGIC;
		 ld : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT idcreg
GENERIC (clear_value : INTEGER;
			default_value : INTEGER;
			size : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 cl : IN STD_LOGIC;
		 inc : IN STD_LOGIC;
		 dec : IN STD_LOGIC;
		 ld : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux2_32
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT edged
	PORT(I : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 Rising : OUT STD_LOGIC;
		 Falling : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT memalignexceptioncheck
	PORT(address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 function3 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 mem_align_exception : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT opcodedecoder
	PORT(opcode : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 OP : OUT STD_LOGIC;
		 OP_IMM : OUT STD_LOGIC;
		 BRANCH : OUT STD_LOGIC;
		 JAL : OUT STD_LOGIC;
		 JALR : OUT STD_LOGIC;
		 LUI : OUT STD_LOGIC;
		 AUIPC : OUT STD_LOGIC;
		 LOAD : OUT STD_LOGIC;
		 STORE : OUT STD_LOGIC;
		 invalid_opcode_exception : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mux8_32
	PORT(data0x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data2x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data3x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data4x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data5x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data6x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data7x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux4_4
	PORT(data0x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data2x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data3x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux4_32
	PORT(data0x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data2x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data3x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alu
	PORT(A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 op : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 aluzero : OUT STD_LOGIC;
		 C : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT const
GENERIC (const : INTEGER;
			size : INTEGER
			);
	PORT(		 data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT arillarom
	PORT(ADDR : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 O : OUT STD_LOGIC_VECTOR(24 DOWNTO 0)
	);
END COMPONENT;

COMPONENT storegenerator
	PORT(address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 function3 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 word : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 byte_enable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux2_4
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alubranchoperationcode
	PORT(function3 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 aluop : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT signext
GENERIC (in_width : INTEGER;
			out_width : INTEGER
			);
	PORT(I : IN STD_LOGIC_VECTOR(in_width-1 DOWNTO 0);
		 O : OUT STD_LOGIC_VECTOR(out_width-1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mdrgenerator
	PORT(address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 function3 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 word : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT controlunitopswitch
	PORT(lui : IN STD_LOGIC;
		 auipc : IN STD_LOGIC;
		 jal : IN STD_LOGIC;
		 jalr : IN STD_LOGIC;
		 branch : IN STD_LOGIC;
		 load : IN STD_LOGIC;
		 store : IN STD_LOGIC;
		 ri : IN STD_LOGIC;
		 fault : IN STD_LOGIC;
		 BranchAddress : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sevensegmentinterface4
	PORT(input : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 HEX0 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 HEX1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 HEX2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 HEX3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT zeroext
GENERIC (in_width : INTEGER;
			out_width : INTEGER
			);
	PORT(I : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 O : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dc3
	PORT(data : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 eq1 : OUT STD_LOGIC;
		 eq2 : OUT STD_LOGIC;
		 eq3 : OUT STD_LOGIC;
		 eq4 : OUT STD_LOGIC;
		 eq5 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT regfile
	PORT(wr : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 D : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 S1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 S2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 RS1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 RS2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	A :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	ALUOut :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	ALUzero :  STD_LOGIC;
SIGNAL	AUIPC :  STD_LOGIC;
SIGNAL	B :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	ba :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	BRANCH :  STD_LOGIC;
SIGNAL	branch_immediate :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	brcnd :  STD_LOGIC;
SIGNAL	brhalted :  STD_LOGIC;
SIGNAL	brimmext :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	brmem_align_exception :  STD_LOGIC;
SIGNAL	brmul :  STD_LOGIC;
SIGNAL	brpc_mem_align_exception :  STD_LOGIC;
SIGNAL	bruncnd :  STD_LOGIC;
SIGNAL	C :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	caseba :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	cc :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	clk :  STD_LOGIC;
SIGNAL	destination :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	fault_signal :  STD_LOGIC;
SIGNAL	function3 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	function7 :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	halted :  STD_LOGIC;
SIGNAL	immediate :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	immex :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	instruction_step :  STD_LOGIC;
SIGNAL	invalid_opcode :  STD_LOGIC;
SIGNAL	IR :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	JAL :  STD_LOGIC;
SIGNAL	jal_immediate :  STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL	jalimmext :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	JALR :  STD_LOGIC;
SIGNAL	LED_ALTERA_SYNTHESIZED0 :  STD_LOGIC;
SIGNAL	LED_ALTERA_SYNTHESIZED5 :  STD_LOGIC;
SIGNAL	LED_ALTERA_SYNTHESIZED6 :  STD_LOGIC;
SIGNAL	LED_ALTERA_SYNTHESIZED7 :  STD_LOGIC;
SIGNAL	LED_ALTERA_SYNTHESIZED8 :  STD_LOGIC;
SIGNAL	LED_ALTERA_SYNTHESIZED9 :  STD_LOGIC;
SIGNAL	LOAD :  STD_LOGIC;
SIGNAL	LUI :  STD_LOGIC;
SIGNAL	MDROutput :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	MEM :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	mem_align_exception :  STD_LOGIC;
SIGNAL	mxA :  STD_LOGIC;
SIGNAL	mxALUOP :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	mxB :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	mxMEM :  STD_LOGIC;
SIGNAL	mxPC :  STD_LOGIC;
SIGNAL	mxReg :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	one :  STD_LOGIC;
SIGNAL	OP :  STD_LOGIC;
SIGNAL	OP_IMM :  STD_LOGIC;
SIGNAL	opcode :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	PC :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	pc_mem_align_exception :  STD_LOGIC;
SIGNAL	rst :  STD_LOGIC;
SIGNAL	shift_immediate :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	source1 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	source2 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	state :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	STORE :  STD_LOGIC;
SIGNAL	store_immediate :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	storeimmext :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	upimmext :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	upimmshifted :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	upper_immediate :  STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL	wrAB :  STD_LOGIC;
SIGNAL	wrbrPC :  STD_LOGIC;
SIGNAL	wrC :  STD_LOGIC;
SIGNAL	wrIR :  STD_LOGIC;
SIGNAL	wrMEM :  STD_LOGIC;
SIGNAL	wrPC :  STD_LOGIC;
SIGNAL	wrReg :  STD_LOGIC;
SIGNAL	zero :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_17 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_18 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_25 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC_VECTOR(31 DOWNTO 0);

SIGNAL	GDFX_TEMP_SIGNAL_8 :  STD_LOGIC_VECTOR(24 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_10 :  STD_LOGIC_VECTOR(20 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_6 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_4 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_7 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_9 :  STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_5 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(11 DOWNTO 0);

BEGIN 

ba(3) <= GDFX_TEMP_SIGNAL_8(24);
ba(2) <= GDFX_TEMP_SIGNAL_8(23);
ba(1) <= GDFX_TEMP_SIGNAL_8(22);
ba(0) <= GDFX_TEMP_SIGNAL_8(21);
cc(2) <= GDFX_TEMP_SIGNAL_8(20);
cc(1) <= GDFX_TEMP_SIGNAL_8(19);
cc(0) <= GDFX_TEMP_SIGNAL_8(18);
fault_signal <= GDFX_TEMP_SIGNAL_8(17);
mxALUOP(0) <= GDFX_TEMP_SIGNAL_8(16);
wrMEM <= GDFX_TEMP_SIGNAL_8(15);
mxMEM <= GDFX_TEMP_SIGNAL_8(14);
mxALUOP(1) <= GDFX_TEMP_SIGNAL_8(13);
wrbrPC <= GDFX_TEMP_SIGNAL_8(12);
mxB(2) <= GDFX_TEMP_SIGNAL_8(11);
mxReg(0) <= GDFX_TEMP_SIGNAL_8(10);
wrReg <= GDFX_TEMP_SIGNAL_8(9);
mxReg(1) <= GDFX_TEMP_SIGNAL_8(8);
wrC <= GDFX_TEMP_SIGNAL_8(7);
mxB(1) <= GDFX_TEMP_SIGNAL_8(6);
wrAB <= GDFX_TEMP_SIGNAL_8(5);
mxB(0) <= GDFX_TEMP_SIGNAL_8(4);
mxA <= GDFX_TEMP_SIGNAL_8(3);
wrPC <= GDFX_TEMP_SIGNAL_8(2);
mxPC <= GDFX_TEMP_SIGNAL_8(1);
wrIR <= GDFX_TEMP_SIGNAL_8(0);

GDFX_TEMP_SIGNAL_10 <= (jal_immediate(19 DOWNTO 0) & zero);
GDFX_TEMP_SIGNAL_3 <= (zero & one & zero);
GDFX_TEMP_SIGNAL_6 <= (one & zero & zero & zero);
GDFX_TEMP_SIGNAL_4 <= (zero & zero & zero & zero);
GDFX_TEMP_SIGNAL_7 <= (upper_immediate(19 DOWNTO 0) & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero);
GDFX_TEMP_SIGNAL_9 <= (branch_immediate(11 DOWNTO 0) & zero);
GDFX_TEMP_SIGNAL_5 <= (function7(5) & function3(2 DOWNTO 0));
GDFX_TEMP_SIGNAL_1 <= (IR(31) & IR(19 DOWNTO 12) & IR(20) & IR(30 DOWNTO 21));
GDFX_TEMP_SIGNAL_2 <= (IR(31 DOWNTO 25) & IR(11 DOWNTO 7));
GDFX_TEMP_SIGNAL_0 <= (IR(31) & IR(7) & IR(30 DOWNTO 25) & IR(11 DOWNTO 8));


b2v_AReg : ldcreg
GENERIC MAP(clear_value => 0,
			default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 cl => rst,
		 ld => wrAB,
		 data_in => SYNTHESIZED_WIRE_0,
		 data_out => A);


b2v_BReg : ldcreg
GENERIC MAP(clear_value => 0,
			default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 cl => rst,
		 ld => wrAB,
		 data_in => SYNTHESIZED_WIRE_1,
		 data_out => B);


b2v_BReg25 : ldcreg
GENERIC MAP(clear_value => 0,
			default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 cl => rst,
		 ld => wrC,
		 data_in => ALUOut,
		 data_out => C);


b2v_ControlStateReg : idcreg
GENERIC MAP(clear_value => 0,
			default_value => 0,
			size => 4
			)
PORT MAP(clk => clk,
		 cl => rst,
		 inc => one,
		 dec => zero,
		 ld => brcnd,
		 data_in => SYNTHESIZED_WIRE_2,
		 data_out => state);


b2v_inst : mux2_32
PORT MAP(sel => mxPC,
		 data0x => C,
		 data1x => ALUOut,
		 result => SYNTHESIZED_WIRE_8);


SYNTHESIZED_WIRE_7 <= SYNTHESIZED_WIRE_3 OR wrPC;

function3 <= IR(14 DOWNTO 12);


opcode <= IR(6 DOWNTO 0);


source1 <= IR(19 DOWNTO 15);


function7 <= IR(31 DOWNTO 25);


destination <= IR(11 DOWNTO 7);


source2 <= IR(24 DOWNTO 20);


branch_immediate <= GDFX_TEMP_SIGNAL_0;


immediate <= IR(31 DOWNTO 20);


jal_immediate <= GDFX_TEMP_SIGNAL_1;




SYNTHESIZED_WIRE_3 <= wrbrPC AND ALUzero;

store_immediate <= GDFX_TEMP_SIGNAL_2;


upper_immediate <= IR(31 DOWNTO 12);



clk <= SYNTHESIZED_WIRE_4 OR SYNTHESIZED_WIRE_5;


b2v_inst23 : edged
PORT MAP(I => SYNTHESIZED_WIRE_6,
		 clk => FPGA_CLK,
		 Rising => SYNTHESIZED_WIRE_25);


b2v_inst24 : memalignexceptioncheck
PORT MAP(address => PC,
		 function3 => GDFX_TEMP_SIGNAL_3,
		 mem_align_exception => pc_mem_align_exception);



b2v_inst26 : ldcreg
GENERIC MAP(clear_value => 0,
			default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 cl => rst,
		 ld => SYNTHESIZED_WIRE_7,
		 data_in => SYNTHESIZED_WIRE_8,
		 data_out => PC);


b2v_inst27 : opcodedecoder
PORT MAP(opcode => opcode,
		 OP => OP,
		 OP_IMM => OP_IMM,
		 BRANCH => BRANCH,
		 JAL => JAL,
		 JALR => JALR,
		 LUI => LUI,
		 AUIPC => AUIPC,
		 LOAD => LOAD,
		 STORE => STORE,
		 invalid_opcode_exception => invalid_opcode);



b2v_inst29 : edged
PORT MAP(I => SYNTHESIZED_WIRE_11,
		 clk => FPGA_CLK,
		 Rising => SYNTHESIZED_WIRE_9);



SYNTHESIZED_WIRE_6 <= NOT(BUTTON(2));



SYNTHESIZED_WIRE_11 <= NOT(BUTTON(1));



b2v_inst32 : mux8_32
PORT MAP(data0x => SYNTHESIZED_WIRE_12,
		 data1x => SYNTHESIZED_WIRE_13,
		 data2x => brimmext,
		 data3x => upimmshifted,
		 data4x => jalimmext,
		 data5x => immex,
		 data6x => storeimmext,
		 data7x => B,
		 sel => mxB,
		 result => SYNTHESIZED_WIRE_17);


b2v_inst33 : mux4_4
PORT MAP(data0x => GDFX_TEMP_SIGNAL_4,
		 data1x => GDFX_TEMP_SIGNAL_5,
		 data2x => SYNTHESIZED_WIRE_14,
		 data3x => GDFX_TEMP_SIGNAL_6,
		 sel => mxALUOP,
		 result => SYNTHESIZED_WIRE_18);

halted <= SW(9);



b2v_inst35 : edged
PORT MAP(I => SYNTHESIZED_WIRE_15,
		 clk => FPGA_CLK,
		 Rising => rst);


SYNTHESIZED_WIRE_15 <= NOT(BUTTON(0));



b2v_inst37 : mux4_32
PORT MAP(data0x => C,
		 data1x => MDROutput,
		 data2x => upimmshifted,
		 data3x => PC,
		 sel => mxReg,
		 result => SYNTHESIZED_WIRE_26);


b2v_inst38 : alu
PORT MAP(A => SYNTHESIZED_WIRE_16,
		 B => SYNTHESIZED_WIRE_17,
		 op => SYNTHESIZED_WIRE_18,
		 aluzero => ALUzero,
		 C => ALUOut);


b2v_inst39 : const
GENERIC MAP(const => 4,
			size => 32
			)
PORT MAP(		 data => SYNTHESIZED_WIRE_13);



b2v_inst40 : mux2_32
PORT MAP(sel => mxMEM,
		 data0x => PC,
		 data1x => ALUOut,
		 result => MemoryAddress);

upimmshifted <= GDFX_TEMP_SIGNAL_7;



b2v_inst42 : arillarom
PORT MAP(ADDR => state,
		 O => GDFX_TEMP_SIGNAL_8);


b2v_inst43 : mux2_32
PORT MAP(sel => mxA,
		 data0x => A,
		 data1x => PC,
		 result => SYNTHESIZED_WIRE_16);



b2v_inst45 : storegenerator
PORT MAP(address => ALUOut,
		 function3 => function3,
		 word => B,
		 byte_enable => MemoryByteEnable,
		 data => MemoryDataIn);


b2v_inst46 : mux2_4
PORT MAP(sel => brmul,
		 data0x => ba,
		 data1x => caseba,
		 result => SYNTHESIZED_WIRE_2);


b2v_inst47 : alubranchoperationcode
PORT MAP(function3 => function3,
		 aluop => SYNTHESIZED_WIRE_14);


b2v_inst49 : signext
GENERIC MAP(in_width => 13,
			out_width => 32
			)
PORT MAP(I => GDFX_TEMP_SIGNAL_9,
		 O => brimmext);



b2v_inst50 : signext
GENERIC MAP(in_width => 21,
			out_width => 32
			)
PORT MAP(I => GDFX_TEMP_SIGNAL_10,
		 O => jalimmext);


b2v_inst51 : signext
GENERIC MAP(in_width => 12,
			out_width => 32
			)
PORT MAP(I => immediate,
		 O => immex);


brcnd <= bruncnd OR SYNTHESIZED_WIRE_19 OR brmul OR SYNTHESIZED_WIRE_20 OR SYNTHESIZED_WIRE_21 OR zero;


b2v_inst53 : signext
GENERIC MAP(in_width => 20,
			out_width => 32
			)
PORT MAP(I => upper_immediate);


b2v_inst54 : mdrgenerator
PORT MAP(address => C,
		 function3 => function3,
		 word => MEM,
		 data => MDROutput);


b2v_inst55 : controlunitopswitch
PORT MAP(lui => LUI,
		 auipc => AUIPC,
		 jal => JAL,
		 jalr => JALR,
		 branch => BRANCH,
		 load => LOAD,
		 store => STORE,
		 ri => SYNTHESIZED_WIRE_22,
		 fault => invalid_opcode,
		 BranchAddress => caseba);


b2v_inst56 : memalignexceptioncheck
PORT MAP(address => ALUOut,
		 function3 => function3,
		 mem_align_exception => mem_align_exception);


b2v_inst57 : signext
GENERIC MAP(in_width => 12,
			out_width => 32
			)
PORT MAP(I => store_immediate,
		 O => storeimmext);


SYNTHESIZED_WIRE_22 <= OP_IMM OR OP;


SYNTHESIZED_WIRE_19 <= brhalted AND halted;


b2v_inst6 : mux2_32
PORT MAP(sel => OP_IMM,
		 data0x => B,
		 data1x => immex,
		 result => SYNTHESIZED_WIRE_12);


SYNTHESIZED_WIRE_20 <= brpc_mem_align_exception AND pc_mem_align_exception;


SYNTHESIZED_WIRE_21 <= brmem_align_exception AND mem_align_exception;


b2v_inst62 : sevensegmentinterface4
PORT MAP(input => SYNTHESIZED_WIRE_23,
		 HEX0 => HEX0_D,
		 HEX1 => HEX1_D,
		 HEX2 => HEX2_D,
		 HEX3 => HEX3_D);


b2v_inst63 : zeroext
GENERIC MAP(in_width => 4,
			out_width => 16
			)
PORT MAP(I => state,
		 O => SYNTHESIZED_WIRE_23);


b2v_inst64 : dc3
PORT MAP(data => cc,
		 eq1 => bruncnd,
		 eq2 => brhalted,
		 eq3 => brpc_mem_align_exception,
		 eq4 => brmul,
		 eq5 => brmem_align_exception);


SYNTHESIZED_WIRE_5 <= FPGA_CLK AND SYNTHESIZED_WIRE_24;


SYNTHESIZED_WIRE_4 <= SW(0) AND SYNTHESIZED_WIRE_25;


SYNTHESIZED_WIRE_24 <= NOT(SW(0));



b2v_IRReg : ldcreg
GENERIC MAP(clear_value => 0,
			default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 cl => rst,
		 ld => wrIR,
		 data_in => MEM,
		 data_out => IR);


b2v_RegisterFile : regfile
PORT MAP(wr => wrReg,
		 clk => clk,
		 D => destination,
		 data => SYNTHESIZED_WIRE_26,
		 S1 => source2,
		 S2 => source1,
		 RS1 => SYNTHESIZED_WIRE_0,
		 RS2 => SYNTHESIZED_WIRE_1);

MemoryWrite <= wrMEM;
MEM <= MemoryDataOut;
MemoryRead <= one;


one <= '1';

zero <= '0';
END bdf_type;