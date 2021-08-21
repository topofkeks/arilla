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
-- CREATED		"Sat Aug 21 01:53:02 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY SevenSegmentInterface4 IS 
	PORT
	(
		input :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		HEX0 :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX1 :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX2 :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX3 :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END SevenSegmentInterface4;

ARCHITECTURE bdf_type OF SevenSegmentInterface4 IS 

COMPONENT sevensegmentinterface1
	PORT(bit0 : IN STD_LOGIC;
		 bit1 : IN STD_LOGIC;
		 bit2 : IN STD_LOGIC;
		 bit3 : IN STD_LOGIC;
		 dp : OUT STD_LOGIC;
		 a : OUT STD_LOGIC;
		 b : OUT STD_LOGIC;
		 c : OUT STD_LOGIC;
		 d : OUT STD_LOGIC;
		 e : OUT STD_LOGIC;
		 f : OUT STD_LOGIC;
		 g : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	HEX_ALTERA_SYNTHESIZED0 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	HEX_ALTERA_SYNTHESIZED1 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	HEX_ALTERA_SYNTHESIZED2 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	HEX_ALTERA_SYNTHESIZED3 :  STD_LOGIC_VECTOR(7 DOWNTO 0);


BEGIN 



b2v_inst : sevensegmentinterface1
PORT MAP(bit0 => input(3),
		 bit1 => input(2),
		 bit2 => input(1),
		 bit3 => input(0),
		 dp => HEX_ALTERA_SYNTHESIZED0(7),
		 a => HEX_ALTERA_SYNTHESIZED0(0),
		 b => HEX_ALTERA_SYNTHESIZED0(1),
		 c => HEX_ALTERA_SYNTHESIZED0(2),
		 d => HEX_ALTERA_SYNTHESIZED0(3),
		 e => HEX_ALTERA_SYNTHESIZED0(4),
		 f => HEX_ALTERA_SYNTHESIZED0(5),
		 g => HEX_ALTERA_SYNTHESIZED0(6));


b2v_inst4 : sevensegmentinterface1
PORT MAP(bit0 => input(7),
		 bit1 => input(6),
		 bit2 => input(5),
		 bit3 => input(4),
		 dp => HEX_ALTERA_SYNTHESIZED1(7),
		 a => HEX_ALTERA_SYNTHESIZED1(0),
		 b => HEX_ALTERA_SYNTHESIZED1(1),
		 c => HEX_ALTERA_SYNTHESIZED1(2),
		 d => HEX_ALTERA_SYNTHESIZED1(3),
		 e => HEX_ALTERA_SYNTHESIZED1(4),
		 f => HEX_ALTERA_SYNTHESIZED1(5),
		 g => HEX_ALTERA_SYNTHESIZED1(6));


b2v_inst5 : sevensegmentinterface1
PORT MAP(bit0 => input(11),
		 bit1 => input(10),
		 bit2 => input(9),
		 bit3 => input(8),
		 dp => HEX_ALTERA_SYNTHESIZED2(7),
		 a => HEX_ALTERA_SYNTHESIZED2(0),
		 b => HEX_ALTERA_SYNTHESIZED2(1),
		 c => HEX_ALTERA_SYNTHESIZED2(2),
		 d => HEX_ALTERA_SYNTHESIZED2(3),
		 e => HEX_ALTERA_SYNTHESIZED2(4),
		 f => HEX_ALTERA_SYNTHESIZED2(5),
		 g => HEX_ALTERA_SYNTHESIZED2(6));


b2v_inst6 : sevensegmentinterface1
PORT MAP(bit0 => input(15),
		 bit1 => input(14),
		 bit2 => input(13),
		 bit3 => input(12),
		 dp => HEX_ALTERA_SYNTHESIZED3(7),
		 a => HEX_ALTERA_SYNTHESIZED3(0),
		 b => HEX_ALTERA_SYNTHESIZED3(1),
		 c => HEX_ALTERA_SYNTHESIZED3(2),
		 d => HEX_ALTERA_SYNTHESIZED3(3),
		 e => HEX_ALTERA_SYNTHESIZED3(4),
		 f => HEX_ALTERA_SYNTHESIZED3(5),
		 g => HEX_ALTERA_SYNTHESIZED3(6));

HEX0 <= HEX_ALTERA_SYNTHESIZED0;
HEX1 <= HEX_ALTERA_SYNTHESIZED1;
HEX2 <= HEX_ALTERA_SYNTHESIZED2;
HEX3 <= HEX_ALTERA_SYNTHESIZED3;

END bdf_type;