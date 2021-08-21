-- megafunction wizard: %LPM_MUX%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: LPM_MUX 

-- ============================================================
-- File Name: MUX16_32.vhd
-- Megafunction Name(s):
-- 			LPM_MUX
--
-- Simulation Library Files(s):
-- 			lpm
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 13.1.0 Build 162 10/23/2013 SJ Web Edition
-- ************************************************************


--Copyright (C) 1991-2013 Altera Corporation
--Your use of Altera Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Altera Program License 
--Subscription Agreement, Altera MegaCore Function License 
--Agreement, or other applicable license agreement, including, 
--without limitation, that your use is for the sole purpose of 
--programming logic devices manufactured by Altera and sold by 
--Altera or its authorized distributors.  Please refer to the 
--applicable agreement for further details.


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.lpm_components.all;

ENTITY MUX16_32 IS
	PORT
	(
		data0x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data10x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data11x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data12x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data13x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data14x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data15x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data1x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data2x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data3x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data4x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data5x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data6x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data7x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data8x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data9x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		sel		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END MUX16_32;


ARCHITECTURE SYN OF mux16_32 IS

--	type STD_LOGIC_2D is array (NATURAL RANGE <>, NATURAL RANGE <>) of STD_LOGIC;

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire2	: STD_LOGIC_2D (15 DOWNTO 0, 31 DOWNTO 0);
	SIGNAL sub_wire3	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire4	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire5	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire6	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire7	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire8	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire9	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire10	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire11	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire12	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire13	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire14	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire15	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire16	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire17	: STD_LOGIC_VECTOR (31 DOWNTO 0);

BEGIN
	sub_wire17    <= data0x(31 DOWNTO 0);
	sub_wire16    <= data1x(31 DOWNTO 0);
	sub_wire15    <= data2x(31 DOWNTO 0);
	sub_wire14    <= data3x(31 DOWNTO 0);
	sub_wire13    <= data4x(31 DOWNTO 0);
	sub_wire12    <= data5x(31 DOWNTO 0);
	sub_wire11    <= data6x(31 DOWNTO 0);
	sub_wire10    <= data7x(31 DOWNTO 0);
	sub_wire9    <= data8x(31 DOWNTO 0);
	sub_wire8    <= data9x(31 DOWNTO 0);
	sub_wire7    <= data10x(31 DOWNTO 0);
	sub_wire6    <= data11x(31 DOWNTO 0);
	sub_wire5    <= data12x(31 DOWNTO 0);
	sub_wire4    <= data13x(31 DOWNTO 0);
	sub_wire3    <= data14x(31 DOWNTO 0);
	result    <= sub_wire0(31 DOWNTO 0);
	sub_wire1    <= data15x(31 DOWNTO 0);
	sub_wire2(15, 0)    <= sub_wire1(0);
	sub_wire2(15, 1)    <= sub_wire1(1);
	sub_wire2(15, 2)    <= sub_wire1(2);
	sub_wire2(15, 3)    <= sub_wire1(3);
	sub_wire2(15, 4)    <= sub_wire1(4);
	sub_wire2(15, 5)    <= sub_wire1(5);
	sub_wire2(15, 6)    <= sub_wire1(6);
	sub_wire2(15, 7)    <= sub_wire1(7);
	sub_wire2(15, 8)    <= sub_wire1(8);
	sub_wire2(15, 9)    <= sub_wire1(9);
	sub_wire2(15, 10)    <= sub_wire1(10);
	sub_wire2(15, 11)    <= sub_wire1(11);
	sub_wire2(15, 12)    <= sub_wire1(12);
	sub_wire2(15, 13)    <= sub_wire1(13);
	sub_wire2(15, 14)    <= sub_wire1(14);
	sub_wire2(15, 15)    <= sub_wire1(15);
	sub_wire2(15, 16)    <= sub_wire1(16);
	sub_wire2(15, 17)    <= sub_wire1(17);
	sub_wire2(15, 18)    <= sub_wire1(18);
	sub_wire2(15, 19)    <= sub_wire1(19);
	sub_wire2(15, 20)    <= sub_wire1(20);
	sub_wire2(15, 21)    <= sub_wire1(21);
	sub_wire2(15, 22)    <= sub_wire1(22);
	sub_wire2(15, 23)    <= sub_wire1(23);
	sub_wire2(15, 24)    <= sub_wire1(24);
	sub_wire2(15, 25)    <= sub_wire1(25);
	sub_wire2(15, 26)    <= sub_wire1(26);
	sub_wire2(15, 27)    <= sub_wire1(27);
	sub_wire2(15, 28)    <= sub_wire1(28);
	sub_wire2(15, 29)    <= sub_wire1(29);
	sub_wire2(15, 30)    <= sub_wire1(30);
	sub_wire2(15, 31)    <= sub_wire1(31);
	sub_wire2(14, 0)    <= sub_wire3(0);
	sub_wire2(14, 1)    <= sub_wire3(1);
	sub_wire2(14, 2)    <= sub_wire3(2);
	sub_wire2(14, 3)    <= sub_wire3(3);
	sub_wire2(14, 4)    <= sub_wire3(4);
	sub_wire2(14, 5)    <= sub_wire3(5);
	sub_wire2(14, 6)    <= sub_wire3(6);
	sub_wire2(14, 7)    <= sub_wire3(7);
	sub_wire2(14, 8)    <= sub_wire3(8);
	sub_wire2(14, 9)    <= sub_wire3(9);
	sub_wire2(14, 10)    <= sub_wire3(10);
	sub_wire2(14, 11)    <= sub_wire3(11);
	sub_wire2(14, 12)    <= sub_wire3(12);
	sub_wire2(14, 13)    <= sub_wire3(13);
	sub_wire2(14, 14)    <= sub_wire3(14);
	sub_wire2(14, 15)    <= sub_wire3(15);
	sub_wire2(14, 16)    <= sub_wire3(16);
	sub_wire2(14, 17)    <= sub_wire3(17);
	sub_wire2(14, 18)    <= sub_wire3(18);
	sub_wire2(14, 19)    <= sub_wire3(19);
	sub_wire2(14, 20)    <= sub_wire3(20);
	sub_wire2(14, 21)    <= sub_wire3(21);
	sub_wire2(14, 22)    <= sub_wire3(22);
	sub_wire2(14, 23)    <= sub_wire3(23);
	sub_wire2(14, 24)    <= sub_wire3(24);
	sub_wire2(14, 25)    <= sub_wire3(25);
	sub_wire2(14, 26)    <= sub_wire3(26);
	sub_wire2(14, 27)    <= sub_wire3(27);
	sub_wire2(14, 28)    <= sub_wire3(28);
	sub_wire2(14, 29)    <= sub_wire3(29);
	sub_wire2(14, 30)    <= sub_wire3(30);
	sub_wire2(14, 31)    <= sub_wire3(31);
	sub_wire2(13, 0)    <= sub_wire4(0);
	sub_wire2(13, 1)    <= sub_wire4(1);
	sub_wire2(13, 2)    <= sub_wire4(2);
	sub_wire2(13, 3)    <= sub_wire4(3);
	sub_wire2(13, 4)    <= sub_wire4(4);
	sub_wire2(13, 5)    <= sub_wire4(5);
	sub_wire2(13, 6)    <= sub_wire4(6);
	sub_wire2(13, 7)    <= sub_wire4(7);
	sub_wire2(13, 8)    <= sub_wire4(8);
	sub_wire2(13, 9)    <= sub_wire4(9);
	sub_wire2(13, 10)    <= sub_wire4(10);
	sub_wire2(13, 11)    <= sub_wire4(11);
	sub_wire2(13, 12)    <= sub_wire4(12);
	sub_wire2(13, 13)    <= sub_wire4(13);
	sub_wire2(13, 14)    <= sub_wire4(14);
	sub_wire2(13, 15)    <= sub_wire4(15);
	sub_wire2(13, 16)    <= sub_wire4(16);
	sub_wire2(13, 17)    <= sub_wire4(17);
	sub_wire2(13, 18)    <= sub_wire4(18);
	sub_wire2(13, 19)    <= sub_wire4(19);
	sub_wire2(13, 20)    <= sub_wire4(20);
	sub_wire2(13, 21)    <= sub_wire4(21);
	sub_wire2(13, 22)    <= sub_wire4(22);
	sub_wire2(13, 23)    <= sub_wire4(23);
	sub_wire2(13, 24)    <= sub_wire4(24);
	sub_wire2(13, 25)    <= sub_wire4(25);
	sub_wire2(13, 26)    <= sub_wire4(26);
	sub_wire2(13, 27)    <= sub_wire4(27);
	sub_wire2(13, 28)    <= sub_wire4(28);
	sub_wire2(13, 29)    <= sub_wire4(29);
	sub_wire2(13, 30)    <= sub_wire4(30);
	sub_wire2(13, 31)    <= sub_wire4(31);
	sub_wire2(12, 0)    <= sub_wire5(0);
	sub_wire2(12, 1)    <= sub_wire5(1);
	sub_wire2(12, 2)    <= sub_wire5(2);
	sub_wire2(12, 3)    <= sub_wire5(3);
	sub_wire2(12, 4)    <= sub_wire5(4);
	sub_wire2(12, 5)    <= sub_wire5(5);
	sub_wire2(12, 6)    <= sub_wire5(6);
	sub_wire2(12, 7)    <= sub_wire5(7);
	sub_wire2(12, 8)    <= sub_wire5(8);
	sub_wire2(12, 9)    <= sub_wire5(9);
	sub_wire2(12, 10)    <= sub_wire5(10);
	sub_wire2(12, 11)    <= sub_wire5(11);
	sub_wire2(12, 12)    <= sub_wire5(12);
	sub_wire2(12, 13)    <= sub_wire5(13);
	sub_wire2(12, 14)    <= sub_wire5(14);
	sub_wire2(12, 15)    <= sub_wire5(15);
	sub_wire2(12, 16)    <= sub_wire5(16);
	sub_wire2(12, 17)    <= sub_wire5(17);
	sub_wire2(12, 18)    <= sub_wire5(18);
	sub_wire2(12, 19)    <= sub_wire5(19);
	sub_wire2(12, 20)    <= sub_wire5(20);
	sub_wire2(12, 21)    <= sub_wire5(21);
	sub_wire2(12, 22)    <= sub_wire5(22);
	sub_wire2(12, 23)    <= sub_wire5(23);
	sub_wire2(12, 24)    <= sub_wire5(24);
	sub_wire2(12, 25)    <= sub_wire5(25);
	sub_wire2(12, 26)    <= sub_wire5(26);
	sub_wire2(12, 27)    <= sub_wire5(27);
	sub_wire2(12, 28)    <= sub_wire5(28);
	sub_wire2(12, 29)    <= sub_wire5(29);
	sub_wire2(12, 30)    <= sub_wire5(30);
	sub_wire2(12, 31)    <= sub_wire5(31);
	sub_wire2(11, 0)    <= sub_wire6(0);
	sub_wire2(11, 1)    <= sub_wire6(1);
	sub_wire2(11, 2)    <= sub_wire6(2);
	sub_wire2(11, 3)    <= sub_wire6(3);
	sub_wire2(11, 4)    <= sub_wire6(4);
	sub_wire2(11, 5)    <= sub_wire6(5);
	sub_wire2(11, 6)    <= sub_wire6(6);
	sub_wire2(11, 7)    <= sub_wire6(7);
	sub_wire2(11, 8)    <= sub_wire6(8);
	sub_wire2(11, 9)    <= sub_wire6(9);
	sub_wire2(11, 10)    <= sub_wire6(10);
	sub_wire2(11, 11)    <= sub_wire6(11);
	sub_wire2(11, 12)    <= sub_wire6(12);
	sub_wire2(11, 13)    <= sub_wire6(13);
	sub_wire2(11, 14)    <= sub_wire6(14);
	sub_wire2(11, 15)    <= sub_wire6(15);
	sub_wire2(11, 16)    <= sub_wire6(16);
	sub_wire2(11, 17)    <= sub_wire6(17);
	sub_wire2(11, 18)    <= sub_wire6(18);
	sub_wire2(11, 19)    <= sub_wire6(19);
	sub_wire2(11, 20)    <= sub_wire6(20);
	sub_wire2(11, 21)    <= sub_wire6(21);
	sub_wire2(11, 22)    <= sub_wire6(22);
	sub_wire2(11, 23)    <= sub_wire6(23);
	sub_wire2(11, 24)    <= sub_wire6(24);
	sub_wire2(11, 25)    <= sub_wire6(25);
	sub_wire2(11, 26)    <= sub_wire6(26);
	sub_wire2(11, 27)    <= sub_wire6(27);
	sub_wire2(11, 28)    <= sub_wire6(28);
	sub_wire2(11, 29)    <= sub_wire6(29);
	sub_wire2(11, 30)    <= sub_wire6(30);
	sub_wire2(11, 31)    <= sub_wire6(31);
	sub_wire2(10, 0)    <= sub_wire7(0);
	sub_wire2(10, 1)    <= sub_wire7(1);
	sub_wire2(10, 2)    <= sub_wire7(2);
	sub_wire2(10, 3)    <= sub_wire7(3);
	sub_wire2(10, 4)    <= sub_wire7(4);
	sub_wire2(10, 5)    <= sub_wire7(5);
	sub_wire2(10, 6)    <= sub_wire7(6);
	sub_wire2(10, 7)    <= sub_wire7(7);
	sub_wire2(10, 8)    <= sub_wire7(8);
	sub_wire2(10, 9)    <= sub_wire7(9);
	sub_wire2(10, 10)    <= sub_wire7(10);
	sub_wire2(10, 11)    <= sub_wire7(11);
	sub_wire2(10, 12)    <= sub_wire7(12);
	sub_wire2(10, 13)    <= sub_wire7(13);
	sub_wire2(10, 14)    <= sub_wire7(14);
	sub_wire2(10, 15)    <= sub_wire7(15);
	sub_wire2(10, 16)    <= sub_wire7(16);
	sub_wire2(10, 17)    <= sub_wire7(17);
	sub_wire2(10, 18)    <= sub_wire7(18);
	sub_wire2(10, 19)    <= sub_wire7(19);
	sub_wire2(10, 20)    <= sub_wire7(20);
	sub_wire2(10, 21)    <= sub_wire7(21);
	sub_wire2(10, 22)    <= sub_wire7(22);
	sub_wire2(10, 23)    <= sub_wire7(23);
	sub_wire2(10, 24)    <= sub_wire7(24);
	sub_wire2(10, 25)    <= sub_wire7(25);
	sub_wire2(10, 26)    <= sub_wire7(26);
	sub_wire2(10, 27)    <= sub_wire7(27);
	sub_wire2(10, 28)    <= sub_wire7(28);
	sub_wire2(10, 29)    <= sub_wire7(29);
	sub_wire2(10, 30)    <= sub_wire7(30);
	sub_wire2(10, 31)    <= sub_wire7(31);
	sub_wire2(9, 0)    <= sub_wire8(0);
	sub_wire2(9, 1)    <= sub_wire8(1);
	sub_wire2(9, 2)    <= sub_wire8(2);
	sub_wire2(9, 3)    <= sub_wire8(3);
	sub_wire2(9, 4)    <= sub_wire8(4);
	sub_wire2(9, 5)    <= sub_wire8(5);
	sub_wire2(9, 6)    <= sub_wire8(6);
	sub_wire2(9, 7)    <= sub_wire8(7);
	sub_wire2(9, 8)    <= sub_wire8(8);
	sub_wire2(9, 9)    <= sub_wire8(9);
	sub_wire2(9, 10)    <= sub_wire8(10);
	sub_wire2(9, 11)    <= sub_wire8(11);
	sub_wire2(9, 12)    <= sub_wire8(12);
	sub_wire2(9, 13)    <= sub_wire8(13);
	sub_wire2(9, 14)    <= sub_wire8(14);
	sub_wire2(9, 15)    <= sub_wire8(15);
	sub_wire2(9, 16)    <= sub_wire8(16);
	sub_wire2(9, 17)    <= sub_wire8(17);
	sub_wire2(9, 18)    <= sub_wire8(18);
	sub_wire2(9, 19)    <= sub_wire8(19);
	sub_wire2(9, 20)    <= sub_wire8(20);
	sub_wire2(9, 21)    <= sub_wire8(21);
	sub_wire2(9, 22)    <= sub_wire8(22);
	sub_wire2(9, 23)    <= sub_wire8(23);
	sub_wire2(9, 24)    <= sub_wire8(24);
	sub_wire2(9, 25)    <= sub_wire8(25);
	sub_wire2(9, 26)    <= sub_wire8(26);
	sub_wire2(9, 27)    <= sub_wire8(27);
	sub_wire2(9, 28)    <= sub_wire8(28);
	sub_wire2(9, 29)    <= sub_wire8(29);
	sub_wire2(9, 30)    <= sub_wire8(30);
	sub_wire2(9, 31)    <= sub_wire8(31);
	sub_wire2(8, 0)    <= sub_wire9(0);
	sub_wire2(8, 1)    <= sub_wire9(1);
	sub_wire2(8, 2)    <= sub_wire9(2);
	sub_wire2(8, 3)    <= sub_wire9(3);
	sub_wire2(8, 4)    <= sub_wire9(4);
	sub_wire2(8, 5)    <= sub_wire9(5);
	sub_wire2(8, 6)    <= sub_wire9(6);
	sub_wire2(8, 7)    <= sub_wire9(7);
	sub_wire2(8, 8)    <= sub_wire9(8);
	sub_wire2(8, 9)    <= sub_wire9(9);
	sub_wire2(8, 10)    <= sub_wire9(10);
	sub_wire2(8, 11)    <= sub_wire9(11);
	sub_wire2(8, 12)    <= sub_wire9(12);
	sub_wire2(8, 13)    <= sub_wire9(13);
	sub_wire2(8, 14)    <= sub_wire9(14);
	sub_wire2(8, 15)    <= sub_wire9(15);
	sub_wire2(8, 16)    <= sub_wire9(16);
	sub_wire2(8, 17)    <= sub_wire9(17);
	sub_wire2(8, 18)    <= sub_wire9(18);
	sub_wire2(8, 19)    <= sub_wire9(19);
	sub_wire2(8, 20)    <= sub_wire9(20);
	sub_wire2(8, 21)    <= sub_wire9(21);
	sub_wire2(8, 22)    <= sub_wire9(22);
	sub_wire2(8, 23)    <= sub_wire9(23);
	sub_wire2(8, 24)    <= sub_wire9(24);
	sub_wire2(8, 25)    <= sub_wire9(25);
	sub_wire2(8, 26)    <= sub_wire9(26);
	sub_wire2(8, 27)    <= sub_wire9(27);
	sub_wire2(8, 28)    <= sub_wire9(28);
	sub_wire2(8, 29)    <= sub_wire9(29);
	sub_wire2(8, 30)    <= sub_wire9(30);
	sub_wire2(8, 31)    <= sub_wire9(31);
	sub_wire2(7, 0)    <= sub_wire10(0);
	sub_wire2(7, 1)    <= sub_wire10(1);
	sub_wire2(7, 2)    <= sub_wire10(2);
	sub_wire2(7, 3)    <= sub_wire10(3);
	sub_wire2(7, 4)    <= sub_wire10(4);
	sub_wire2(7, 5)    <= sub_wire10(5);
	sub_wire2(7, 6)    <= sub_wire10(6);
	sub_wire2(7, 7)    <= sub_wire10(7);
	sub_wire2(7, 8)    <= sub_wire10(8);
	sub_wire2(7, 9)    <= sub_wire10(9);
	sub_wire2(7, 10)    <= sub_wire10(10);
	sub_wire2(7, 11)    <= sub_wire10(11);
	sub_wire2(7, 12)    <= sub_wire10(12);
	sub_wire2(7, 13)    <= sub_wire10(13);
	sub_wire2(7, 14)    <= sub_wire10(14);
	sub_wire2(7, 15)    <= sub_wire10(15);
	sub_wire2(7, 16)    <= sub_wire10(16);
	sub_wire2(7, 17)    <= sub_wire10(17);
	sub_wire2(7, 18)    <= sub_wire10(18);
	sub_wire2(7, 19)    <= sub_wire10(19);
	sub_wire2(7, 20)    <= sub_wire10(20);
	sub_wire2(7, 21)    <= sub_wire10(21);
	sub_wire2(7, 22)    <= sub_wire10(22);
	sub_wire2(7, 23)    <= sub_wire10(23);
	sub_wire2(7, 24)    <= sub_wire10(24);
	sub_wire2(7, 25)    <= sub_wire10(25);
	sub_wire2(7, 26)    <= sub_wire10(26);
	sub_wire2(7, 27)    <= sub_wire10(27);
	sub_wire2(7, 28)    <= sub_wire10(28);
	sub_wire2(7, 29)    <= sub_wire10(29);
	sub_wire2(7, 30)    <= sub_wire10(30);
	sub_wire2(7, 31)    <= sub_wire10(31);
	sub_wire2(6, 0)    <= sub_wire11(0);
	sub_wire2(6, 1)    <= sub_wire11(1);
	sub_wire2(6, 2)    <= sub_wire11(2);
	sub_wire2(6, 3)    <= sub_wire11(3);
	sub_wire2(6, 4)    <= sub_wire11(4);
	sub_wire2(6, 5)    <= sub_wire11(5);
	sub_wire2(6, 6)    <= sub_wire11(6);
	sub_wire2(6, 7)    <= sub_wire11(7);
	sub_wire2(6, 8)    <= sub_wire11(8);
	sub_wire2(6, 9)    <= sub_wire11(9);
	sub_wire2(6, 10)    <= sub_wire11(10);
	sub_wire2(6, 11)    <= sub_wire11(11);
	sub_wire2(6, 12)    <= sub_wire11(12);
	sub_wire2(6, 13)    <= sub_wire11(13);
	sub_wire2(6, 14)    <= sub_wire11(14);
	sub_wire2(6, 15)    <= sub_wire11(15);
	sub_wire2(6, 16)    <= sub_wire11(16);
	sub_wire2(6, 17)    <= sub_wire11(17);
	sub_wire2(6, 18)    <= sub_wire11(18);
	sub_wire2(6, 19)    <= sub_wire11(19);
	sub_wire2(6, 20)    <= sub_wire11(20);
	sub_wire2(6, 21)    <= sub_wire11(21);
	sub_wire2(6, 22)    <= sub_wire11(22);
	sub_wire2(6, 23)    <= sub_wire11(23);
	sub_wire2(6, 24)    <= sub_wire11(24);
	sub_wire2(6, 25)    <= sub_wire11(25);
	sub_wire2(6, 26)    <= sub_wire11(26);
	sub_wire2(6, 27)    <= sub_wire11(27);
	sub_wire2(6, 28)    <= sub_wire11(28);
	sub_wire2(6, 29)    <= sub_wire11(29);
	sub_wire2(6, 30)    <= sub_wire11(30);
	sub_wire2(6, 31)    <= sub_wire11(31);
	sub_wire2(5, 0)    <= sub_wire12(0);
	sub_wire2(5, 1)    <= sub_wire12(1);
	sub_wire2(5, 2)    <= sub_wire12(2);
	sub_wire2(5, 3)    <= sub_wire12(3);
	sub_wire2(5, 4)    <= sub_wire12(4);
	sub_wire2(5, 5)    <= sub_wire12(5);
	sub_wire2(5, 6)    <= sub_wire12(6);
	sub_wire2(5, 7)    <= sub_wire12(7);
	sub_wire2(5, 8)    <= sub_wire12(8);
	sub_wire2(5, 9)    <= sub_wire12(9);
	sub_wire2(5, 10)    <= sub_wire12(10);
	sub_wire2(5, 11)    <= sub_wire12(11);
	sub_wire2(5, 12)    <= sub_wire12(12);
	sub_wire2(5, 13)    <= sub_wire12(13);
	sub_wire2(5, 14)    <= sub_wire12(14);
	sub_wire2(5, 15)    <= sub_wire12(15);
	sub_wire2(5, 16)    <= sub_wire12(16);
	sub_wire2(5, 17)    <= sub_wire12(17);
	sub_wire2(5, 18)    <= sub_wire12(18);
	sub_wire2(5, 19)    <= sub_wire12(19);
	sub_wire2(5, 20)    <= sub_wire12(20);
	sub_wire2(5, 21)    <= sub_wire12(21);
	sub_wire2(5, 22)    <= sub_wire12(22);
	sub_wire2(5, 23)    <= sub_wire12(23);
	sub_wire2(5, 24)    <= sub_wire12(24);
	sub_wire2(5, 25)    <= sub_wire12(25);
	sub_wire2(5, 26)    <= sub_wire12(26);
	sub_wire2(5, 27)    <= sub_wire12(27);
	sub_wire2(5, 28)    <= sub_wire12(28);
	sub_wire2(5, 29)    <= sub_wire12(29);
	sub_wire2(5, 30)    <= sub_wire12(30);
	sub_wire2(5, 31)    <= sub_wire12(31);
	sub_wire2(4, 0)    <= sub_wire13(0);
	sub_wire2(4, 1)    <= sub_wire13(1);
	sub_wire2(4, 2)    <= sub_wire13(2);
	sub_wire2(4, 3)    <= sub_wire13(3);
	sub_wire2(4, 4)    <= sub_wire13(4);
	sub_wire2(4, 5)    <= sub_wire13(5);
	sub_wire2(4, 6)    <= sub_wire13(6);
	sub_wire2(4, 7)    <= sub_wire13(7);
	sub_wire2(4, 8)    <= sub_wire13(8);
	sub_wire2(4, 9)    <= sub_wire13(9);
	sub_wire2(4, 10)    <= sub_wire13(10);
	sub_wire2(4, 11)    <= sub_wire13(11);
	sub_wire2(4, 12)    <= sub_wire13(12);
	sub_wire2(4, 13)    <= sub_wire13(13);
	sub_wire2(4, 14)    <= sub_wire13(14);
	sub_wire2(4, 15)    <= sub_wire13(15);
	sub_wire2(4, 16)    <= sub_wire13(16);
	sub_wire2(4, 17)    <= sub_wire13(17);
	sub_wire2(4, 18)    <= sub_wire13(18);
	sub_wire2(4, 19)    <= sub_wire13(19);
	sub_wire2(4, 20)    <= sub_wire13(20);
	sub_wire2(4, 21)    <= sub_wire13(21);
	sub_wire2(4, 22)    <= sub_wire13(22);
	sub_wire2(4, 23)    <= sub_wire13(23);
	sub_wire2(4, 24)    <= sub_wire13(24);
	sub_wire2(4, 25)    <= sub_wire13(25);
	sub_wire2(4, 26)    <= sub_wire13(26);
	sub_wire2(4, 27)    <= sub_wire13(27);
	sub_wire2(4, 28)    <= sub_wire13(28);
	sub_wire2(4, 29)    <= sub_wire13(29);
	sub_wire2(4, 30)    <= sub_wire13(30);
	sub_wire2(4, 31)    <= sub_wire13(31);
	sub_wire2(3, 0)    <= sub_wire14(0);
	sub_wire2(3, 1)    <= sub_wire14(1);
	sub_wire2(3, 2)    <= sub_wire14(2);
	sub_wire2(3, 3)    <= sub_wire14(3);
	sub_wire2(3, 4)    <= sub_wire14(4);
	sub_wire2(3, 5)    <= sub_wire14(5);
	sub_wire2(3, 6)    <= sub_wire14(6);
	sub_wire2(3, 7)    <= sub_wire14(7);
	sub_wire2(3, 8)    <= sub_wire14(8);
	sub_wire2(3, 9)    <= sub_wire14(9);
	sub_wire2(3, 10)    <= sub_wire14(10);
	sub_wire2(3, 11)    <= sub_wire14(11);
	sub_wire2(3, 12)    <= sub_wire14(12);
	sub_wire2(3, 13)    <= sub_wire14(13);
	sub_wire2(3, 14)    <= sub_wire14(14);
	sub_wire2(3, 15)    <= sub_wire14(15);
	sub_wire2(3, 16)    <= sub_wire14(16);
	sub_wire2(3, 17)    <= sub_wire14(17);
	sub_wire2(3, 18)    <= sub_wire14(18);
	sub_wire2(3, 19)    <= sub_wire14(19);
	sub_wire2(3, 20)    <= sub_wire14(20);
	sub_wire2(3, 21)    <= sub_wire14(21);
	sub_wire2(3, 22)    <= sub_wire14(22);
	sub_wire2(3, 23)    <= sub_wire14(23);
	sub_wire2(3, 24)    <= sub_wire14(24);
	sub_wire2(3, 25)    <= sub_wire14(25);
	sub_wire2(3, 26)    <= sub_wire14(26);
	sub_wire2(3, 27)    <= sub_wire14(27);
	sub_wire2(3, 28)    <= sub_wire14(28);
	sub_wire2(3, 29)    <= sub_wire14(29);
	sub_wire2(3, 30)    <= sub_wire14(30);
	sub_wire2(3, 31)    <= sub_wire14(31);
	sub_wire2(2, 0)    <= sub_wire15(0);
	sub_wire2(2, 1)    <= sub_wire15(1);
	sub_wire2(2, 2)    <= sub_wire15(2);
	sub_wire2(2, 3)    <= sub_wire15(3);
	sub_wire2(2, 4)    <= sub_wire15(4);
	sub_wire2(2, 5)    <= sub_wire15(5);
	sub_wire2(2, 6)    <= sub_wire15(6);
	sub_wire2(2, 7)    <= sub_wire15(7);
	sub_wire2(2, 8)    <= sub_wire15(8);
	sub_wire2(2, 9)    <= sub_wire15(9);
	sub_wire2(2, 10)    <= sub_wire15(10);
	sub_wire2(2, 11)    <= sub_wire15(11);
	sub_wire2(2, 12)    <= sub_wire15(12);
	sub_wire2(2, 13)    <= sub_wire15(13);
	sub_wire2(2, 14)    <= sub_wire15(14);
	sub_wire2(2, 15)    <= sub_wire15(15);
	sub_wire2(2, 16)    <= sub_wire15(16);
	sub_wire2(2, 17)    <= sub_wire15(17);
	sub_wire2(2, 18)    <= sub_wire15(18);
	sub_wire2(2, 19)    <= sub_wire15(19);
	sub_wire2(2, 20)    <= sub_wire15(20);
	sub_wire2(2, 21)    <= sub_wire15(21);
	sub_wire2(2, 22)    <= sub_wire15(22);
	sub_wire2(2, 23)    <= sub_wire15(23);
	sub_wire2(2, 24)    <= sub_wire15(24);
	sub_wire2(2, 25)    <= sub_wire15(25);
	sub_wire2(2, 26)    <= sub_wire15(26);
	sub_wire2(2, 27)    <= sub_wire15(27);
	sub_wire2(2, 28)    <= sub_wire15(28);
	sub_wire2(2, 29)    <= sub_wire15(29);
	sub_wire2(2, 30)    <= sub_wire15(30);
	sub_wire2(2, 31)    <= sub_wire15(31);
	sub_wire2(1, 0)    <= sub_wire16(0);
	sub_wire2(1, 1)    <= sub_wire16(1);
	sub_wire2(1, 2)    <= sub_wire16(2);
	sub_wire2(1, 3)    <= sub_wire16(3);
	sub_wire2(1, 4)    <= sub_wire16(4);
	sub_wire2(1, 5)    <= sub_wire16(5);
	sub_wire2(1, 6)    <= sub_wire16(6);
	sub_wire2(1, 7)    <= sub_wire16(7);
	sub_wire2(1, 8)    <= sub_wire16(8);
	sub_wire2(1, 9)    <= sub_wire16(9);
	sub_wire2(1, 10)    <= sub_wire16(10);
	sub_wire2(1, 11)    <= sub_wire16(11);
	sub_wire2(1, 12)    <= sub_wire16(12);
	sub_wire2(1, 13)    <= sub_wire16(13);
	sub_wire2(1, 14)    <= sub_wire16(14);
	sub_wire2(1, 15)    <= sub_wire16(15);
	sub_wire2(1, 16)    <= sub_wire16(16);
	sub_wire2(1, 17)    <= sub_wire16(17);
	sub_wire2(1, 18)    <= sub_wire16(18);
	sub_wire2(1, 19)    <= sub_wire16(19);
	sub_wire2(1, 20)    <= sub_wire16(20);
	sub_wire2(1, 21)    <= sub_wire16(21);
	sub_wire2(1, 22)    <= sub_wire16(22);
	sub_wire2(1, 23)    <= sub_wire16(23);
	sub_wire2(1, 24)    <= sub_wire16(24);
	sub_wire2(1, 25)    <= sub_wire16(25);
	sub_wire2(1, 26)    <= sub_wire16(26);
	sub_wire2(1, 27)    <= sub_wire16(27);
	sub_wire2(1, 28)    <= sub_wire16(28);
	sub_wire2(1, 29)    <= sub_wire16(29);
	sub_wire2(1, 30)    <= sub_wire16(30);
	sub_wire2(1, 31)    <= sub_wire16(31);
	sub_wire2(0, 0)    <= sub_wire17(0);
	sub_wire2(0, 1)    <= sub_wire17(1);
	sub_wire2(0, 2)    <= sub_wire17(2);
	sub_wire2(0, 3)    <= sub_wire17(3);
	sub_wire2(0, 4)    <= sub_wire17(4);
	sub_wire2(0, 5)    <= sub_wire17(5);
	sub_wire2(0, 6)    <= sub_wire17(6);
	sub_wire2(0, 7)    <= sub_wire17(7);
	sub_wire2(0, 8)    <= sub_wire17(8);
	sub_wire2(0, 9)    <= sub_wire17(9);
	sub_wire2(0, 10)    <= sub_wire17(10);
	sub_wire2(0, 11)    <= sub_wire17(11);
	sub_wire2(0, 12)    <= sub_wire17(12);
	sub_wire2(0, 13)    <= sub_wire17(13);
	sub_wire2(0, 14)    <= sub_wire17(14);
	sub_wire2(0, 15)    <= sub_wire17(15);
	sub_wire2(0, 16)    <= sub_wire17(16);
	sub_wire2(0, 17)    <= sub_wire17(17);
	sub_wire2(0, 18)    <= sub_wire17(18);
	sub_wire2(0, 19)    <= sub_wire17(19);
	sub_wire2(0, 20)    <= sub_wire17(20);
	sub_wire2(0, 21)    <= sub_wire17(21);
	sub_wire2(0, 22)    <= sub_wire17(22);
	sub_wire2(0, 23)    <= sub_wire17(23);
	sub_wire2(0, 24)    <= sub_wire17(24);
	sub_wire2(0, 25)    <= sub_wire17(25);
	sub_wire2(0, 26)    <= sub_wire17(26);
	sub_wire2(0, 27)    <= sub_wire17(27);
	sub_wire2(0, 28)    <= sub_wire17(28);
	sub_wire2(0, 29)    <= sub_wire17(29);
	sub_wire2(0, 30)    <= sub_wire17(30);
	sub_wire2(0, 31)    <= sub_wire17(31);

	LPM_MUX_component : LPM_MUX
	GENERIC MAP (
		lpm_size => 16,
		lpm_type => "LPM_MUX",
		lpm_width => 32,
		lpm_widths => 4
	)
	PORT MAP (
		data => sub_wire2,
		sel => sel,
		result => sub_wire0
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: new_diagram STRING "1"
-- Retrieval info: LIBRARY: lpm lpm.lpm_components.all
-- Retrieval info: CONSTANT: LPM_SIZE NUMERIC "16"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_MUX"
-- Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "32"
-- Retrieval info: CONSTANT: LPM_WIDTHS NUMERIC "4"
-- Retrieval info: USED_PORT: data0x 0 0 32 0 INPUT NODEFVAL "data0x[31..0]"
-- Retrieval info: USED_PORT: data10x 0 0 32 0 INPUT NODEFVAL "data10x[31..0]"
-- Retrieval info: USED_PORT: data11x 0 0 32 0 INPUT NODEFVAL "data11x[31..0]"
-- Retrieval info: USED_PORT: data12x 0 0 32 0 INPUT NODEFVAL "data12x[31..0]"
-- Retrieval info: USED_PORT: data13x 0 0 32 0 INPUT NODEFVAL "data13x[31..0]"
-- Retrieval info: USED_PORT: data14x 0 0 32 0 INPUT NODEFVAL "data14x[31..0]"
-- Retrieval info: USED_PORT: data15x 0 0 32 0 INPUT NODEFVAL "data15x[31..0]"
-- Retrieval info: USED_PORT: data1x 0 0 32 0 INPUT NODEFVAL "data1x[31..0]"
-- Retrieval info: USED_PORT: data2x 0 0 32 0 INPUT NODEFVAL "data2x[31..0]"
-- Retrieval info: USED_PORT: data3x 0 0 32 0 INPUT NODEFVAL "data3x[31..0]"
-- Retrieval info: USED_PORT: data4x 0 0 32 0 INPUT NODEFVAL "data4x[31..0]"
-- Retrieval info: USED_PORT: data5x 0 0 32 0 INPUT NODEFVAL "data5x[31..0]"
-- Retrieval info: USED_PORT: data6x 0 0 32 0 INPUT NODEFVAL "data6x[31..0]"
-- Retrieval info: USED_PORT: data7x 0 0 32 0 INPUT NODEFVAL "data7x[31..0]"
-- Retrieval info: USED_PORT: data8x 0 0 32 0 INPUT NODEFVAL "data8x[31..0]"
-- Retrieval info: USED_PORT: data9x 0 0 32 0 INPUT NODEFVAL "data9x[31..0]"
-- Retrieval info: USED_PORT: result 0 0 32 0 OUTPUT NODEFVAL "result[31..0]"
-- Retrieval info: USED_PORT: sel 0 0 4 0 INPUT NODEFVAL "sel[3..0]"
-- Retrieval info: CONNECT: @data 1 0 32 0 data0x 0 0 32 0
-- Retrieval info: CONNECT: @data 1 10 32 0 data10x 0 0 32 0
-- Retrieval info: CONNECT: @data 1 11 32 0 data11x 0 0 32 0
-- Retrieval info: CONNECT: @data 1 12 32 0 data12x 0 0 32 0
-- Retrieval info: CONNECT: @data 1 13 32 0 data13x 0 0 32 0
-- Retrieval info: CONNECT: @data 1 14 32 0 data14x 0 0 32 0
-- Retrieval info: CONNECT: @data 1 15 32 0 data15x 0 0 32 0
-- Retrieval info: CONNECT: @data 1 1 32 0 data1x 0 0 32 0
-- Retrieval info: CONNECT: @data 1 2 32 0 data2x 0 0 32 0
-- Retrieval info: CONNECT: @data 1 3 32 0 data3x 0 0 32 0
-- Retrieval info: CONNECT: @data 1 4 32 0 data4x 0 0 32 0
-- Retrieval info: CONNECT: @data 1 5 32 0 data5x 0 0 32 0
-- Retrieval info: CONNECT: @data 1 6 32 0 data6x 0 0 32 0
-- Retrieval info: CONNECT: @data 1 7 32 0 data7x 0 0 32 0
-- Retrieval info: CONNECT: @data 1 8 32 0 data8x 0 0 32 0
-- Retrieval info: CONNECT: @data 1 9 32 0 data9x 0 0 32 0
-- Retrieval info: CONNECT: @sel 0 0 4 0 sel 0 0 4 0
-- Retrieval info: CONNECT: result 0 0 32 0 @result 0 0 32 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL MUX16_32.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL MUX16_32.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL MUX16_32.cmp FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL MUX16_32.bsf TRUE FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL MUX16_32_inst.vhd FALSE
-- Retrieval info: LIB_FILE: lpm
