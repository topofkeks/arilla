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
-- CREATED		"Sat Aug 21 01:57:24 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY MemAlignExceptionCheck IS 
	PORT
	(
		address :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		function3 :  IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		mem_align_exception :  OUT  STD_LOGIC
	);
END MemAlignExceptionCheck;

ARCHITECTURE bdf_type OF MemAlignExceptionCheck IS 

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;


BEGIN 



mem_align_exception <= SYNTHESIZED_WIRE_0 OR SYNTHESIZED_WIRE_1;


SYNTHESIZED_WIRE_1 <= function3(1) AND SYNTHESIZED_WIRE_2;


SYNTHESIZED_WIRE_0 <= function3(0) AND address(0);


SYNTHESIZED_WIRE_2 <= address(1) OR address(0);


END bdf_type;