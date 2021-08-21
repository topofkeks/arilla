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
-- CREATED		"Sat Aug 21 01:53:40 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY REG1_INC_CL IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		inc :  IN  STD_LOGIC;
		cl :  IN  STD_LOGIC;
		C :  OUT  STD_LOGIC;
		Q :  OUT  STD_LOGIC
	);
END REG1_INC_CL;

ARCHITECTURE bdf_type OF REG1_INC_CL IS 

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	JKFF_inst :  STD_LOGIC;


BEGIN 
Q <= JKFF_inst;



PROCESS(clk)
VARIABLE synthesized_var_for_JKFF_inst : STD_LOGIC;
BEGIN
IF (RISING_EDGE(clk)) THEN
	synthesized_var_for_JKFF_inst := (NOT(synthesized_var_for_JKFF_inst) AND inc) OR (synthesized_var_for_JKFF_inst AND (NOT(SYNTHESIZED_WIRE_0)));
END IF;
	JKFF_inst <= synthesized_var_for_JKFF_inst;
END PROCESS;


C <= inc AND JKFF_inst;


SYNTHESIZED_WIRE_0 <= cl OR inc;


END bdf_type;