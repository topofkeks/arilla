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
-- CREATED		"Sat Aug 21 01:53:51 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY EDGED IS 
	PORT
	(
		I :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		Rising :  OUT  STD_LOGIC;
		Falling :  OUT  STD_LOGIC
	);
END EDGED;

ARCHITECTURE bdf_type OF EDGED IS 

SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;


BEGIN 



PROCESS(clk)
BEGIN
IF (RISING_EDGE(clk)) THEN
	SYNTHESIZED_WIRE_2 <= I;
END IF;
END PROCESS;


PROCESS(clk)
BEGIN
IF (RISING_EDGE(clk)) THEN
	SYNTHESIZED_WIRE_3 <= SYNTHESIZED_WIRE_2;
END IF;
END PROCESS;


Rising <= SYNTHESIZED_WIRE_2 AND SYNTHESIZED_WIRE_0;


SYNTHESIZED_WIRE_0 <= NOT(SYNTHESIZED_WIRE_3);



Falling <= SYNTHESIZED_WIRE_1 AND SYNTHESIZED_WIRE_3;


SYNTHESIZED_WIRE_1 <= NOT(SYNTHESIZED_WIRE_2);



END bdf_type;