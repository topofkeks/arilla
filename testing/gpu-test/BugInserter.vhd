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
-- CREATED		"Sat Aug 28 23:35:22 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY BugInserter IS 
	PORT
	(
		cursor :  IN  STD_LOGIC;
		I :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		mx :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		my :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		x :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		y :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		O :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END BugInserter;

ARCHITECTURE bdf_type OF BugInserter IS 

COMPONENT const
GENERIC (const : INTEGER;
			size : INTEGER
			);
	PORT(		 data : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cmp11
	PORT(dataa : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 aneb : OUT STD_LOGIC;
		 agb : OUT STD_LOGIC;
		 alb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mux16_2
	PORT(data0x : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 data10x : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 data11x : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 data2x : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 data3x : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 data4x : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 data5x : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 data6x : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 data7x : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 data8x : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 data9x : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cursorrom
	PORT(ADDR : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 O : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux4_12
	PORT(data0x : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 data2x : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 data3x : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sub11
	PORT(dataa : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	const12 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	const8 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	cursor0 :  STD_LOGIC;
SIGNAL	cursor1 :  STD_LOGIC;
SIGNAL	cursor10 :  STD_LOGIC;
SIGNAL	cursor11 :  STD_LOGIC;
SIGNAL	cursor12 :  STD_LOGIC;
SIGNAL	cursor13 :  STD_LOGIC;
SIGNAL	cursor14 :  STD_LOGIC;
SIGNAL	cursor15 :  STD_LOGIC;
SIGNAL	cursor16 :  STD_LOGIC;
SIGNAL	cursor17 :  STD_LOGIC;
SIGNAL	cursor18 :  STD_LOGIC;
SIGNAL	cursor19 :  STD_LOGIC;
SIGNAL	cursor2 :  STD_LOGIC;
SIGNAL	cursor20 :  STD_LOGIC;
SIGNAL	cursor21 :  STD_LOGIC;
SIGNAL	cursor22 :  STD_LOGIC;
SIGNAL	cursor23 :  STD_LOGIC;
SIGNAL	cursor3 :  STD_LOGIC;
SIGNAL	cursor4 :  STD_LOGIC;
SIGNAL	cursor5 :  STD_LOGIC;
SIGNAL	cursor6 :  STD_LOGIC;
SIGNAL	cursor7 :  STD_LOGIC;
SIGNAL	cursor8 :  STD_LOGIC;
SIGNAL	cursor9 :  STD_LOGIC;
SIGNAL	enabled :  STD_LOGIC;
SIGNAL	pixel :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	xdiff :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	ydiff :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_12 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_13 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_6 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_4 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_5 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_7 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_8 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_9 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_10 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_11 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN 

cursor23 <= GDFX_TEMP_SIGNAL_12(23);
cursor22 <= GDFX_TEMP_SIGNAL_12(22);
cursor21 <= GDFX_TEMP_SIGNAL_12(21);
cursor20 <= GDFX_TEMP_SIGNAL_12(20);
cursor19 <= GDFX_TEMP_SIGNAL_12(19);
cursor18 <= GDFX_TEMP_SIGNAL_12(18);
cursor17 <= GDFX_TEMP_SIGNAL_12(17);
cursor16 <= GDFX_TEMP_SIGNAL_12(16);
cursor15 <= GDFX_TEMP_SIGNAL_12(15);
cursor14 <= GDFX_TEMP_SIGNAL_12(14);
cursor13 <= GDFX_TEMP_SIGNAL_12(13);
cursor12 <= GDFX_TEMP_SIGNAL_12(12);
cursor11 <= GDFX_TEMP_SIGNAL_12(11);
cursor10 <= GDFX_TEMP_SIGNAL_12(10);
cursor9 <= GDFX_TEMP_SIGNAL_12(9);
cursor8 <= GDFX_TEMP_SIGNAL_12(8);
cursor7 <= GDFX_TEMP_SIGNAL_12(7);
cursor6 <= GDFX_TEMP_SIGNAL_12(6);
cursor5 <= GDFX_TEMP_SIGNAL_12(5);
cursor4 <= GDFX_TEMP_SIGNAL_12(4);
cursor3 <= GDFX_TEMP_SIGNAL_12(3);
cursor2 <= GDFX_TEMP_SIGNAL_12(2);
cursor1 <= GDFX_TEMP_SIGNAL_12(1);
cursor0 <= GDFX_TEMP_SIGNAL_12(0);

GDFX_TEMP_SIGNAL_13 <= (enabled & enabled);
GDFX_TEMP_SIGNAL_6 <= (cursor15 & cursor14);
GDFX_TEMP_SIGNAL_3 <= (cursor21 & cursor20);
GDFX_TEMP_SIGNAL_4 <= (cursor19 & cursor18);
GDFX_TEMP_SIGNAL_5 <= (cursor17 & cursor16);
GDFX_TEMP_SIGNAL_7 <= (cursor13 & cursor12);
GDFX_TEMP_SIGNAL_8 <= (cursor11 & cursor10);
GDFX_TEMP_SIGNAL_9 <= (cursor9 & cursor8);
GDFX_TEMP_SIGNAL_10 <= (cursor7 & cursor6);
GDFX_TEMP_SIGNAL_11 <= (cursor5 & cursor4);
GDFX_TEMP_SIGNAL_1 <= (cursor3 & cursor2);
GDFX_TEMP_SIGNAL_2 <= (cursor1 & cursor0);
GDFX_TEMP_SIGNAL_0 <= (cursor23 & cursor22);


b2v_inst : const
GENERIC MAP(const => 0,
			size => 12
			)
PORT MAP(		 data => SYNTHESIZED_WIRE_2);


b2v_inst1 : const
GENERIC MAP(const => 2184,
			size => 12
			)
PORT MAP(		 data => SYNTHESIZED_WIRE_1);


b2v_inst12 : cmp11
PORT MAP(dataa => ydiff,
		 datab => const12,
		 alb => SYNTHESIZED_WIRE_5);


b2v_inst15 : mux16_2
PORT MAP(data0x => GDFX_TEMP_SIGNAL_0,
		 data10x => GDFX_TEMP_SIGNAL_1,
		 data11x => GDFX_TEMP_SIGNAL_2,
		 data1x => GDFX_TEMP_SIGNAL_3,
		 data2x => GDFX_TEMP_SIGNAL_4,
		 data3x => GDFX_TEMP_SIGNAL_5,
		 data4x => GDFX_TEMP_SIGNAL_6,
		 data5x => GDFX_TEMP_SIGNAL_7,
		 data6x => GDFX_TEMP_SIGNAL_8,
		 data7x => GDFX_TEMP_SIGNAL_9,
		 data8x => GDFX_TEMP_SIGNAL_10,
		 data9x => GDFX_TEMP_SIGNAL_11,
		 sel => ydiff(3 DOWNTO 0),
		 result => pixel);


b2v_inst16 : const
GENERIC MAP(const => 8,
			size => 11
			)
PORT MAP(		 data => const8);


b2v_inst17 : const
GENERIC MAP(const => 12,
			size => 11
			)
PORT MAP(		 data => const12);


b2v_inst2 : const
GENERIC MAP(const => 4095,
			size => 12
			)
PORT MAP(		 data => SYNTHESIZED_WIRE_0);


b2v_inst3 : cursorrom
PORT MAP(ADDR => xdiff(2 DOWNTO 0),
		 O => GDFX_TEMP_SIGNAL_12);


b2v_inst4 : mux4_12
PORT MAP(data0x => I,
		 data1x => SYNTHESIZED_WIRE_0,
		 data2x => SYNTHESIZED_WIRE_1,
		 data3x => SYNTHESIZED_WIRE_2,
		 sel => SYNTHESIZED_WIRE_3,
		 result => O);


enabled <= SYNTHESIZED_WIRE_4 AND cursor AND SYNTHESIZED_WIRE_5;


SYNTHESIZED_WIRE_3 <= pixel AND GDFX_TEMP_SIGNAL_13;


b2v_inst7 : sub11
PORT MAP(dataa => x,
		 datab => mx,
		 result => xdiff);


b2v_inst8 : cmp11
PORT MAP(dataa => xdiff,
		 datab => const8,
		 alb => SYNTHESIZED_WIRE_4);


b2v_inst9 : sub11
PORT MAP(dataa => y,
		 datab => my,
		 result => ydiff);


cursor0 <= GDFX_TEMP_SIGNAL_12(0);
cursor1 <= GDFX_TEMP_SIGNAL_12(1);
cursor10 <= GDFX_TEMP_SIGNAL_12(10);
cursor11 <= GDFX_TEMP_SIGNAL_12(11);
cursor12 <= GDFX_TEMP_SIGNAL_12(12);
cursor13 <= GDFX_TEMP_SIGNAL_12(13);
cursor14 <= GDFX_TEMP_SIGNAL_12(14);
cursor15 <= GDFX_TEMP_SIGNAL_12(15);
cursor16 <= GDFX_TEMP_SIGNAL_12(16);
cursor17 <= GDFX_TEMP_SIGNAL_12(17);
cursor18 <= GDFX_TEMP_SIGNAL_12(18);
cursor19 <= GDFX_TEMP_SIGNAL_12(19);
cursor2 <= GDFX_TEMP_SIGNAL_12(2);
cursor20 <= GDFX_TEMP_SIGNAL_12(20);
cursor21 <= GDFX_TEMP_SIGNAL_12(21);
cursor22 <= GDFX_TEMP_SIGNAL_12(22);
cursor23 <= GDFX_TEMP_SIGNAL_12(23);
cursor3 <= GDFX_TEMP_SIGNAL_12(3);
cursor4 <= GDFX_TEMP_SIGNAL_12(4);
cursor5 <= GDFX_TEMP_SIGNAL_12(5);
cursor6 <= GDFX_TEMP_SIGNAL_12(6);
cursor7 <= GDFX_TEMP_SIGNAL_12(7);
cursor8 <= GDFX_TEMP_SIGNAL_12(8);
cursor9 <= GDFX_TEMP_SIGNAL_12(9);
END bdf_type;