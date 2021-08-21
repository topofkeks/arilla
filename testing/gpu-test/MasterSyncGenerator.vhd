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
-- CREATED		"Sat Aug 21 02:07:48 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY MasterSyncGenerator IS 
	PORT
	(
		rst :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		H_SYNC :  OUT  STD_LOGIC;
		V_SYNC :  OUT  STD_LOGIC;
		VIDEO_OUTPUT :  OUT  STD_LOGIC;
		x :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0);
		y :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END MasterSyncGenerator;

ARCHITECTURE bdf_type OF MasterSyncGenerator IS 



BEGIN 



END bdf_type;