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
-- CREATED		"Sat Aug 21 01:59:58 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY StoreGenerator IS 
	PORT
	(
		address :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		function3 :  IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		word :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		byte_enable :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		data :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END StoreGenerator;

ARCHITECTURE bdf_type OF StoreGenerator IS 

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

COMPONENT mux2_4
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

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

COMPONENT dc4e
	PORT(enable : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 eq0 : OUT STD_LOGIC;
		 eq1 : OUT STD_LOGIC;
		 eq2 : OUT STD_LOGIC;
		 eq3 : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	be16bit :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	be8bit :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	one :  STD_LOGIC;
SIGNAL	zero :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_6 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_7 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_8 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_9 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_4 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_5 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_6 <= (one & one & one & one);
GDFX_TEMP_SIGNAL_7 <= (one & one & one & one);
GDFX_TEMP_SIGNAL_8 <= (one & one & one & one);
GDFX_TEMP_SIGNAL_9 <= (one & one & one & one);
GDFX_TEMP_SIGNAL_4 <= (zero & zero & one & one);
GDFX_TEMP_SIGNAL_5 <= (one & one & zero & zero);
GDFX_TEMP_SIGNAL_1 <= (word(15 DOWNTO 0) & word(15 DOWNTO 0));
GDFX_TEMP_SIGNAL_3 <= (word(15 DOWNTO 0) & word(15 DOWNTO 0));
GDFX_TEMP_SIGNAL_0 <= (word(7 DOWNTO 0) & word(7 DOWNTO 0) & word(7 DOWNTO 0) & word(7 DOWNTO 0));
GDFX_TEMP_SIGNAL_2 <= (word(7 DOWNTO 0) & word(7 DOWNTO 0) & word(7 DOWNTO 0) & word(7 DOWNTO 0));


b2v_inst : mux8_32
PORT MAP(data0x => GDFX_TEMP_SIGNAL_0,
		 data1x => GDFX_TEMP_SIGNAL_1,
		 data2x => word,
		 data3x => word,
		 data4x => GDFX_TEMP_SIGNAL_2,
		 data5x => GDFX_TEMP_SIGNAL_3,
		 data6x => word,
		 data7x => word,
		 sel => function3,
		 result => data);


SYNTHESIZED_WIRE_0 <= NOT(function3(1) OR function3(0));


b2v_inst12 : mux2_4
PORT MAP(sel => address(1),
		 data0x => GDFX_TEMP_SIGNAL_4,
		 data1x => GDFX_TEMP_SIGNAL_5,
		 result => be16bit);



b2v_inst6 : mux8_4
PORT MAP(data0x => be8bit,
		 data1x => be16bit,
		 data2x => GDFX_TEMP_SIGNAL_6,
		 data3x => GDFX_TEMP_SIGNAL_7,
		 data4x => be8bit,
		 data5x => be16bit,
		 data6x => GDFX_TEMP_SIGNAL_8,
		 data7x => GDFX_TEMP_SIGNAL_9,
		 sel => function3,
		 result => byte_enable);


b2v_inst8 : dc4e
PORT MAP(enable => SYNTHESIZED_WIRE_0,
		 data => address(1 DOWNTO 0),
		 eq0 => be8bit(0),
		 eq1 => be8bit(1),
		 eq2 => be8bit(2),
		 eq3 => be8bit(3));



one <= '1';
zero <= '0';
END bdf_type;