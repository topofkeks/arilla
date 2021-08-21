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
-- CREATED		"Sat Aug 21 01:59:21 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY OpcodeDecoder IS 
	PORT
	(
		opcode :  IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
		OP :  OUT  STD_LOGIC;
		OP_IMM :  OUT  STD_LOGIC;
		BRANCH :  OUT  STD_LOGIC;
		JAL :  OUT  STD_LOGIC;
		JALR :  OUT  STD_LOGIC;
		LUI :  OUT  STD_LOGIC;
		AUIPC :  OUT  STD_LOGIC;
		LOAD :  OUT  STD_LOGIC;
		STORE :  OUT  STD_LOGIC;
		invalid_opcode_exception :  OUT  STD_LOGIC
	);
END OpcodeDecoder;

ARCHITECTURE bdf_type OF OpcodeDecoder IS 

ATTRIBUTE black_box : BOOLEAN;
ATTRIBUTE noopt : BOOLEAN;

COMPONENT lpm_compare_0
	PORT(dataa : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 aeb : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF lpm_compare_0: COMPONENT IS true;
ATTRIBUTE noopt OF lpm_compare_0: COMPONENT IS true;

COMPONENT lpm_compare_1
	PORT(dataa : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 aeb : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF lpm_compare_1: COMPONENT IS true;
ATTRIBUTE noopt OF lpm_compare_1: COMPONENT IS true;

COMPONENT lpm_compare_2
	PORT(dataa : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 aeb : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF lpm_compare_2: COMPONENT IS true;
ATTRIBUTE noopt OF lpm_compare_2: COMPONENT IS true;

COMPONENT lpm_compare_3
	PORT(dataa : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 aeb : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF lpm_compare_3: COMPONENT IS true;
ATTRIBUTE noopt OF lpm_compare_3: COMPONENT IS true;

COMPONENT lpm_compare_4
	PORT(dataa : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 aeb : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF lpm_compare_4: COMPONENT IS true;
ATTRIBUTE noopt OF lpm_compare_4: COMPONENT IS true;

COMPONENT lpm_compare_5
	PORT(dataa : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 aeb : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF lpm_compare_5: COMPONENT IS true;
ATTRIBUTE noopt OF lpm_compare_5: COMPONENT IS true;

COMPONENT lpm_compare_6
	PORT(dataa : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 aeb : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF lpm_compare_6: COMPONENT IS true;
ATTRIBUTE noopt OF lpm_compare_6: COMPONENT IS true;

COMPONENT lpm_compare_7
	PORT(dataa : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 aeb : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF lpm_compare_7: COMPONENT IS true;
ATTRIBUTE noopt OF lpm_compare_7: COMPONENT IS true;

COMPONENT lpm_compare_8
	PORT(dataa : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 aeb : OUT STD_LOGIC);
END COMPONENT;
ATTRIBUTE black_box OF lpm_compare_8: COMPONENT IS true;
ATTRIBUTE noopt OF lpm_compare_8: COMPONENT IS true;

SIGNAL	one :  STD_LOGIC;
SIGNAL	zero :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_6 :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_7 :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_8 :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_5 :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_4 :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN 
OP <= SYNTHESIZED_WIRE_0;
OP_IMM <= SYNTHESIZED_WIRE_1;
BRANCH <= SYNTHESIZED_WIRE_2;
JAL <= SYNTHESIZED_WIRE_4;
JALR <= SYNTHESIZED_WIRE_3;
LUI <= SYNTHESIZED_WIRE_8;
AUIPC <= SYNTHESIZED_WIRE_10;
LOAD <= SYNTHESIZED_WIRE_9;
STORE <= SYNTHESIZED_WIRE_11;
SYNTHESIZED_WIRE_12 <= '0';

GDFX_TEMP_SIGNAL_3 <= (zero & one & zero & zero & zero & one & one);
GDFX_TEMP_SIGNAL_6 <= (one & one & zero & one & one & one & one);
GDFX_TEMP_SIGNAL_7 <= (one & one & zero & zero & one & one & one);
GDFX_TEMP_SIGNAL_8 <= (zero & one & one & zero & one & one & one);
GDFX_TEMP_SIGNAL_1 <= (zero & zero & one & zero & one & one & one);
GDFX_TEMP_SIGNAL_2 <= (zero & zero & zero & zero & zero & one & one);
GDFX_TEMP_SIGNAL_5 <= (one & one & zero & zero & zero & one & one);
GDFX_TEMP_SIGNAL_4 <= (zero & zero & one & zero & zero & one & one);
GDFX_TEMP_SIGNAL_0 <= (zero & one & one & zero & zero & one & one);


b2v_inst : lpm_compare_0
PORT MAP(dataa => opcode,
		 datab => GDFX_TEMP_SIGNAL_0,
		 aeb => SYNTHESIZED_WIRE_0);


b2v_inst10 : lpm_compare_1
PORT MAP(dataa => opcode,
		 datab => GDFX_TEMP_SIGNAL_1,
		 aeb => SYNTHESIZED_WIRE_10);


b2v_inst11 : lpm_compare_2
PORT MAP(dataa => opcode,
		 datab => GDFX_TEMP_SIGNAL_2,
		 aeb => SYNTHESIZED_WIRE_9);


b2v_inst12 : lpm_compare_3
PORT MAP(dataa => opcode,
		 datab => GDFX_TEMP_SIGNAL_3,
		 aeb => SYNTHESIZED_WIRE_11);


invalid_opcode_exception <= NOT(SYNTHESIZED_WIRE_0 OR SYNTHESIZED_WIRE_1 OR SYNTHESIZED_WIRE_2 OR SYNTHESIZED_WIRE_3 OR SYNTHESIZED_WIRE_4 OR SYNTHESIZED_WIRE_12 OR SYNTHESIZED_WIRE_12 OR SYNTHESIZED_WIRE_12 OR SYNTHESIZED_WIRE_8 OR SYNTHESIZED_WIRE_9 OR SYNTHESIZED_WIRE_10 OR SYNTHESIZED_WIRE_11);





b2v_inst5 : lpm_compare_4
PORT MAP(dataa => opcode,
		 datab => GDFX_TEMP_SIGNAL_4,
		 aeb => SYNTHESIZED_WIRE_1);


b2v_inst6 : lpm_compare_5
PORT MAP(dataa => opcode,
		 datab => GDFX_TEMP_SIGNAL_5,
		 aeb => SYNTHESIZED_WIRE_2);


b2v_inst7 : lpm_compare_6
PORT MAP(dataa => opcode,
		 datab => GDFX_TEMP_SIGNAL_6,
		 aeb => SYNTHESIZED_WIRE_4);


b2v_inst8 : lpm_compare_7
PORT MAP(dataa => opcode,
		 datab => GDFX_TEMP_SIGNAL_7,
		 aeb => SYNTHESIZED_WIRE_3);


b2v_inst9 : lpm_compare_8
PORT MAP(dataa => opcode,
		 datab => GDFX_TEMP_SIGNAL_8,
		 aeb => SYNTHESIZED_WIRE_8);


one <= '1';
zero <= '0';
END bdf_type;