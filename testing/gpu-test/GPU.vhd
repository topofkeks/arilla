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
-- CREATED		"Sun Aug 29 00:53:23 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY GPU IS 
	PORT
	(
		WR :  IN  STD_LOGIC;
		RD :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		rst :  IN  STD_LOGIC;
		ADDR :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		DATA :  INOUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		mX :  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
		mY :  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
		SDRAM_DQ :  INOUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		H_SYNC :  OUT  STD_LOGIC;
		V_SYNC :  OUT  STD_LOGIC;
		B :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		G :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		R :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		SDRAM_CTRL :  OUT  STD_LOGIC_VECTOR(22 DOWNTO 0)
	);
END GPU;

ARCHITECTURE bdf_type OF GPU IS 

COMPONENT const
GENERIC (const : INTEGER;
			size : INTEGER
			);
	PORT(		 data : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ldreg
GENERIC (default_value : INTEGER;
			size : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 ld : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
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
		 data_in : IN STD_LOGIC_VECTOR(size-1 TO 0);
		 data_out : OUT STD_LOGIC_VECTOR(size-1 TO 0)
	);
END COMPONENT;

COMPONENT mastersyncgenerator
	PORT(rst : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 VIDEO_OUTPUT : OUT STD_LOGIC;
		 H_SYNC : OUT STD_LOGIC;
		 V_SYNC : OUT STD_LOGIC;
		 x : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
		 y : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT edged
	PORT(I : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 Rising : OUT STD_LOGIC;
		 Falling : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT buginserter
	PORT(cursor : IN STD_LOGIC;
		 I : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 mx : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 my : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 y : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 O : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT memorysequencer
	PORT(WR : IN STD_LOGIC;
		 RD : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 color : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 opX : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 opY : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 SDRAM_DQ : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 syncX : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 syncY : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 FC : OUT STD_LOGIC;
		 O : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 SDRAM_CTRL : OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dc8
	PORT(data : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 eq0 : OUT STD_LOGIC;
		 eq1 : OUT STD_LOGIC;
		 eq2 : OUT STD_LOGIC;
		 eq3 : OUT STD_LOGIC;
		 eq4 : OUT STD_LOGIC;
		 eq5 : OUT STD_LOGIC;
		 eq6 : OUT STD_LOGIC;
		 eq7 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT readcache
	PORT(start : IN STD_LOGIC;
		 msfc : IN STD_LOGIC;
		 invalidate : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 I : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 sX : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 sY : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 X : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 Y : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 opCMPL : OUT STD_LOGIC;
		 RD : OUT STD_LOGIC;
		 O : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux8_1
	PORT(data7 : IN STD_LOGIC;
		 data6 : IN STD_LOGIC;
		 data5 : IN STD_LOGIC;
		 data4 : IN STD_LOGIC;
		 data3 : IN STD_LOGIC;
		 data2 : IN STD_LOGIC;
		 data1 : IN STD_LOGIC;
		 data0 : IN STD_LOGIC;
		 sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 result : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT linedrawer
	PORT(start : IN STD_LOGIC;
		 FC : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 eX : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 eY : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 sX : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 sY : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 WR : OUT STD_LOGIC;
		 opCMPL : OUT STD_LOGIC;
		 X : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
		 Y : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rectdrawer
	PORT(fill : IN STD_LOGIC;
		 start : IN STD_LOGIC;
		 FC : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 eX : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 eY : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 sX : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 sY : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 WR : OUT STD_LOGIC;
		 opCMPL : OUT STD_LOGIC;
		 eXout : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
		 eYout : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
		 sXout : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
		 sYout : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cmp_30
	PORT(dataa : IN STD_LOGIC_VECTOR(29 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(29 DOWNTO 0);
		 aeb : OUT STD_LOGIC
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

COMPONENT mux2_11
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	BugB :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	BugG :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	BugR :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	CNTRL :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	COLOR :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	cursor :  STD_LOGIC;
SIGNAL	DATA1x :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	DATA2x :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	EN :  STD_LOGIC;
SIGNAL	eX :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	eY :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	HIT :  STD_LOGIC;
SIGNAL	ldCNTRL :  STD_LOGIC;
SIGNAL	ldCOLOR :  STD_LOGIC;
SIGNAL	ldDATA1x :  STD_LOGIC;
SIGNAL	ldDATA2x :  STD_LOGIC;
SIGNAL	LDFC :  STD_LOGIC;
SIGNAL	ldSTATUS :  STD_LOGIC;
SIGNAL	MSFC :  STD_LOGIC;
SIGNAL	MSWR :  STD_LOGIC;
SIGNAL	OP :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	opCMPL :  STD_LOGIC;
SIGNAL	opDrawLine :  STD_LOGIC;
SIGNAL	opDrawPix :  STD_LOGIC;
SIGNAL	opDrawRect :  STD_LOGIC;
SIGNAL	opFillRect :  STD_LOGIC;
SIGNAL	opGetPix :  STD_LOGIC;
SIGNAL	outCOLOR :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	Pixop :  STD_LOGIC;
SIGNAL	RDFC :  STD_LOGIC;
SIGNAL	ready :  STD_LOGIC;
SIGNAL	Rectop :  STD_LOGIC;
SIGNAL	run :  STD_LOGIC;
SIGNAL	start :  STD_LOGIC;
SIGNAL	STATUS :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	sX :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	sY :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	wrCNTRL :  STD_LOGIC;
SIGNAL	wrDATA1x :  STD_LOGIC;
SIGNAL	wrDATA2x :  STD_LOGIC;
SIGNAL	wrSTATUS :  STD_LOGIC;
SIGNAL	ZERO :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_43 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_44 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_45 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_46 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_47 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_25 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_27 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_28 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_29 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_30 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_31 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_32 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_33 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_34 :  STD_LOGIC_VECTOR(29 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_35 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_36 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_37 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_38 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_39 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_40 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_41 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_42 :  STD_LOGIC_VECTOR(10 DOWNTO 0);

SIGNAL	GDFX_TEMP_SIGNAL_7 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_6 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_5 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_4 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_8 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN 
SYNTHESIZED_WIRE_0 <= '1';
SYNTHESIZED_WIRE_47 <= '0';

BugR(3) <= GDFX_TEMP_SIGNAL_7(11);
BugR(2) <= GDFX_TEMP_SIGNAL_7(10);
BugR(1) <= GDFX_TEMP_SIGNAL_7(9);
BugR(0) <= GDFX_TEMP_SIGNAL_7(8);
BugG(3) <= GDFX_TEMP_SIGNAL_7(7);
BugG(2) <= GDFX_TEMP_SIGNAL_7(6);
BugG(1) <= GDFX_TEMP_SIGNAL_7(5);
BugG(0) <= GDFX_TEMP_SIGNAL_7(4);
BugB(3) <= GDFX_TEMP_SIGNAL_7(3);
BugB(2) <= GDFX_TEMP_SIGNAL_7(2);
BugB(1) <= GDFX_TEMP_SIGNAL_7(1);
BugB(0) <= GDFX_TEMP_SIGNAL_7(0);

GDFX_TEMP_SIGNAL_6 <= (ZERO(0) & mY(9 DOWNTO 0));
GDFX_TEMP_SIGNAL_5 <= (ZERO(0) & mX(9 DOWNTO 0));
GDFX_TEMP_SIGNAL_4 <= (ZERO(0) & DATA2x(19 DOWNTO 10));
GDFX_TEMP_SIGNAL_3 <= (ZERO(0) & DATA2x(9 DOWNTO 0));
GDFX_TEMP_SIGNAL_2 <= (ZERO(0) & DATA1x(19 DOWNTO 10));
GDFX_TEMP_SIGNAL_0 <= (ZERO(0) & DATA1x(9 DOWNTO 0));
GDFX_TEMP_SIGNAL_8 <= (outCOLOR(11 DOWNTO 0) & ZERO(19 DOWNTO 0));
GDFX_TEMP_SIGNAL_1 <= (STATUS(31 DOWNTO 1) & ready);


b2v_B_ADDR : const
GENERIC MAP(const => 134217728,
			size => 30
			)
PORT MAP(		 data => SYNTHESIZED_WIRE_34);


b2v_CNTRLreg : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldCNTRL,
		 data_in => DATA,
		 data_out => CNTRL);


b2v_DATA1reg : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldDATA1x,
		 data_in => DATA,
		 data_out => DATA1x);


b2v_DATA2reg : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldDATA2x,
		 data_in => DATA,
		 data_out => DATA2x);


PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(31) <= CNTRL(31);
ELSE
	DATA(31) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(30) <= CNTRL(30);
ELSE
	DATA(30) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(29) <= CNTRL(29);
ELSE
	DATA(29) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(28) <= CNTRL(28);
ELSE
	DATA(28) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(27) <= CNTRL(27);
ELSE
	DATA(27) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(26) <= CNTRL(26);
ELSE
	DATA(26) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(25) <= CNTRL(25);
ELSE
	DATA(25) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(24) <= CNTRL(24);
ELSE
	DATA(24) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(23) <= CNTRL(23);
ELSE
	DATA(23) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(22) <= CNTRL(22);
ELSE
	DATA(22) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(21) <= CNTRL(21);
ELSE
	DATA(21) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(20) <= CNTRL(20);
ELSE
	DATA(20) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(19) <= CNTRL(19);
ELSE
	DATA(19) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(18) <= CNTRL(18);
ELSE
	DATA(18) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(17) <= CNTRL(17);
ELSE
	DATA(17) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(16) <= CNTRL(16);
ELSE
	DATA(16) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(15) <= CNTRL(15);
ELSE
	DATA(15) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(14) <= CNTRL(14);
ELSE
	DATA(14) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(13) <= CNTRL(13);
ELSE
	DATA(13) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(12) <= CNTRL(12);
ELSE
	DATA(12) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(11) <= CNTRL(11);
ELSE
	DATA(11) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(10) <= CNTRL(10);
ELSE
	DATA(10) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(9) <= CNTRL(9);
ELSE
	DATA(9) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(8) <= CNTRL(8);
ELSE
	DATA(8) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(7) <= CNTRL(7);
ELSE
	DATA(7) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(6) <= CNTRL(6);
ELSE
	DATA(6) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(5) <= CNTRL(5);
ELSE
	DATA(5) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(4) <= CNTRL(4);
ELSE
	DATA(4) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(3) <= CNTRL(3);
ELSE
	DATA(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(2) <= CNTRL(2);
ELSE
	DATA(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(1) <= CNTRL(1);
ELSE
	DATA(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(CNTRL,wrCNTRL)
BEGIN
if (wrCNTRL = '1') THEN
	DATA(0) <= CNTRL(0);
ELSE
	DATA(0) <= 'Z';
END IF;
END PROCESS;


b2v_inst0 : const
GENERIC MAP(const => 0,
			size => 32
			)
PORT MAP(		 data => ZERO);


SYNTHESIZED_WIRE_20 <= NOT(opGetPix);



SYNTHESIZED_WIRE_36 <= RD AND HIT;


b2v_inst11 : ldcreg
GENERIC MAP(clear_value => 0,
			default_value => 0,
			size => 1
			)
PORT MAP(clk => clk,
		 cl => opCMPL,
		 ld => start,
		 data_in(0) => SYNTHESIZED_WIRE_0,
		 data_out(0) => run);

EN <= CNTRL(0);


cursor <= CNTRL(2);


OP <= CNTRL(7 DOWNTO 5);


COLOR <= CNTRL(31 DOWNTO 20);



start <= DATA(1) AND ldCNTRL;

ldSTATUS <= ldCOLOR;



ready <= NOT(run);


sX <= GDFX_TEMP_SIGNAL_0;



PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(31) <= GDFX_TEMP_SIGNAL_1(31);
ELSE
	DATA(31) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(30) <= GDFX_TEMP_SIGNAL_1(30);
ELSE
	DATA(30) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(29) <= GDFX_TEMP_SIGNAL_1(29);
ELSE
	DATA(29) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(28) <= GDFX_TEMP_SIGNAL_1(28);
ELSE
	DATA(28) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(27) <= GDFX_TEMP_SIGNAL_1(27);
ELSE
	DATA(27) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(26) <= GDFX_TEMP_SIGNAL_1(26);
ELSE
	DATA(26) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(25) <= GDFX_TEMP_SIGNAL_1(25);
ELSE
	DATA(25) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(24) <= GDFX_TEMP_SIGNAL_1(24);
ELSE
	DATA(24) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(23) <= GDFX_TEMP_SIGNAL_1(23);
ELSE
	DATA(23) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(22) <= GDFX_TEMP_SIGNAL_1(22);
ELSE
	DATA(22) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(21) <= GDFX_TEMP_SIGNAL_1(21);
ELSE
	DATA(21) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(20) <= GDFX_TEMP_SIGNAL_1(20);
ELSE
	DATA(20) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(19) <= GDFX_TEMP_SIGNAL_1(19);
ELSE
	DATA(19) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(18) <= GDFX_TEMP_SIGNAL_1(18);
ELSE
	DATA(18) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(17) <= GDFX_TEMP_SIGNAL_1(17);
ELSE
	DATA(17) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(16) <= GDFX_TEMP_SIGNAL_1(16);
ELSE
	DATA(16) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(15) <= GDFX_TEMP_SIGNAL_1(15);
ELSE
	DATA(15) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(14) <= GDFX_TEMP_SIGNAL_1(14);
ELSE
	DATA(14) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(13) <= GDFX_TEMP_SIGNAL_1(13);
ELSE
	DATA(13) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(12) <= GDFX_TEMP_SIGNAL_1(12);
ELSE
	DATA(12) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(11) <= GDFX_TEMP_SIGNAL_1(11);
ELSE
	DATA(11) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(10) <= GDFX_TEMP_SIGNAL_1(10);
ELSE
	DATA(10) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(9) <= GDFX_TEMP_SIGNAL_1(9);
ELSE
	DATA(9) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(8) <= GDFX_TEMP_SIGNAL_1(8);
ELSE
	DATA(8) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(7) <= GDFX_TEMP_SIGNAL_1(7);
ELSE
	DATA(7) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(6) <= GDFX_TEMP_SIGNAL_1(6);
ELSE
	DATA(6) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(5) <= GDFX_TEMP_SIGNAL_1(5);
ELSE
	DATA(5) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(4) <= GDFX_TEMP_SIGNAL_1(4);
ELSE
	DATA(4) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(3) <= GDFX_TEMP_SIGNAL_1(3);
ELSE
	DATA(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(2) <= GDFX_TEMP_SIGNAL_1(2);
ELSE
	DATA(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(1) <= GDFX_TEMP_SIGNAL_1(1);
ELSE
	DATA(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,wrSTATUS)
BEGIN
if (wrSTATUS = '1') THEN
	DATA(0) <= GDFX_TEMP_SIGNAL_1(0);
ELSE
	DATA(0) <= 'Z';
END IF;
END PROCESS;

sY <= GDFX_TEMP_SIGNAL_2;


eX <= GDFX_TEMP_SIGNAL_3;


eY <= GDFX_TEMP_SIGNAL_4;



B <= BugB AND (SYNTHESIZED_WIRE_43 & SYNTHESIZED_WIRE_43 & SYNTHESIZED_WIRE_43 & SYNTHESIZED_WIRE_43) AND (EN & EN & EN & EN);


H_SYNC <= SYNTHESIZED_WIRE_2 AND EN;


V_SYNC <= SYNTHESIZED_WIRE_3 AND EN;


G <= BugG AND (SYNTHESIZED_WIRE_43 & SYNTHESIZED_WIRE_43 & SYNTHESIZED_WIRE_43 & SYNTHESIZED_WIRE_43) AND (EN & EN & EN & EN);


R <= BugR AND (SYNTHESIZED_WIRE_43 & SYNTHESIZED_WIRE_43 & SYNTHESIZED_WIRE_43 & SYNTHESIZED_WIRE_43) AND (EN & EN & EN & EN);


PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(31) <= DATA1x(31);
ELSE
	DATA(31) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(30) <= DATA1x(30);
ELSE
	DATA(30) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(29) <= DATA1x(29);
ELSE
	DATA(29) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(28) <= DATA1x(28);
ELSE
	DATA(28) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(27) <= DATA1x(27);
ELSE
	DATA(27) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(26) <= DATA1x(26);
ELSE
	DATA(26) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(25) <= DATA1x(25);
ELSE
	DATA(25) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(24) <= DATA1x(24);
ELSE
	DATA(24) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(23) <= DATA1x(23);
ELSE
	DATA(23) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(22) <= DATA1x(22);
ELSE
	DATA(22) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(21) <= DATA1x(21);
ELSE
	DATA(21) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(20) <= DATA1x(20);
ELSE
	DATA(20) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(19) <= DATA1x(19);
ELSE
	DATA(19) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(18) <= DATA1x(18);
ELSE
	DATA(18) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(17) <= DATA1x(17);
ELSE
	DATA(17) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(16) <= DATA1x(16);
ELSE
	DATA(16) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(15) <= DATA1x(15);
ELSE
	DATA(15) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(14) <= DATA1x(14);
ELSE
	DATA(14) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(13) <= DATA1x(13);
ELSE
	DATA(13) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(12) <= DATA1x(12);
ELSE
	DATA(12) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(11) <= DATA1x(11);
ELSE
	DATA(11) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(10) <= DATA1x(10);
ELSE
	DATA(10) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(9) <= DATA1x(9);
ELSE
	DATA(9) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(8) <= DATA1x(8);
ELSE
	DATA(8) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(7) <= DATA1x(7);
ELSE
	DATA(7) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(6) <= DATA1x(6);
ELSE
	DATA(6) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(5) <= DATA1x(5);
ELSE
	DATA(5) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(4) <= DATA1x(4);
ELSE
	DATA(4) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(3) <= DATA1x(3);
ELSE
	DATA(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(2) <= DATA1x(2);
ELSE
	DATA(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(1) <= DATA1x(1);
ELSE
	DATA(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA1x,wrDATA1x)
BEGIN
if (wrDATA1x = '1') THEN
	DATA(0) <= DATA1x(0);
ELSE
	DATA(0) <= 'Z';
END IF;
END PROCESS;


b2v_inst31 : mastersyncgenerator
PORT MAP(rst => SYNTHESIZED_WIRE_6,
		 clk => clk,
		 VIDEO_OUTPUT => SYNTHESIZED_WIRE_43,
		 H_SYNC => SYNTHESIZED_WIRE_2,
		 V_SYNC => SYNTHESIZED_WIRE_3,
		 x => SYNTHESIZED_WIRE_45,
		 y => SYNTHESIZED_WIRE_46);


b2v_inst32 : edged
PORT MAP(I => EN,
		 clk => clk,
		 Rising => SYNTHESIZED_WIRE_6);


b2v_inst33 : buginserter
PORT MAP(cursor => cursor,
		 I => SYNTHESIZED_WIRE_44,
		 mx => GDFX_TEMP_SIGNAL_5,
		 my => GDFX_TEMP_SIGNAL_6,
		 x => SYNTHESIZED_WIRE_45,
		 y => SYNTHESIZED_WIRE_46,
		 O => GDFX_TEMP_SIGNAL_7);


b2v_inst34 : memorysequencer
PORT MAP(WR => MSWR,
		 RD => SYNTHESIZED_WIRE_10,
		 clk => clk,
		 rst => rst,
		 color => COLOR,
		 opX => SYNTHESIZED_WIRE_11,
		 opY => SYNTHESIZED_WIRE_12,
		 SDRAM_DQ => SDRAM_DQ,
		 syncX => SYNTHESIZED_WIRE_45,
		 syncY => SYNTHESIZED_WIRE_46,
		 FC => MSFC,
		 O => SYNTHESIZED_WIRE_44,
		 SDRAM_CTRL => SDRAM_CTRL);


b2v_inst35 : dc8
PORT MAP(data => OP,
		 eq0 => opDrawPix,
		 eq1 => opDrawLine,
		 eq2 => opDrawRect,
		 eq3 => opFillRect,
		 eq4 => opGetPix);


Pixop <= opGetPix OR opDrawPix;


PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(31) <= DATA2x(31);
ELSE
	DATA(31) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(30) <= DATA2x(30);
ELSE
	DATA(30) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(29) <= DATA2x(29);
ELSE
	DATA(29) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(28) <= DATA2x(28);
ELSE
	DATA(28) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(27) <= DATA2x(27);
ELSE
	DATA(27) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(26) <= DATA2x(26);
ELSE
	DATA(26) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(25) <= DATA2x(25);
ELSE
	DATA(25) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(24) <= DATA2x(24);
ELSE
	DATA(24) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(23) <= DATA2x(23);
ELSE
	DATA(23) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(22) <= DATA2x(22);
ELSE
	DATA(22) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(21) <= DATA2x(21);
ELSE
	DATA(21) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(20) <= DATA2x(20);
ELSE
	DATA(20) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(19) <= DATA2x(19);
ELSE
	DATA(19) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(18) <= DATA2x(18);
ELSE
	DATA(18) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(17) <= DATA2x(17);
ELSE
	DATA(17) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(16) <= DATA2x(16);
ELSE
	DATA(16) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(15) <= DATA2x(15);
ELSE
	DATA(15) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(14) <= DATA2x(14);
ELSE
	DATA(14) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(13) <= DATA2x(13);
ELSE
	DATA(13) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(12) <= DATA2x(12);
ELSE
	DATA(12) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(11) <= DATA2x(11);
ELSE
	DATA(11) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(10) <= DATA2x(10);
ELSE
	DATA(10) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(9) <= DATA2x(9);
ELSE
	DATA(9) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(8) <= DATA2x(8);
ELSE
	DATA(8) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(7) <= DATA2x(7);
ELSE
	DATA(7) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(6) <= DATA2x(6);
ELSE
	DATA(6) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(5) <= DATA2x(5);
ELSE
	DATA(5) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(4) <= DATA2x(4);
ELSE
	DATA(4) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(3) <= DATA2x(3);
ELSE
	DATA(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(2) <= DATA2x(2);
ELSE
	DATA(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(1) <= DATA2x(1);
ELSE
	DATA(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(DATA2x,wrDATA2x)
BEGIN
if (wrDATA2x = '1') THEN
	DATA(0) <= DATA2x(0);
ELSE
	DATA(0) <= 'Z';
END IF;
END PROCESS;


b2v_inst400 : readcache
PORT MAP(start => SYNTHESIZED_WIRE_15,
		 msfc => MSFC,
		 invalidate => SYNTHESIZED_WIRE_16,
		 clk => clk,
		 I => SYNTHESIZED_WIRE_44,
		 sX => SYNTHESIZED_WIRE_45,
		 sY => SYNTHESIZED_WIRE_46,
		 X => sX,
		 Y => sY,
		 opCMPL => ldCOLOR,
		 RD => SYNTHESIZED_WIRE_10,
		 O => outCOLOR);


Rectop <= opFillRect OR opDrawRect;


SYNTHESIZED_WIRE_15 <= opGetPix AND start;


SYNTHESIZED_WIRE_29 <= opDrawPix AND start;


SYNTHESIZED_WIRE_16 <= start AND SYNTHESIZED_WIRE_20;


SYNTHESIZED_WIRE_31 <= opDrawLine AND start;


b2v_inst422 : mux8_1
PORT MAP(data7 => SYNTHESIZED_WIRE_47,
		 data6 => SYNTHESIZED_WIRE_47,
		 data5 => SYNTHESIZED_WIRE_47,
		 data4 => ldCOLOR,
		 data3 => RDFC,
		 data2 => RDFC,
		 data1 => LDFC,
		 data0 => MSFC,
		 sel => OP,
		 result => opCMPL);


SYNTHESIZED_WIRE_33 <= Rectop AND start;



b2v_inst45 : linedrawer
PORT MAP(start => SYNTHESIZED_WIRE_24,
		 FC => MSFC,
		 clk => clk,
		 eX => SYNTHESIZED_WIRE_25,
		 eY => SYNTHESIZED_WIRE_26,
		 sX => SYNTHESIZED_WIRE_27,
		 sY => SYNTHESIZED_WIRE_28,
		 WR => SYNTHESIZED_WIRE_30,
		 opCMPL => LDFC,
		 X => SYNTHESIZED_WIRE_41,
		 Y => SYNTHESIZED_WIRE_42);


MSWR <= SYNTHESIZED_WIRE_29 OR SYNTHESIZED_WIRE_30;


SYNTHESIZED_WIRE_24 <= SYNTHESIZED_WIRE_31 OR SYNTHESIZED_WIRE_32;


b2v_inst477 : rectdrawer
PORT MAP(fill => opFillRect,
		 start => SYNTHESIZED_WIRE_33,
		 FC => LDFC,
		 clk => clk,
		 eX => eX,
		 eY => eY,
		 sX => sX,
		 sY => sY,
		 WR => SYNTHESIZED_WIRE_32,
		 opCMPL => RDFC,
		 eXout => SYNTHESIZED_WIRE_39,
		 eYout => SYNTHESIZED_WIRE_40,
		 sXout => SYNTHESIZED_WIRE_37,
		 sYout => SYNTHESIZED_WIRE_38);



b2v_inst6 : cmp_30
PORT MAP(dataa => ADDR(31 DOWNTO 2),
		 datab => SYNTHESIZED_WIRE_34,
		 aeb => HIT);


b2v_inst7 : dc4e
PORT MAP(enable => SYNTHESIZED_WIRE_35,
		 data => ADDR(1 DOWNTO 0),
		 eq0 => ldCNTRL,
		 eq2 => ldDATA1x,
		 eq3 => ldDATA2x);


b2v_inst8 : dc4e
PORT MAP(enable => SYNTHESIZED_WIRE_36,
		 data => ADDR(1 DOWNTO 0),
		 eq0 => wrCNTRL,
		 eq1 => wrSTATUS,
		 eq2 => wrDATA1x,
		 eq3 => wrDATA2x);


SYNTHESIZED_WIRE_35 <= WR AND HIT;


b2v_instfix1 : mux2_11
PORT MAP(sel => Rectop,
		 data0x => sX,
		 data1x => SYNTHESIZED_WIRE_37,
		 result => SYNTHESIZED_WIRE_27);


b2v_instfix2 : mux2_11
PORT MAP(sel => Rectop,
		 data0x => sY,
		 data1x => SYNTHESIZED_WIRE_38,
		 result => SYNTHESIZED_WIRE_28);


b2v_instfix3 : mux2_11
PORT MAP(sel => Rectop,
		 data0x => eX,
		 data1x => SYNTHESIZED_WIRE_39,
		 result => SYNTHESIZED_WIRE_25);


b2v_instfix4 : mux2_11
PORT MAP(sel => Rectop,
		 data0x => eY,
		 data1x => SYNTHESIZED_WIRE_40,
		 result => SYNTHESIZED_WIRE_26);


b2v_instfix5 : mux2_11
PORT MAP(sel => Pixop,
		 data0x => SYNTHESIZED_WIRE_41,
		 data1x => sX,
		 result => SYNTHESIZED_WIRE_11);


b2v_instfix6 : mux2_11
PORT MAP(sel => Pixop,
		 data0x => SYNTHESIZED_WIRE_42,
		 data1x => sY,
		 result => SYNTHESIZED_WIRE_12);


b2v_STATUSreg : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldSTATUS,
		 data_in => GDFX_TEMP_SIGNAL_8,
		 data_out => STATUS);


BugB(3 DOWNTO 0) <= GDFX_TEMP_SIGNAL_7(3 DOWNTO 0);
BugG(3 DOWNTO 0) <= GDFX_TEMP_SIGNAL_7(7 DOWNTO 4);
BugR(3 DOWNTO 0) <= GDFX_TEMP_SIGNAL_7(11 DOWNTO 8);
END bdf_type;