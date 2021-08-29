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
-- CREATED		"Sun Aug 29 14:07:35 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY RectDrawer IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		FC :  IN  STD_LOGIC;
		start :  IN  STD_LOGIC;
		fill :  IN  STD_LOGIC;
		eX :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		eY :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		sX :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		sY :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		WR :  OUT  STD_LOGIC;
		opCMPL :  OUT  STD_LOGIC;
		eXout :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0);
		eYout :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0);
		sXout :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0);
		sYout :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END RectDrawer;

ARCHITECTURE bdf_type OF RectDrawer IS 

COMPONENT cmp11
	PORT(dataa : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 aneb : OUT STD_LOGIC;
		 agb : OUT STD_LOGIC;
		 alb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mux2_11
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT idreg
GENERIC (default_value : INTEGER;
			size : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 inc : IN STD_LOGIC;
		 dec : IN STD_LOGIC;
		 ld : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux2_1
	PORT(data1 : IN STD_LOGIC;
		 data0 : IN STD_LOGIC;
		 sel : IN STD_LOGIC;
		 result : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mux4_11
	PORT(data0x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 data2x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 data3x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ldcreg
GENERIC (clear_value : INTEGER;
			default_value : INTEGER;
			size : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 cl : IN STD_LOGIC;
		 ld : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(0 TO 0);
		 data_out : OUT STD_LOGIC_VECTOR(0 TO 0)
	);
END COMPONENT;

COMPONENT const
GENERIC (const : INTEGER;
			size : INTEGER
			);
	PORT(		 data : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	cY :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	Czero :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	drawAX :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	drawAY :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	drawBX :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	drawBY :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	maxX :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	maxY :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	minX :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	minY :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	one :  STD_LOGIC;
SIGNAL	opCMPL_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	run :  STD_LOGIC;
SIGNAL	sleX :  STD_LOGIC;
SIGNAL	sleY :  STD_LOGIC;
SIGNAL	zero :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	DFF_inst40 :  STD_LOGIC;


BEGIN 
SYNTHESIZED_WIRE_6 <= '1';



b2v_inst : cmp11
PORT MAP(dataa => sX,
		 datab => eX,
		 alb => sleX);


b2v_inst1 : cmp11
PORT MAP(dataa => sY,
		 datab => eY,
		 alb => sleY);


b2v_inst10 : mux2_11
PORT MAP(sel => fill,
		 data0x => drawAY,
		 data1x => cY,
		 result => sYout);


b2v_inst12 : mux2_11
PORT MAP(sel => fill,
		 data0x => drawBX,
		 data1x => eX,
		 result => eXout);


b2v_inst13 : mux2_11
PORT MAP(sel => fill,
		 data0x => drawBY,
		 data1x => cY,
		 result => eYout);



b2v_inst15 : idreg
GENERIC MAP(default_value => 0,
			size => 11
			)
PORT MAP(clk => clk,
		 inc => SYNTHESIZED_WIRE_0,
		 dec => SYNTHESIZED_WIRE_1,
		 ld => start,
		 data_in => SYNTHESIZED_WIRE_2,
		 data_out => cY);


b2v_inst16 : mux2_11
PORT MAP(sel => fill,
		 data0x => Czero(10 DOWNTO 0),
		 data1x => sY,
		 result => SYNTHESIZED_WIRE_2);


SYNTHESIZED_WIRE_0 <= FC AND SYNTHESIZED_WIRE_12;


SYNTHESIZED_WIRE_1 <= SYNTHESIZED_WIRE_4 AND FC;


b2v_inst19 : mux2_1
PORT MAP(data1 => sleY,
		 data0 => one,
		 sel => fill,
		 result => SYNTHESIZED_WIRE_12);


b2v_inst20 : mux4_11
PORT MAP(data0x => minX,
		 data1x => minX,
		 data2x => minX,
		 data3x => maxX,
		 sel => cY(1 DOWNTO 0),
		 result => drawAX);


SYNTHESIZED_WIRE_4 <= NOT(SYNTHESIZED_WIRE_12);



b2v_inst22 : mux4_11
PORT MAP(data0x => minY,
		 data1x => maxY,
		 data2x => minY,
		 data3x => minY,
		 sel => cY(1 DOWNTO 0),
		 result => drawAY);


b2v_inst23 : mux4_11
PORT MAP(data0x => maxX,
		 data1x => maxX,
		 data2x => minX,
		 data3x => maxX,
		 sel => cY(1 DOWNTO 0),
		 result => drawBX);


b2v_inst24 : mux4_11
PORT MAP(data0x => minY,
		 data1x => maxY,
		 data2x => maxY,
		 data3x => maxY,
		 sel => cY(1 DOWNTO 0),
		 result => drawBY);


b2v_inst25 : ldcreg
GENERIC MAP(clear_value => 0,
			default_value => 0,
			size => 1
			)
PORT MAP(clk => clk,
		 cl => opCMPL_ALTERA_SYNTHESIZED,
		 ld => start,
		 data_in(0) => SYNTHESIZED_WIRE_6,
		 data_out(0) => run);



b2v_inst28 : const
GENERIC MAP(const => 0,
			size => 16
			)
PORT MAP(		 data => Czero);


b2v_inst29 : cmp11
PORT MAP(dataa => cY,
		 datab => SYNTHESIZED_WIRE_7,
		 aneb => SYNTHESIZED_WIRE_9);


b2v_inst3 : mux2_11
PORT MAP(sel => fill,
		 data0x => SYNTHESIZED_WIRE_8,
		 data1x => eY,
		 result => SYNTHESIZED_WIRE_7);


SYNTHESIZED_WIRE_10 <= NOT(SYNTHESIZED_WIRE_9);



b2v_inst31 : const
GENERIC MAP(const => 3,
			size => 11
			)
PORT MAP(		 data => SYNTHESIZED_WIRE_8);



opCMPL_ALTERA_SYNTHESIZED <= FC AND SYNTHESIZED_WIRE_10;


b2v_inst4 : mux2_11
PORT MAP(sel => sleX,
		 data0x => eX,
		 data1x => sX,
		 result => minX);


PROCESS(clk)
BEGIN
IF (RISING_EDGE(clk)) THEN
	DFF_inst40 <= SYNTHESIZED_WIRE_11;
END IF;
END PROCESS;


SYNTHESIZED_WIRE_11 <= FC OR start;


b2v_inst5 : mux2_11
PORT MAP(sel => sleX,
		 data0x => sX,
		 data1x => eX,
		 result => maxX);


WR <= DFF_inst40 AND run;


b2v_inst6 : mux2_11
PORT MAP(sel => sleY,
		 data0x => eY,
		 data1x => sY,
		 result => minY);


b2v_inst7 : mux2_11
PORT MAP(sel => sleY,
		 data0x => sY,
		 data1x => eY,
		 result => maxY);


b2v_inst9 : mux2_11
PORT MAP(sel => fill,
		 data0x => drawAX,
		 data1x => sX,
		 result => sXout);

opCMPL <= opCMPL_ALTERA_SYNTHESIZED;

one <= '1';
zero <= '0';
END bdf_type;