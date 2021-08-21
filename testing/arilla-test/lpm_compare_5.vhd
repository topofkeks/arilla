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
-- use the following when compiling in Quartus II
--LIBRARY lpm;
--USE lpm.lpm_components.all; 

-- use the following when compiling in third party tools --
-- add lpm_pack.vhd from the Quartus II library
LIBRARY work;
USE work.lpm_components.all;

ENTITY lpm_compare_5 IS 
PORT 
( 
	dataa	:	IN	 STD_LOGIC_VECTOR(6 DOWNTO 0);
	datab	:	IN	 STD_LOGIC_VECTOR(6 DOWNTO 0);
	aeb	:	OUT	 STD_LOGIC
); 
END lpm_compare_5;

ARCHITECTURE bdf_type OF lpm_compare_5 IS 
BEGIN 

-- instantiate LPM macrofunction 

b2v_inst6 : lpm_compare
GENERIC MAP(CHAIN_SIZE => 1,
			LPM_PIPELINE => 0,
			LPM_REPRESENTATION => "UNSIGNED",
			LPM_WIDTH => 7,
			ONE_INPUT_IS_CONSTANT => "YES")
PORT MAP(dataa => dataa,
		 datab => datab,
		 aeb => aeb);

END bdf_type; 