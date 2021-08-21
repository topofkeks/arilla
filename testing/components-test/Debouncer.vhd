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
-- CREATED		"Sat Aug 21 01:55:21 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY Debouncer IS 
	PORT
	(
		CLK :  IN  STD_LOGIC;
		I :  IN  STD_LOGIC;
		O :  OUT  STD_LOGIC
	);
END Debouncer;

ARCHITECTURE bdf_type OF Debouncer IS 

COMPONENT reg1_inc_cl
	PORT(clk : IN STD_LOGIC;
		 inc : IN STD_LOGIC;
		 cl : IN STD_LOGIC;
		 Q : OUT STD_LOGIC;
		 C : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	notSame :  STD_LOGIC;
SIGNAL	same :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;


BEGIN 



PROCESS(CLK)
BEGIN
IF (RISING_EDGE(CLK)) THEN
	SYNTHESIZED_WIRE_6 <= I;
END IF;
END PROCESS;


PROCESS(CLK)
BEGIN
IF (RISING_EDGE(CLK)) THEN
	IF (SYNTHESIZED_WIRE_0 = '1') THEN
	O <= SYNTHESIZED_WIRE_6;
	END IF;
END IF;
END PROCESS;


b2v_inst2 : reg1_inc_cl
PORT MAP(clk => CLK,
		 inc => same,
		 cl => notSame,
		 Q => SYNTHESIZED_WIRE_3,
		 C => SYNTHESIZED_WIRE_1);


b2v_inst3 : reg1_inc_cl
PORT MAP(clk => CLK,
		 inc => SYNTHESIZED_WIRE_1,
		 cl => notSame,
		 Q => SYNTHESIZED_WIRE_4,
		 C => SYNTHESIZED_WIRE_2);


b2v_inst4 : reg1_inc_cl
PORT MAP(clk => CLK,
		 inc => SYNTHESIZED_WIRE_2,
		 cl => notSame,
		 Q => SYNTHESIZED_WIRE_5);


SYNTHESIZED_WIRE_0 <= SYNTHESIZED_WIRE_3 AND SYNTHESIZED_WIRE_4 AND SYNTHESIZED_WIRE_5;


notSame <= I XOR SYNTHESIZED_WIRE_6;


same <= NOT(notSame);



END bdf_type;