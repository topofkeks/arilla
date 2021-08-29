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
-- CREATED		"Sat Aug 28 23:36:24 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ActualReadCacheRAM IS 
	PORT
	(
		wren :  IN  STD_LOGIC;
		clock :  IN  STD_LOGIC;
		data :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		rdaddress :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		wraddress :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		q :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END ActualReadCacheRAM;

ARCHITECTURE bdf_type OF ActualReadCacheRAM IS 

COMPONENT readcacheram
	PORT(wren : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 rdaddress : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 wraddress : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
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

COMPONENT mux2_12
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cmp8a
	PORT(dataa : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 aeb : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	DFF_inst6 :  STD_LOGIC;


BEGIN 
SYNTHESIZED_WIRE_9 <= '1';



b2v_inst : readcacheram
PORT MAP(wren => wren,
		 clock => clock,
		 data => data,
		 rdaddress => rdaddress,
		 wraddress => wraddress,
		 q => SYNTHESIZED_WIRE_2);


b2v_inst1 : ldreg
GENERIC MAP(default_value => 0,
			size => 8
			)
PORT MAP(clk => clock,
		 ld => SYNTHESIZED_WIRE_9,
		 data_in => rdaddress,
		 data_out => SYNTHESIZED_WIRE_7);


b2v_inst15 : mux2_12
PORT MAP(sel => SYNTHESIZED_WIRE_1,
		 data0x => SYNTHESIZED_WIRE_2,
		 data1x => SYNTHESIZED_WIRE_3,
		 result => q);



b2v_inst4 : ldreg
GENERIC MAP(default_value => 0,
			size => 8
			)
PORT MAP(clk => clock,
		 ld => SYNTHESIZED_WIRE_9,
		 data_in => wraddress,
		 data_out => SYNTHESIZED_WIRE_6);


b2v_inst5 : ldreg
GENERIC MAP(default_value => 0,
			size => 12
			)
PORT MAP(clk => clock,
		 ld => SYNTHESIZED_WIRE_9,
		 data_in => data,
		 data_out => SYNTHESIZED_WIRE_3);


PROCESS(clock)
BEGIN
IF (RISING_EDGE(clock)) THEN
	DFF_inst6 <= wren;
END IF;
END PROCESS;


b2v_inst7 : cmp8a
PORT MAP(dataa => SYNTHESIZED_WIRE_6,
		 datab => SYNTHESIZED_WIRE_7,
		 aeb => SYNTHESIZED_WIRE_8);


SYNTHESIZED_WIRE_1 <= SYNTHESIZED_WIRE_8 AND DFF_inst6;


END bdf_type;