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
-- CREATED		"Mon Aug 23 21:53:03 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY LineDrawer IS 
	PORT
	(
		start :  IN  STD_LOGIC;
		FC :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		eX :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		eY :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		sX :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		sY :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		WR :  OUT  STD_LOGIC;
		opCMPL :  OUT  STD_LOGIC;
		X :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0);
		Y :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END LineDrawer;

ARCHITECTURE bdf_type OF LineDrawer IS 

COMPONENT cmp11
	PORT(dataa : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 aneb : OUT STD_LOGIC;
		 agb : OUT STD_LOGIC;
		 alb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT addsubs_11
	PORT(add_sub : IN STD_LOGIC;
		 dataa : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
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
		 data_in : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ldreg
GENERIC (default_value : INTEGER;
			size : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 ld : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT const
GENERIC (const : INTEGER;
			size : INTEGER
			);
	PORT(		 data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux2_16
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux2_11
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT signext
GENERIC (in_width : INTEGER;
			out_width : INTEGER
			);
	PORT(I : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 O : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT addsubs_16
	PORT(add_sub : IN STD_LOGIC;
		 dataa : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux4_16
	PORT(data0x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 data2x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 data3x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cmp16
	PORT(dataa : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 ageb : OUT STD_LOGIC;
		 aleb : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	cX :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	cY :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	Czero :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	dx :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	dy :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	ERR :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	ETWO :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	last :  STD_LOGIC;
SIGNAL	ldERR :  STD_LOGIC;
SIGNAL	maxX :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	maxY :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	minX :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	minY :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	mvX :  STD_LOGIC;
SIGNAL	mvY :  STD_LOGIC;
SIGNAL	one :  STD_LOGIC;
SIGNAL	opCMPL_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	run :  STD_LOGIC;
SIGNAL	sleX :  STD_LOGIC;
SIGNAL	sleY :  STD_LOGIC;
SIGNAL	zero :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_17 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_18 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC;
SIGNAL	DFF_inst40 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_1 <= (start & start);
GDFX_TEMP_SIGNAL_2 <= (mvX & mvY);
GDFX_TEMP_SIGNAL_0 <= (ERR(14 DOWNTO 0) & zero);


b2v_inst : cmp11
PORT MAP(dataa => sX,
		 datab => eX,
		 alb => sleX);


b2v_inst1 : cmp11
PORT MAP(dataa => sY,
		 datab => eY,
		 alb => sleY);


SYNTHESIZED_WIRE_22 <= SYNTHESIZED_WIRE_0 AND SYNTHESIZED_WIRE_1;


SYNTHESIZED_WIRE_1 <= NOT(opCMPL_ALTERA_SYNTHESIZED);



b2v_inst12 : addsubs_11
PORT MAP(add_sub => zero,
		 dataa => maxX,
		 datab => minX,
		 result => SYNTHESIZED_WIRE_14);


b2v_inst13 : addsubs_11
PORT MAP(add_sub => zero,
		 dataa => minY,
		 datab => maxY,
		 result => SYNTHESIZED_WIRE_15);



b2v_inst15 : idreg
GENERIC MAP(default_value => 0,
			size => 11
			)
PORT MAP(clk => clk,
		 inc => SYNTHESIZED_WIRE_2,
		 dec => SYNTHESIZED_WIRE_3,
		 ld => start,
		 data_in => sX,
		 data_out => cX);


b2v_inst16 : idreg
GENERIC MAP(default_value => 0,
			size => 11
			)
PORT MAP(clk => clk,
		 inc => SYNTHESIZED_WIRE_4,
		 dec => SYNTHESIZED_WIRE_5,
		 ld => start,
		 data_in => sY,
		 data_out => cY);


SYNTHESIZED_WIRE_2 <= mvX AND sleX;


SYNTHESIZED_WIRE_3 <= SYNTHESIZED_WIRE_6 AND mvX;


SYNTHESIZED_WIRE_4 <= mvY AND sleY;


b2v_inst2 : cmp11
PORT MAP(dataa => cY,
		 datab => eY,
		 aneb => SYNTHESIZED_WIRE_10);


SYNTHESIZED_WIRE_5 <= SYNTHESIZED_WIRE_7 AND mvY;


SYNTHESIZED_WIRE_6 <= NOT(sleX);



SYNTHESIZED_WIRE_7 <= NOT(sleY);



b2v_inst23 : ldreg
GENERIC MAP(default_value => 0,
			size => 16
			)
PORT MAP(clk => clk,
		 ld => ldERR,
		 data_in => SYNTHESIZED_WIRE_8,
		 data_out => ERR);


SYNTHESIZED_WIRE_0 <= run OR start;



b2v_inst28 : const
GENERIC MAP(const => 0,
			size => 16
			)
PORT MAP(		 data => Czero);


b2v_inst29 : cmp11
PORT MAP(dataa => cX,
		 datab => eX,
		 aneb => SYNTHESIZED_WIRE_9);


b2v_inst3 : mux2_16
PORT MAP(sel => start,
		 data0x => ERR,
		 data1x => Czero,
		 result => SYNTHESIZED_WIRE_16);


SYNTHESIZED_WIRE_11 <= NOT(SYNTHESIZED_WIRE_9);



SYNTHESIZED_WIRE_12 <= NOT(SYNTHESIZED_WIRE_10);



last <= SYNTHESIZED_WIRE_11 AND SYNTHESIZED_WIRE_12;


opCMPL_ALTERA_SYNTHESIZED <= FC AND last;


b2v_inst4 : mux2_11
PORT MAP(sel => sleX,
		 data0x => eX,
		 data1x => sX,
		 result => minX);


PROCESS(clk)
BEGIN
IF (RISING_EDGE(clk)) THEN
	DFF_inst40 <= SYNTHESIZED_WIRE_13;
END IF;
END PROCESS;


SYNTHESIZED_WIRE_13 <= FC OR start;

ETWO <= GDFX_TEMP_SIGNAL_0;



b2v_inst43 : signext
GENERIC MAP(in_width => 11,
			out_width => 16
			)
PORT MAP(I => SYNTHESIZED_WIRE_14,
		 O => dx);


b2v_inst44 : signext
GENERIC MAP(in_width => 11,
			out_width => 16
			)
PORT MAP(I => SYNTHESIZED_WIRE_15,
		 O => dy);


b2v_inst45 : addsubs_16
PORT MAP(add_sub => one,
		 dataa => dx,
		 datab => dy,
		 result => SYNTHESIZED_WIRE_18);


b2v_inst46 : addsubs_16
PORT MAP(add_sub => one,
		 dataa => SYNTHESIZED_WIRE_16,
		 datab => SYNTHESIZED_WIRE_17,
		 result => SYNTHESIZED_WIRE_8);


b2v_inst47 : mux4_16
PORT MAP(data0x => Czero,
		 data1x => dx,
		 data2x => dy,
		 data3x => SYNTHESIZED_WIRE_18,
		 sel => SYNTHESIZED_WIRE_19,
		 result => SYNTHESIZED_WIRE_17);


SYNTHESIZED_WIRE_19 <= GDFX_TEMP_SIGNAL_1 OR GDFX_TEMP_SIGNAL_2;


ldERR <= FC OR start;


b2v_inst5 : mux2_11
PORT MAP(sel => sleX,
		 data0x => sX,
		 data1x => eX,
		 result => maxX);


b2v_inst50 : cmp16
PORT MAP(dataa => ETWO,
		 datab => dy,
		 ageb => SYNTHESIZED_WIRE_20);


b2v_inst51 : cmp16
PORT MAP(dataa => ETWO,
		 datab => dx,
		 aleb => SYNTHESIZED_WIRE_21);


mvX <= SYNTHESIZED_WIRE_20 AND FC;


mvY <= FC AND SYNTHESIZED_WIRE_21;


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


PROCESS(clk)
BEGIN
IF (RISING_EDGE(clk)) THEN
	run <= SYNTHESIZED_WIRE_22;
END IF;
END PROCESS;

opCMPL <= opCMPL_ALTERA_SYNTHESIZED;
X <= cX;
Y <= cY;

one <= '1';
zero <= '0';
END bdf_type;