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
-- CREATED		"Sun Aug 29 18:03:30 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ArillaCore IS 
	PORT
	(
		FPGA_CLK :  IN  STD_LOGIC;
		BUTTON :  IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		DATA :  INOUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		SW :  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
		WR :  OUT  STD_LOGIC;
		RD :  OUT  STD_LOGIC;
		ADDR :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		LED :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		MemoryByteEnable :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		PC :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
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
		 O : OUT STD_LOGIC_VECTOR(25 DOWNTO 0)
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

COMPONENT sub32_branch
	PORT(dataa : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
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
SIGNAL	ALUA :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	ALUB :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	ALUOP :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	ALUOut :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	ALUPC :  STD_LOGIC_VECTOR(31 DOWNTO 0);
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
SIGNAL	immext :  STD_LOGIC_VECTOR(31 DOWNTO 0);
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
SIGNAL	MemoryDataIn :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	mxA :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	mxALUOP :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	mxB :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	mxMEM :  STD_LOGIC;
SIGNAL	mxPC :  STD_LOGIC;
SIGNAL	mxReg :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	one :  STD_LOGIC;
SIGNAL	OP :  STD_LOGIC;
SIGNAL	OP_IMM :  STD_LOGIC;
SIGNAL	opcode :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	PC_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(31 DOWNTO 0);
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
SIGNAL	wr_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	wr_ALTERA_SYNTHESIZED0 :  STD_LOGIC;
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
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_17 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_18 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_25 :  STD_LOGIC_VECTOR(31 DOWNTO 0);

SIGNAL	GDFX_TEMP_SIGNAL_7 :  STD_LOGIC_VECTOR(25 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_10 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_11 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_5 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_4 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_9 :  STD_LOGIC_VECTOR(20 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_8 :  STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_6 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(11 DOWNTO 0);

BEGIN 

ba(3) <= GDFX_TEMP_SIGNAL_7(25);
ba(2) <= GDFX_TEMP_SIGNAL_7(24);
ba(1) <= GDFX_TEMP_SIGNAL_7(23);
ba(0) <= GDFX_TEMP_SIGNAL_7(22);
cc(2) <= GDFX_TEMP_SIGNAL_7(21);
cc(1) <= GDFX_TEMP_SIGNAL_7(20);
cc(0) <= GDFX_TEMP_SIGNAL_7(19);
fault_signal <= GDFX_TEMP_SIGNAL_7(18);
mxALUOP(0) <= GDFX_TEMP_SIGNAL_7(17);
wrMEM <= GDFX_TEMP_SIGNAL_7(16);
mxMEM <= GDFX_TEMP_SIGNAL_7(15);
mxALUOP(1) <= GDFX_TEMP_SIGNAL_7(14);
wrbrPC <= GDFX_TEMP_SIGNAL_7(13);
mxB(2) <= GDFX_TEMP_SIGNAL_7(12);
mxReg(0) <= GDFX_TEMP_SIGNAL_7(11);
wrReg <= GDFX_TEMP_SIGNAL_7(10);
mxReg(1) <= GDFX_TEMP_SIGNAL_7(9);
wrC <= GDFX_TEMP_SIGNAL_7(8);
mxA(1) <= GDFX_TEMP_SIGNAL_7(7);
mxB(1) <= GDFX_TEMP_SIGNAL_7(6);
wrAB <= GDFX_TEMP_SIGNAL_7(5);
mxB(0) <= GDFX_TEMP_SIGNAL_7(4);
mxA(0) <= GDFX_TEMP_SIGNAL_7(3);
wrPC <= GDFX_TEMP_SIGNAL_7(2);
mxPC <= GDFX_TEMP_SIGNAL_7(1);
wrIR <= GDFX_TEMP_SIGNAL_7(0);


GDFX_TEMP_SIGNAL_10 <= (function7(5) & function3(2 DOWNTO 0));
GDFX_TEMP_SIGNAL_11 <= (zero & function3(2 DOWNTO 0));
GDFX_TEMP_SIGNAL_5 <= (one & zero & zero & zero);
GDFX_TEMP_SIGNAL_4 <= (zero & zero & zero & zero);
GDFX_TEMP_SIGNAL_9 <= (jal_immediate(19 DOWNTO 0) & zero);
GDFX_TEMP_SIGNAL_8 <= (branch_immediate(11 DOWNTO 0) & zero);
GDFX_TEMP_SIGNAL_3 <= (zero & one & zero);
GDFX_TEMP_SIGNAL_6 <= (upper_immediate(19 DOWNTO 0) & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero);
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
		 Rising => SYNTHESIZED_WIRE_24);


b2v_inst24 : memalignexceptioncheck
PORT MAP(address => PC_ALTERA_SYNTHESIZED,
		 function3 => GDFX_TEMP_SIGNAL_3,
		 mem_align_exception => pc_mem_align_exception);


b2v_inst25 : edged
PORT MAP(I => BUTTON(1),
		 clk => FPGA_CLK,
		 Rising => SYNTHESIZED_WIRE_9);


b2v_inst26 : ldcreg
GENERIC MAP(clear_value => 3636,
			default_value => 3636,
			size => 32
			)
PORT MAP(clk => clk,
		 cl => rst,
		 ld => SYNTHESIZED_WIRE_7,
		 data_in => SYNTHESIZED_WIRE_8,
		 data_out => PC_ALTERA_SYNTHESIZED);


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


RD <= NOT(wrMEM);



halted <= NOT(SYNTHESIZED_WIRE_9);




SYNTHESIZED_WIRE_6 <= NOT(BUTTON(2));



b2v_inst32 : mux8_32
PORT MAP(data0x => SYNTHESIZED_WIRE_10,
		 data1x => SYNTHESIZED_WIRE_11,
		 data2x => brimmext,
		 data3x => upimmshifted,
		 data4x => jalimmext,
		 data5x => immext,
		 data6x => storeimmext,
		 data7x => B,
		 sel => mxB,
		 result => ALUB);


b2v_inst33 : mux4_4
PORT MAP(data0x => GDFX_TEMP_SIGNAL_4,
		 data1x => SYNTHESIZED_WIRE_12,
		 data2x => SYNTHESIZED_WIRE_13,
		 data3x => GDFX_TEMP_SIGNAL_5,
		 sel => mxALUOP,
		 result => ALUOP);


b2v_inst35 : edged
PORT MAP(I => SYNTHESIZED_WIRE_14,
		 clk => FPGA_CLK,
		 Rising => rst);


SYNTHESIZED_WIRE_14 <= NOT(BUTTON(0));



b2v_inst37 : mux4_32
PORT MAP(data0x => C,
		 data1x => MDROutput,
		 data2x => upimmshifted,
		 data3x => PC_ALTERA_SYNTHESIZED,
		 sel => mxReg,
		 result => SYNTHESIZED_WIRE_25);


b2v_inst38 : alu
PORT MAP(A => ALUA,
		 B => ALUB,
		 op => ALUOP,
		 aluzero => ALUzero,
		 C => ALUOut);


b2v_inst39 : const
GENERIC MAP(const => 4,
			size => 32
			)
PORT MAP(		 data => SYNTHESIZED_WIRE_11);



b2v_inst40 : mux2_32
PORT MAP(sel => mxMEM,
		 data0x => PC_ALTERA_SYNTHESIZED,
		 data1x => ALUOut,
		 result => ADDR);

upimmshifted <= GDFX_TEMP_SIGNAL_6;



b2v_inst42 : arillarom
PORT MAP(ADDR => state,
		 O => GDFX_TEMP_SIGNAL_7);



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
		 aluop => SYNTHESIZED_WIRE_13);


b2v_inst49 : signext
GENERIC MAP(in_width => 13,
			out_width => 32
			)
PORT MAP(I => GDFX_TEMP_SIGNAL_8,
		 O => brimmext);



b2v_inst50 : signext
GENERIC MAP(in_width => 21,
			out_width => 32
			)
PORT MAP(I => GDFX_TEMP_SIGNAL_9,
		 O => jalimmext);


b2v_inst51 : signext
GENERIC MAP(in_width => 12,
			out_width => 32
			)
PORT MAP(I => immediate,
		 O => immext);


brcnd <= bruncnd OR SYNTHESIZED_WIRE_15 OR brmul OR SYNTHESIZED_WIRE_16 OR SYNTHESIZED_WIRE_17 OR zero;


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
		 ri => SYNTHESIZED_WIRE_18,
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


SYNTHESIZED_WIRE_18 <= OP_IMM OR OP;


SYNTHESIZED_WIRE_15 <= brhalted AND halted;


b2v_inst6 : mux2_32
PORT MAP(sel => OP_IMM,
		 data0x => B,
		 data1x => immext,
		 result => SYNTHESIZED_WIRE_10);


SYNTHESIZED_WIRE_16 <= brpc_mem_align_exception AND pc_mem_align_exception;


SYNTHESIZED_WIRE_17 <= brmem_align_exception AND mem_align_exception;


b2v_inst63 : sub32_branch
PORT MAP(dataa => PC_ALTERA_SYNTHESIZED,
		 result => ALUPC);


b2v_inst64 : dc3
PORT MAP(data => cc,
		 eq1 => bruncnd,
		 eq2 => brhalted,
		 eq3 => brpc_mem_align_exception,
		 eq4 => brmul,
		 eq5 => brmem_align_exception);


b2v_inst65 : mux4_32
PORT MAP(data0x => A,
		 data1x => PC_ALTERA_SYNTHESIZED,
		 data2x => ALUPC,
		 data3x => ALUPC,
		 sel => mxA,
		 result => ALUA);


b2v_inst66 : mux2_4
PORT MAP(sel => SYNTHESIZED_WIRE_19,
		 data0x => GDFX_TEMP_SIGNAL_10,
		 data1x => GDFX_TEMP_SIGNAL_11,
		 result => SYNTHESIZED_WIRE_12);


SYNTHESIZED_WIRE_5 <= FPGA_CLK AND SYNTHESIZED_WIRE_20;


SYNTHESIZED_WIRE_19 <= OP_IMM AND SYNTHESIZED_WIRE_21;


SYNTHESIZED_WIRE_22 <= NOT(function3(1));



SYNTHESIZED_WIRE_23 <= SYNTHESIZED_WIRE_22 AND function3(0) AND function3(2);


SYNTHESIZED_WIRE_21 <= NOT(SYNTHESIZED_WIRE_23);



SYNTHESIZED_WIRE_4 <= SW(0) AND SYNTHESIZED_WIRE_24;


SYNTHESIZED_WIRE_20 <= NOT(SW(0));



PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(31) <= MemoryDataIn(31);
ELSE
	DATA(31) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(30) <= MemoryDataIn(30);
ELSE
	DATA(30) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(29) <= MemoryDataIn(29);
ELSE
	DATA(29) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(28) <= MemoryDataIn(28);
ELSE
	DATA(28) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(27) <= MemoryDataIn(27);
ELSE
	DATA(27) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(26) <= MemoryDataIn(26);
ELSE
	DATA(26) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(25) <= MemoryDataIn(25);
ELSE
	DATA(25) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(24) <= MemoryDataIn(24);
ELSE
	DATA(24) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(23) <= MemoryDataIn(23);
ELSE
	DATA(23) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(22) <= MemoryDataIn(22);
ELSE
	DATA(22) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(21) <= MemoryDataIn(21);
ELSE
	DATA(21) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(20) <= MemoryDataIn(20);
ELSE
	DATA(20) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(19) <= MemoryDataIn(19);
ELSE
	DATA(19) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(18) <= MemoryDataIn(18);
ELSE
	DATA(18) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(17) <= MemoryDataIn(17);
ELSE
	DATA(17) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(16) <= MemoryDataIn(16);
ELSE
	DATA(16) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(15) <= MemoryDataIn(15);
ELSE
	DATA(15) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(14) <= MemoryDataIn(14);
ELSE
	DATA(14) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(13) <= MemoryDataIn(13);
ELSE
	DATA(13) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(12) <= MemoryDataIn(12);
ELSE
	DATA(12) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(11) <= MemoryDataIn(11);
ELSE
	DATA(11) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(10) <= MemoryDataIn(10);
ELSE
	DATA(10) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(9) <= MemoryDataIn(9);
ELSE
	DATA(9) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(8) <= MemoryDataIn(8);
ELSE
	DATA(8) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(7) <= MemoryDataIn(7);
ELSE
	DATA(7) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(6) <= MemoryDataIn(6);
ELSE
	DATA(6) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(5) <= MemoryDataIn(5);
ELSE
	DATA(5) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(4) <= MemoryDataIn(4);
ELSE
	DATA(4) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(3) <= MemoryDataIn(3);
ELSE
	DATA(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(2) <= MemoryDataIn(2);
ELSE
	DATA(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(1) <= MemoryDataIn(1);
ELSE
	DATA(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(MemoryDataIn,wr_ALTERA_SYNTHESIZED)
BEGIN
if (wr_ALTERA_SYNTHESIZED = '1') THEN
	DATA(0) <= MemoryDataIn(0);
ELSE
	DATA(0) <= 'Z';
END IF;
END PROCESS;


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
		 data => SYNTHESIZED_WIRE_25,
		 S1 => source1,
		 S2 => source2,
		 RS1 => SYNTHESIZED_WIRE_0,
		 RS2 => SYNTHESIZED_WIRE_1);

wr_ALTERA_SYNTHESIZED <= wrMEM;
WR <= wr_ALTERA_SYNTHESIZED;
MEM<= DATA;
PC <= PC_ALTERA_SYNTHESIZED;

one <= '1';
zero <= '0';
END bdf_type;