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
-- CREATED		"Sat Aug 21 01:59:07 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY MDRGenerator IS 
	PORT
	(
		address :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		function3 :  IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		word :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		data :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END MDRGenerator;

ARCHITECTURE bdf_type OF MDRGenerator IS 

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

COMPONENT signext
GENERIC (in_width : INTEGER;
			out_width : INTEGER
			);
	PORT(I : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 O : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux2_16
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux4_8
	PORT(data0x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data2x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data3x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	8bit0 :  STD_LOGIC;
SIGNAL	one :  STD_LOGIC;
SIGNAL	s16bit :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	s8bit :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	u16bit :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	u8bit :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	zero :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_1 <= (zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & u16bit(15 DOWNTO 0));
GDFX_TEMP_SIGNAL_0 <= (zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & u8bit(7 DOWNTO 0));


b2v_inst : mux8_32
PORT MAP(data0x => s8bit,
		 data1x => s16bit,
		 data2x => word,
		 data3x => word,
		 data4x => GDFX_TEMP_SIGNAL_0,
		 data5x => GDFX_TEMP_SIGNAL_1,
		 data6x => word,
		 data7x => word,
		 sel => function3,
		 result => data);


b2v_inst2 : signext
GENERIC MAP(in_width => 8,
			out_width => 32
			)
PORT MAP(I => u8bit,
		 O => s8bit);


b2v_inst3 : signext
GENERIC MAP(in_width => 16,
			out_width => 32
			)
PORT MAP(I => u16bit,
		 O => s16bit);



b2v_inst5 : mux2_16
PORT MAP(sel => address(0),
		 data0x => word(15 DOWNTO 0),
		 data1x => word(31 DOWNTO 16),
		 result => u16bit);


b2v_inst6 : mux4_8
PORT MAP(data0x => word(7 DOWNTO 0),
		 data1x => word(15 DOWNTO 8),
		 data2x => word(23 DOWNTO 16),
		 data3x => word(31 DOWNTO 24),
		 sel => address(1 DOWNTO 0),
		 result => u8bit);




one <= '1';
zero <= '0';
END bdf_type;