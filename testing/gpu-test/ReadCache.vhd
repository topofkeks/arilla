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
-- CREATED		"Fri Aug 27 22:58:04 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ReadCache IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		start :  IN  STD_LOGIC;
		msfc :  IN  STD_LOGIC;
		invalidate :  IN  STD_LOGIC;
		I :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		sX :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		sY :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		X :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		Y :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		RD :  OUT  STD_LOGIC;
		opCMPL :  OUT  STD_LOGIC;
		O :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END ReadCache;

ARCHITECTURE bdf_type OF ReadCache IS 

COMPONENT actualreadcacheram
	PORT(wren : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 rdaddress : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 wraddress : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cmp14
	PORT(dataa : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
		 aeb : OUT STD_LOGIC;
		 alb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT cmp9
	PORT(dataa : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		 aeb : OUT STD_LOGIC;
		 alb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT const
GENERIC (const : INTEGER;
			size : INTEGER
			);
	PORT(		 data : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
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
		 data_in : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
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
		 data_in : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cmp2
	PORT(dataa : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 aeb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mux2_9
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	cachedID :  STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL	cacheFull :  STD_LOGIC;
SIGNAL	CACHEID :  STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL	cacheINDEX :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	cacheSIZE :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	fillCNT :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	isCached :  STD_LOGIC;
SIGNAL	one :  STD_LOGIC;
SIGNAL	opCMPL_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	RD_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	resetcnt :  STD_LOGIC;
SIGNAL	run :  STD_LOGIC;
SIGNAL	scacheID :  STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL	smallcache :  STD_LOGIC;
SIGNAL	willBeCached :  STD_LOGIC;
SIGNAL	wren :  STD_LOGIC;
SIGNAL	zero :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_17 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_18 :  STD_LOGIC;
SIGNAL	DFF_inst28 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC_VECTOR(8 DOWNTO 0);

SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(13 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_3 <= (zero & sX(7 DOWNTO 0));
GDFX_TEMP_SIGNAL_2 <= (zero & cacheINDEX(7 DOWNTO 0));
GDFX_TEMP_SIGNAL_0 <= (Y(10 DOWNTO 0) & X(10 DOWNTO 8));
GDFX_TEMP_SIGNAL_1 <= (sY(10 DOWNTO 0) & sX(10 DOWNTO 8));


b2v_inst : actualreadcacheram
PORT MAP(wren => wren,
		 clock => clk,
		 data => I,
		 rdaddress => cacheINDEX,
		 wraddress => fillCNT(7 DOWNTO 0),
		 q => O);


RD_ALTERA_SYNTHESIZED <= SYNTHESIZED_WIRE_0 AND SYNTHESIZED_WIRE_1;

CACHEID <= GDFX_TEMP_SIGNAL_0;


cacheINDEX <= X(7 DOWNTO 0);



b2v_inst12 : cmp14
PORT MAP(dataa => CACHEID,
		 datab => cachedID,
		 aeb => SYNTHESIZED_WIRE_22);

scacheID <= GDFX_TEMP_SIGNAL_1;



b2v_inst14 : cmp9
PORT MAP(dataa => GDFX_TEMP_SIGNAL_2,
		 datab => fillCNT,
		 alb => SYNTHESIZED_WIRE_21);


isCached <= SYNTHESIZED_WIRE_21 AND SYNTHESIZED_WIRE_22;



SYNTHESIZED_WIRE_4 <= NOT(SYNTHESIZED_WIRE_21);



b2v_inst18 : cmp14
PORT MAP(dataa => SYNTHESIZED_WIRE_7,
		 datab => cachedID,
		 aeb => SYNTHESIZED_WIRE_14);


b2v_inst19 : const
GENERIC MAP(const => 16383,
			size => 14
			)
PORT MAP(		 data => SYNTHESIZED_WIRE_7);


b2v_inst2 : idreg
GENERIC MAP(default_value => 0,
			size => 9
			)
PORT MAP(clk => clk,
		 inc => wren,
		 dec => zero,
		 ld => SYNTHESIZED_WIRE_8,
		 data_in => SYNTHESIZED_WIRE_9,
		 data_out => fillCNT);


SYNTHESIZED_WIRE_11 <= NOT(SYNTHESIZED_WIRE_22);



resetcnt <= start AND SYNTHESIZED_WIRE_11;


SYNTHESIZED_WIRE_15 <= SYNTHESIZED_WIRE_12 OR msfc;


b2v_inst23 : cmp14
PORT MAP(dataa => cachedID,
		 datab => scacheID,
		 aeb => SYNTHESIZED_WIRE_18);


b2v_inst24 : ldcreg
GENERIC MAP(clear_value => 16383,
			default_value => 16383,
			size => 14
			)
PORT MAP(clk => clk,
		 cl => invalidate,
		 ld => resetcnt,
		 data_in => CACHEID,
		 data_out => cachedID);


SYNTHESIZED_WIRE_8 <= resetcnt OR invalidate;


b2v_inst26 : cmp9
PORT MAP(dataa => fillCNT,
		 datab => cacheSIZE,
		 alb => SYNTHESIZED_WIRE_13);


cacheFull <= NOT(SYNTHESIZED_WIRE_13);



PROCESS(clk)
BEGIN
IF (RISING_EDGE(clk)) THEN
	DFF_inst28 <= isCached;
END IF;
END PROCESS;


SYNTHESIZED_WIRE_0 <= NOT(cacheFull);



b2v_inst3 : const
GENERIC MAP(const => 0,
			size => 9
			)
PORT MAP(		 data => SYNTHESIZED_WIRE_9);


SYNTHESIZED_WIRE_1 <= NOT(SYNTHESIZED_WIRE_14);



wren <= SYNTHESIZED_WIRE_15 AND RD_ALTERA_SYNTHESIZED;


b2v_inst32 : cmp9
PORT MAP(dataa => GDFX_TEMP_SIGNAL_3,
		 datab => fillCNT,
		 aeb => SYNTHESIZED_WIRE_17);


PROCESS(clk,SYNTHESIZED_WIRE_16)
VARIABLE synthesized_var_for_run : STD_LOGIC;
BEGIN
IF (SYNTHESIZED_WIRE_16 = '0') THEN
	synthesized_var_for_run := '1';
ELSIF (RISING_EDGE(clk)) THEN
	synthesized_var_for_run := (NOT(synthesized_var_for_run) AND start) OR (synthesized_var_for_run AND (NOT(opCMPL_ALTERA_SYNTHESIZED)));
END IF;
	run <= synthesized_var_for_run;
END PROCESS;


SYNTHESIZED_WIRE_12 <= SYNTHESIZED_WIRE_17 AND SYNTHESIZED_WIRE_18;


SYNTHESIZED_WIRE_16 <= NOT(start);



opCMPL_ALTERA_SYNTHESIZED <= DFF_inst28 AND run;




b2v_inst6 : cmp2
PORT MAP(dataa => CACHEID(1 DOWNTO 0),
		 aeb => smallcache);


b2v_inst7 : mux2_9
PORT MAP(sel => smallcache,
		 data0x => SYNTHESIZED_WIRE_19,
		 data1x => SYNTHESIZED_WIRE_20,
		 result => cacheSIZE);


b2v_inst8 : const
GENERIC MAP(const => 32,
			size => 9
			)
PORT MAP(		 data => SYNTHESIZED_WIRE_20);


b2v_inst9 : const
GENERIC MAP(const => 256,
			size => 9
			)
PORT MAP(		 data => SYNTHESIZED_WIRE_19);

RD <= RD_ALTERA_SYNTHESIZED;
opCMPL <= opCMPL_ALTERA_SYNTHESIZED;

one <= '1';
zero <= '0';
END bdf_type;