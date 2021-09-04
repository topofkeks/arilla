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
-- CREATED		"Mon Aug 30 20:14:53 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY Controller IS 
	PORT
	(
		CLK :  IN  STD_LOGIC;
		RD :  IN  STD_LOGIC;
		WR :  IN  STD_LOGIC;
		PS2_DATA :  INOUT  STD_LOGIC;
		PS2_CLK :  INOUT  STD_LOGIC;
		ADDR :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		DATA :  INOUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		MouseX :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		MouseY :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END Controller;

ARCHITECTURE bdf_type OF Controller IS 

ATTRIBUTE black_box : BOOLEAN;
ATTRIBUTE noopt : BOOLEAN;

COMPONENT lpm_rom_0
	PORT(outclock : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 		 		 		 q	:	OUT	 STD_LOGIC_VECTOR(8 DOWNTO 0)
	 );
END COMPONENT;
ATTRIBUTE black_box OF lpm_rom_0: COMPONENT IS true;
ATTRIBUTE noopt OF lpm_rom_0: COMPONENT IS true;

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

COMPONENT idcreg
GENERIC (clear_value : INTEGER;
			default_value : INTEGER;
			size : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 cl : IN STD_LOGIC;
		 inc : IN STD_LOGIC;
		 dec : IN STD_LOGIC;
		 ld : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
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

COMPONENT add10
	PORT(dataa : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cmpmouseaddr
	PORT(dataa : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 aeb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT const
GENERIC (const : INTEGER;
			size : INTEGER
			);
	PORT(		 data : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cmp6
	PORT(dataa : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 aneb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT dc4
	PORT(data : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 eq1 : OUT STD_LOGIC;
		 eq2 : OUT STD_LOGIC;
		 eq3 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT cmp10
	PORT(dataa : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 aeb : OUT STD_LOGIC;
		 aneb : OUT STD_LOGIC;
		 agb : OUT STD_LOGIC;
		 alb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT debouncer
	PORT(CLK : IN STD_LOGIC;
		 I : IN STD_LOGIC;
		 O : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mux4_10
	PORT(data0x : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 data2x : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 data3x : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sub_controllerinverty
	PORT(datab : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cmp8
	PORT(dataa : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 aeb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT cmp2
	PORT(dataa : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 aeb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT cmp13
	PORT(dataa : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
		 aneb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT edged
	PORT(I : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 Rising : OUT STD_LOGIC;
		 Falling : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT sreg
GENERIC (default_value : INTEGER;
			size : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 sl : IN STD_LOGIC;
		 il : IN STD_LOGIC;
		 ld : IN STD_LOGIC;
		 sr : IN STD_LOGIC;
		 ir : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(32 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(32 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	acked :  STD_LOGIC;
SIGNAL	ba :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	bitsIsNot11 :  STD_LOGIC;
SIGNAL	branch :  STD_LOGIC;
SIGNAL	brbitsIsNot11 :  STD_LOGIC;
SIGNAL	brtimerIsNot0 :  STD_LOGIC;
SIGNAL	bruncnd :  STD_LOGIC;
SIGNAL	Buttons :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	cc :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	changed :  STD_LOGIC;
SIGNAL	clBits :  STD_LOGIC;
SIGNAL	clkFalling :  STD_LOGIC;
SIGNAL	const0 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	const350 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	const599 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	const799 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	Counter :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	dataIsFA :  STD_LOGIC;
SIGNAL	dataValue :  STD_LOGIC;
SIGNAL	decTimer :  STD_LOGIC;
SIGNAL	DELAYADDR :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	DeltaX :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	DeltaY :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	FinalX :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	FinalY :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	memUpdated :  STD_LOGIC;
SIGNAL	NewX :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	NewY :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	one :  STD_LOGIC;
SIGNAL	OutY :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	packetsFull :  STD_LOGIC;
SIGNAL	pulldownCLK :  STD_LOGIC;
SIGNAL	RData :  STD_LOGIC_VECTOR(32 DOWNTO 0);
SIGNAL	srDataAndIncBitsOnFallingEdge :  STD_LOGIC;
SIGNAL	Status :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	timerIsNot0 :  STD_LOGIC;
SIGNAL	wrData :  STD_LOGIC;
SIGNAL	X :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	XChanged :  STD_LOGIC;
SIGNAL	XOverflow :  STD_LOGIC;
SIGNAL	XUnderflow :  STD_LOGIC;
SIGNAL	Y :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	YChanged :  STD_LOGIC;
SIGNAL	YOverflow :  STD_LOGIC;
SIGNAL	YUnderflow :  STD_LOGIC;
SIGNAL	zero :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_17 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_6 :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_4 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_5 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_8 :  STD_LOGIC_VECTOR(32 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_7 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_9 :  STD_LOGIC_VECTOR(12 DOWNTO 0);

BEGIN 

ba(1) <= GDFX_TEMP_SIGNAL_6(8);
ba(0) <= GDFX_TEMP_SIGNAL_6(7);
cc(1) <= GDFX_TEMP_SIGNAL_6(6);
cc(0) <= GDFX_TEMP_SIGNAL_6(5);
wrData <= GDFX_TEMP_SIGNAL_6(4);
pulldownCLK <= GDFX_TEMP_SIGNAL_6(3);
decTimer <= GDFX_TEMP_SIGNAL_6(2);

GDFX_TEMP_SIGNAL_1 <= (OutY(9 DOWNTO 0) & X(9 DOWNTO 0) & zero & zero & zero & zero & zero & zero & zero & zero & changed & Buttons(1 DOWNTO 0) & acked);
GDFX_TEMP_SIGNAL_4 <= (RData(6) & RData(6) & RData(30 DOWNTO 23));
GDFX_TEMP_SIGNAL_3 <= (RData(5) & RData(5) & RData(19 DOWNTO 12));
GDFX_TEMP_SIGNAL_5 <= (YUnderflow & YOverflow);
GDFX_TEMP_SIGNAL_2 <= (XUnderflow & XOverflow);
GDFX_TEMP_SIGNAL_8 <= (zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero);
GDFX_TEMP_SIGNAL_0 <= (zero & zero & zero & zero & zero & zero);
GDFX_TEMP_SIGNAL_7 <= (zero & zero);
GDFX_TEMP_SIGNAL_9 <= (zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero);


b2v_ackedReg : ldreg
GENERIC MAP(default_value => 0,
			size => 1
			)
PORT MAP(clk => CLK,
		 ld => SYNTHESIZED_WIRE_0,
		 data_in(0) => one,
		 data_out(0) => acked);


b2v_BitsReg : idcreg
GENERIC MAP(clear_value => 0,
			default_value => 0,
			size => 6
			)
PORT MAP(clk => CLK,
		 cl => SYNTHESIZED_WIRE_1,
		 inc => clkFalling,
		 dec => zero,
		 ld => zero,
		 data_in => GDFX_TEMP_SIGNAL_0,
		 data_out => SYNTHESIZED_WIRE_7);


b2v_ButtonsReg : ldreg
GENERIC MAP(default_value => 0,
			size => 3
			)
PORT MAP(clk => CLK,
		 ld => packetsFull,
		 data_in => RData(3 DOWNTO 1),
		 data_out => Buttons);


PROCESS(CLK)
VARIABLE synthesized_var_for_changed : STD_LOGIC;
BEGIN
IF (RISING_EDGE(CLK)) THEN
	synthesized_var_for_changed := (NOT(synthesized_var_for_changed) AND SYNTHESIZED_WIRE_2) OR (synthesized_var_for_changed AND (NOT(RD)));
END IF;
	changed <= synthesized_var_for_changed;
END PROCESS;


b2v_CounterReg : idreg
GENERIC MAP(default_value => 0,
			size => 2
			)
PORT MAP(clk => CLK,
		 inc => SYNTHESIZED_WIRE_3,
		 dec => zero,
		 ld => SYNTHESIZED_WIRE_4,
		 data_in => ba,
		 data_out => Counter);


b2v_inst : add10
PORT MAP(dataa => X,
		 datab => DeltaX,
		 result => NewX);


--PROCESS(zero,pulldownCLK)
--BEGIN
--if (pulldownCLK = '1') THEN
--	PS2_CLK <= zero;
--ELSE
--	PS2_CLK <= 'Z';
--END IF;
--END PROCESS;


--PROCESS(RData(0),wrData)
--BEGIN
--if (wrData = '1') THEN
--	PS2_DATA <= RData(0);
--ELSE
--	PS2_DATA <= 'Z';
--END IF;
--END PROCESS;


b2v_inst12 : cmpmouseaddr
PORT MAP(dataa => DELAYADDR,
		 aeb => SYNTHESIZED_WIRE_6);


PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(31) <= Status(31);
ELSE
	DATA(31) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(30) <= Status(30);
ELSE
	DATA(30) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(29) <= Status(29);
ELSE
	DATA(29) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(28) <= Status(28);
ELSE
	DATA(28) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(27) <= Status(27);
ELSE
	DATA(27) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(26) <= Status(26);
ELSE
	DATA(26) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(25) <= Status(25);
ELSE
	DATA(25) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(24) <= Status(24);
ELSE
	DATA(24) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(23) <= Status(23);
ELSE
	DATA(23) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(22) <= Status(22);
ELSE
	DATA(22) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(21) <= Status(21);
ELSE
	DATA(21) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(20) <= Status(20);
ELSE
	DATA(20) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(19) <= Status(19);
ELSE
	DATA(19) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(18) <= Status(18);
ELSE
	DATA(18) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(17) <= Status(17);
ELSE
	DATA(17) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(16) <= Status(16);
ELSE
	DATA(16) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(15) <= Status(15);
ELSE
	DATA(15) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(14) <= Status(14);
ELSE
	DATA(14) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(13) <= Status(13);
ELSE
	DATA(13) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(12) <= Status(12);
ELSE
	DATA(12) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(11) <= Status(11);
ELSE
	DATA(11) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(10) <= Status(10);
ELSE
	DATA(10) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(9) <= Status(9);
ELSE
	DATA(9) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(8) <= Status(8);
ELSE
	DATA(8) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(7) <= Status(7);
ELSE
	DATA(7) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(6) <= Status(6);
ELSE
	DATA(6) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(5) <= Status(5);
ELSE
	DATA(5) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(4) <= Status(4);
ELSE
	DATA(4) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(3) <= Status(3);
ELSE
	DATA(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(2) <= Status(2);
ELSE
	DATA(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(1) <= Status(1);
ELSE
	DATA(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(Status,SYNTHESIZED_WIRE_5)
BEGIN
if (SYNTHESIZED_WIRE_5 = '1') THEN
	DATA(0) <= Status(0);
ELSE
	DATA(0) <= 'Z';
END IF;
END PROCESS;


SYNTHESIZED_WIRE_5 <= SYNTHESIZED_WIRE_6 AND RD;


SYNTHESIZED_WIRE_14 <= timerIsNot0 AND brtimerIsNot0;


SYNTHESIZED_WIRE_13 <= bitsIsNot11 AND brbitsIsNot11;


b2v_inst17 : const
GENERIC MAP(const => 11,
			size => 6
			)
PORT MAP(		 data => SYNTHESIZED_WIRE_8);

Status <= GDFX_TEMP_SIGNAL_1;



b2v_inst19 : cmp6
PORT MAP(dataa => SYNTHESIZED_WIRE_7,
		 datab => SYNTHESIZED_WIRE_8,
		 aneb => bitsIsNot11);


b2v_inst2 : dc4
PORT MAP(data => cc,
		 eq1 => bruncnd,
		 eq2 => brtimerIsNot0,
		 eq3 => brbitsIsNot11);




b2v_inst23 : cmp10
PORT MAP(dataa => NewX,
		 datab => const799,
		 agb => XOverflow);

MouseX <= X;


MouseY <= OutY;



b2v_inst26 : cmp10
PORT MAP(dataa => X,
		 datab => const350,
		 alb => XUnderflow);


b2v_inst27 : const
GENERIC MAP(const => 799,
			size => 10
			)
PORT MAP(		 data => const799);


b2v_inst28 : const
GENERIC MAP(const => 599,
			size => 10
			)
PORT MAP(		 data => const599);


b2v_inst29 : debouncer
PORT MAP(CLK => CLK,
		 I => PS2_CLK,
		 O => SYNTHESIZED_WIRE_16);


b2v_inst3 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => CLK,
		 ld => one,
		 data_in => ADDR,
		 data_out => DELAYADDR);


SYNTHESIZED_WIRE_4 <= branch AND memUpdated;


b2v_inst31 : debouncer
PORT MAP(CLK => CLK,
		 I => PS2_DATA,
		 O => dataValue);


b2v_inst32 : mux4_10
PORT MAP(data0x => NewX,
		 data1x => const799,
		 data2x => NewX,
		 data3x => const0,
		 sel => GDFX_TEMP_SIGNAL_2,
		 result => FinalX);

DeltaX <= GDFX_TEMP_SIGNAL_3;


DeltaY <= GDFX_TEMP_SIGNAL_4;



SYNTHESIZED_WIRE_3 <= SYNTHESIZED_WIRE_9 AND memUpdated;


b2v_inst36 : mux4_10
PORT MAP(data0x => NewY,
		 data1x => const599,
		 data2x => NewY,
		 data3x => const0,
		 sel => GDFX_TEMP_SIGNAL_5,
		 result => FinalY);


b2v_inst37 : const
GENERIC MAP(const => 350,
			size => 10
			)
PORT MAP(		 data => const350);


b2v_inst38 : cmp10
PORT MAP(dataa => NewY,
		 datab => const599,
		 agb => YOverflow);


b2v_inst39 : cmp10
PORT MAP(dataa => X,
		 datab => FinalX,
		 aneb => XChanged);


b2v_inst40 : cmp10
PORT MAP(dataa => Y,
		 datab => FinalY,
		 aneb => YChanged);


SYNTHESIZED_WIRE_2 <= YChanged OR XChanged;


b2v_inst42 : cmp10
PORT MAP(dataa => Y,
		 datab => const350,
		 alb => YUnderflow);


b2v_inst43 : const
GENERIC MAP(const => 0,
			size => 10
			)
PORT MAP(		 data => const0);


b2v_inst44 : sub_controllerinverty
PORT MAP(datab => Y,
		 result => OutY);


b2v_inst46 : cmp8
PORT MAP(dataa => RData(30 DOWNTO 23),
		 aeb => dataIsFA);


SYNTHESIZED_WIRE_1 <= NOT(bitsIsNot11);



SYNTHESIZED_WIRE_12 <= NOT(bitsIsNot11);



b2v_inst5 : lpm_rom_0
PORT MAP(outclock => CLK,
		 address => Counter,
		 q => GDFX_TEMP_SIGNAL_6);


b2v_inst50 : cmp2
PORT MAP(dataa => SYNTHESIZED_WIRE_10,
		 aeb => packetsFull);


SYNTHESIZED_WIRE_0 <= SYNTHESIZED_WIRE_11 AND dataIsFA;


SYNTHESIZED_WIRE_11 <= NOT(bitsIsNot11);



SYNTHESIZED_WIRE_17 <= SYNTHESIZED_WIRE_12 AND acked;


branch <= SYNTHESIZED_WIRE_13 OR bruncnd OR SYNTHESIZED_WIRE_14;


b2v_inst8 : cmp13
PORT MAP(dataa => SYNTHESIZED_WIRE_15,
		 aneb => timerIsNot0);


b2v_inst9 : add10
PORT MAP(dataa => Y,
		 datab => DeltaY,
		 result => NewY);


b2v_instfix1 : edged
PORT MAP(I => SYNTHESIZED_WIRE_16,
		 clk => CLK,
		 Falling => clkFalling);


PROCESS(CLK)
VARIABLE memUpdated_synthesized_var : STD_LOGIC;
BEGIN
IF (RISING_EDGE(CLK)) THEN
	memUpdated_synthesized_var := memUpdated_synthesized_var XOR one;
END IF;
	memUpdated <= memUpdated_synthesized_var;
END PROCESS;


SYNTHESIZED_WIRE_9 <= NOT(branch);



b2v_PacketsReg : idcreg
GENERIC MAP(clear_value => 0,
			default_value => 0,
			size => 2
			)
PORT MAP(clk => CLK,
		 cl => packetsFull,
		 inc => SYNTHESIZED_WIRE_17,
		 dec => zero,
		 ld => zero,
		 data_in => GDFX_TEMP_SIGNAL_7,
		 data_out => SYNTHESIZED_WIRE_10);


b2v_RDataReg : sreg
GENERIC MAP(default_value => 1512,
			size => 33
			)
PORT MAP(clk => CLK,
		 sl => zero,
		 il => zero,
		 ld => zero,
		 sr => clkFalling,
		 ir => dataValue,
		 data_in => GDFX_TEMP_SIGNAL_8,
		 data_out => RData);


b2v_Timer : idreg
GENERIC MAP(default_value => 5050,
			size => 13
			)
PORT MAP(clk => CLK,
		 inc => zero,
		 dec => decTimer,
		 ld => zero,
		 data_in => GDFX_TEMP_SIGNAL_9,
		 data_out => SYNTHESIZED_WIRE_15);


b2v_XReg : ldreg
GENERIC MAP(default_value => 400,
			size => 10
			)
PORT MAP(clk => CLK,
		 ld => packetsFull,
		 data_in => FinalX,
		 data_out => X);


b2v_YReg : ldreg
GENERIC MAP(default_value => 300,
			size => 10
			)
PORT MAP(clk => CLK,
		 ld => packetsFull,
		 data_in => FinalY,
		 data_out => Y);


ba(1 DOWNTO 0) <= GDFX_TEMP_SIGNAL_6(8 DOWNTO 7);
cc(1 DOWNTO 0) <= GDFX_TEMP_SIGNAL_6(6 DOWNTO 5);
clBits <= GDFX_TEMP_SIGNAL_6(4);
decTimer <= GDFX_TEMP_SIGNAL_6(0);
one <= '1';
pulldownCLK <= GDFX_TEMP_SIGNAL_6(1);
srDataAndIncBitsOnFallingEdge <= GDFX_TEMP_SIGNAL_6(3);
wrData <= GDFX_TEMP_SIGNAL_6(2);
zero <= '0';
END bdf_type;