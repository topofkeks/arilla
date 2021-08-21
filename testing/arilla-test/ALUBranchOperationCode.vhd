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
-- CREATED		"Sat Aug 21 01:59:36 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ALUBranchOperationCode IS 
	PORT
	(
		function3 :  IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		aluop :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ALUBranchOperationCode;

ARCHITECTURE bdf_type OF ALUBranchOperationCode IS 

COMPONENT mux8_4
	PORT(data0x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data2x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data3x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data4x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data5x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data6x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data7x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	one :  STD_LOGIC;
SIGNAL	zero :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_7 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_6 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_5 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_4 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_0 <= (one & zero & zero & one);
GDFX_TEMP_SIGNAL_2 <= (one & zero & zero & one);
GDFX_TEMP_SIGNAL_3 <= (one & zero & zero & one);
GDFX_TEMP_SIGNAL_7 <= (one & one & one & one);
GDFX_TEMP_SIGNAL_6 <= (one & one & one & zero);
GDFX_TEMP_SIGNAL_5 <= (one & one & zero & zero);
GDFX_TEMP_SIGNAL_4 <= (one & zero & one & one);
GDFX_TEMP_SIGNAL_1 <= (one & zero & one & zero);


b2v_inst : mux8_4
PORT MAP(data0x => GDFX_TEMP_SIGNAL_0,
		 data1x => GDFX_TEMP_SIGNAL_1,
		 data2x => GDFX_TEMP_SIGNAL_2,
		 data3x => GDFX_TEMP_SIGNAL_3,
		 data4x => GDFX_TEMP_SIGNAL_4,
		 data5x => GDFX_TEMP_SIGNAL_5,
		 data6x => GDFX_TEMP_SIGNAL_6,
		 data7x => GDFX_TEMP_SIGNAL_7,
		 sel => function3,
		 result => aluop);




one <= '1';
zero <= '0';
END bdf_type;