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
-- CREATED		"Sat Aug 21 02:02:59 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ControllerTest IS 
	PORT
	(
		REAL_CLK :  IN  STD_LOGIC;
		REAL_PS2_DATA :  INOUT  STD_LOGIC;
		REAL_PS2_CLK :  INOUT  STD_LOGIC;
		BTN :  IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		SW :  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
		HEX0_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX1_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX2_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX3_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		LED :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END ControllerTest;

ARCHITECTURE bdf_type OF ControllerTest IS 

COMPONENT sevensegmentinterface4
	PORT(input : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 HEX0 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 HEX1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 HEX2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 HEX3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT const
GENERIC (const : INTEGER;
			size : INTEGER
			);
	PORT(		 data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT controller
	PORT(CLK : IN STD_LOGIC;
		 RD : IN STD_LOGIC;
		 WR : IN STD_LOGIC;
		 PS2_DATA : INOUT STD_LOGIC;
		 PS2_CLK : INOUT STD_LOGIC;
		 ADDR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 DATA : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 MouseX : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 MouseY : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux2_16
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	BUTTON :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	LED_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	one :  STD_LOGIC;
SIGNAL	Status :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	X :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	Y :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	zero :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(31 DOWNTO 0);

SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_0 <= (zero & zero & zero & zero & zero & zero & Y(9 DOWNTO 0));
GDFX_TEMP_SIGNAL_1 <= (zero & zero & zero & zero & zero & zero & X(9 DOWNTO 0));


b2v_inst : sevensegmentinterface4
PORT MAP(input => SYNTHESIZED_WIRE_0,
		 HEX0 => HEX0_D,
		 HEX1 => HEX1_D,
		 HEX2 => HEX2_D,
		 HEX3 => HEX3_D);



b2v_inst2 : const
GENERIC MAP(const => 268435457,
			size => 32
			)
PORT MAP(		 data => SYNTHESIZED_WIRE_1);




b2v_inst3 : controller
PORT MAP(CLK => REAL_CLK,
		 RD => one,
		 WR => zero,
		 PS2_DATA => REAL_PS2_DATA,
		 PS2_CLK => REAL_PS2_CLK,
		 ADDR => SYNTHESIZED_WIRE_1,
		 DATA => Status,
		 MouseX => X,
		 MouseY => Y);

LED_ALTERA_SYNTHESIZED <= Status(3 DOWNTO 0);



b2v_inst4 : mux2_16
PORT MAP(sel => SW(0),
		 data0x => GDFX_TEMP_SIGNAL_0,
		 data1x => GDFX_TEMP_SIGNAL_1,
		 result => SYNTHESIZED_WIRE_0);

LED <= LED_ALTERA_SYNTHESIZED;

one <= '1';
zero <= '0';
END bdf_type;