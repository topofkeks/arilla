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
-- CREATED		"Sun Aug 29 18:03:23 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY RegFile IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		wr :  IN  STD_LOGIC;
		D :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		data :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		S1 :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		S2 :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		RS1 :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		RS2 :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END RegFile;

ARCHITECTURE bdf_type OF RegFile IS 

COMPONENT dc32
	PORT(enable : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 eq0 : OUT STD_LOGIC;
		 eq1 : OUT STD_LOGIC;
		 eq2 : OUT STD_LOGIC;
		 eq3 : OUT STD_LOGIC;
		 eq4 : OUT STD_LOGIC;
		 eq5 : OUT STD_LOGIC;
		 eq6 : OUT STD_LOGIC;
		 eq7 : OUT STD_LOGIC;
		 eq8 : OUT STD_LOGIC;
		 eq9 : OUT STD_LOGIC;
		 eq10 : OUT STD_LOGIC;
		 eq11 : OUT STD_LOGIC;
		 eq12 : OUT STD_LOGIC;
		 eq13 : OUT STD_LOGIC;
		 eq14 : OUT STD_LOGIC;
		 eq15 : OUT STD_LOGIC;
		 eq16 : OUT STD_LOGIC;
		 eq17 : OUT STD_LOGIC;
		 eq18 : OUT STD_LOGIC;
		 eq19 : OUT STD_LOGIC;
		 eq20 : OUT STD_LOGIC;
		 eq21 : OUT STD_LOGIC;
		 eq22 : OUT STD_LOGIC;
		 eq23 : OUT STD_LOGIC;
		 eq24 : OUT STD_LOGIC;
		 eq25 : OUT STD_LOGIC;
		 eq26 : OUT STD_LOGIC;
		 eq27 : OUT STD_LOGIC;
		 eq28 : OUT STD_LOGIC;
		 eq29 : OUT STD_LOGIC;
		 eq30 : OUT STD_LOGIC;
		 eq31 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT ldreg
GENERIC (default_value : INTEGER;
			size : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 ld : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux32_32
	PORT(data0x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data10x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data11x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data12x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data13x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data14x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data15x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data16x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data17x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data18x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data19x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data20x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data21x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data22x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data23x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data24x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data25x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data26x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data27x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data28x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data29x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data2x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data30x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data31x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data3x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data4x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data5x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data6x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data7x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data8x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data9x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT const
GENERIC (const : INTEGER;
			size : INTEGER
			);
	PORT(		 data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	ldR1 :  STD_LOGIC;
SIGNAL	ldR10 :  STD_LOGIC;
SIGNAL	ldR11 :  STD_LOGIC;
SIGNAL	ldR12 :  STD_LOGIC;
SIGNAL	ldR13 :  STD_LOGIC;
SIGNAL	ldR14 :  STD_LOGIC;
SIGNAL	ldR15 :  STD_LOGIC;
SIGNAL	ldR16 :  STD_LOGIC;
SIGNAL	ldR17 :  STD_LOGIC;
SIGNAL	ldR18 :  STD_LOGIC;
SIGNAL	ldR19 :  STD_LOGIC;
SIGNAL	ldR2 :  STD_LOGIC;
SIGNAL	ldR20 :  STD_LOGIC;
SIGNAL	ldR21 :  STD_LOGIC;
SIGNAL	ldR22 :  STD_LOGIC;
SIGNAL	ldR23 :  STD_LOGIC;
SIGNAL	ldR24 :  STD_LOGIC;
SIGNAL	ldR25 :  STD_LOGIC;
SIGNAL	ldR26 :  STD_LOGIC;
SIGNAL	ldR27 :  STD_LOGIC;
SIGNAL	ldR28 :  STD_LOGIC;
SIGNAL	ldR29 :  STD_LOGIC;
SIGNAL	ldR3 :  STD_LOGIC;
SIGNAL	ldR30 :  STD_LOGIC;
SIGNAL	ldR31 :  STD_LOGIC;
SIGNAL	ldR4 :  STD_LOGIC;
SIGNAL	ldR5 :  STD_LOGIC;
SIGNAL	ldR6 :  STD_LOGIC;
SIGNAL	ldR7 :  STD_LOGIC;
SIGNAL	ldR8 :  STD_LOGIC;
SIGNAL	ldR9 :  STD_LOGIC;
SIGNAL	R0out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R10out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R11out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R12out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R13out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R14out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R15out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R16out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R17out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R18out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R19out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R1out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R20out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R21out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R22out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R23out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R24out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R25out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R26out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R27out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R28out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R29out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R2out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R30out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R31out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R3out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R4out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R5out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R6out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R7out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R8out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	R9out :  STD_LOGIC_VECTOR(31 DOWNTO 0);


BEGIN 



b2v_inst : dc32
PORT MAP(enable => wr,
		 data => D,
		 eq1 => ldR1,
		 eq2 => ldR2,
		 eq3 => ldR3,
		 eq4 => ldR4,
		 eq5 => ldR5,
		 eq6 => ldR6,
		 eq7 => ldR7,
		 eq8 => ldR8,
		 eq9 => ldR9,
		 eq10 => ldR10,
		 eq11 => ldR11,
		 eq12 => ldR12,
		 eq13 => ldR13,
		 eq14 => ldR14,
		 eq15 => ldR15,
		 eq16 => ldR16,
		 eq17 => ldR17,
		 eq18 => ldR18,
		 eq19 => ldR19,
		 eq20 => ldR20,
		 eq21 => ldR21,
		 eq22 => ldR22,
		 eq23 => ldR23,
		 eq24 => ldR24,
		 eq25 => ldR25,
		 eq26 => ldR26,
		 eq27 => ldR27,
		 eq28 => ldR28,
		 eq29 => ldR29,
		 eq30 => ldR30,
		 eq31 => ldR31);


b2v_inst10 : ldreg
GENERIC MAP(default_value => 8180,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR2,
		 data_in => data,
		 data_out => R2out);


b2v_inst11 : ldreg
GENERIC MAP(default_value => 12848,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR3,
		 data_in => data,
		 data_out => R3out);


b2v_inst12 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR4,
		 data_in => data,
		 data_out => R4out);


b2v_inst13 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR5,
		 data_in => data,
		 data_out => R5out);


b2v_inst14 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR6,
		 data_in => data,
		 data_out => R6out);


b2v_inst15 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR7,
		 data_in => data,
		 data_out => R7out);


b2v_inst16 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR8,
		 data_in => data,
		 data_out => R8out);


b2v_inst17 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR9,
		 data_in => data,
		 data_out => R9out);


b2v_inst18 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR10,
		 data_in => data,
		 data_out => R10out);


b2v_inst19 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR11,
		 data_in => data,
		 data_out => R11out);


b2v_inst20 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR12,
		 data_in => data,
		 data_out => R12out);


b2v_inst21 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR13,
		 data_in => data,
		 data_out => R13out);


b2v_inst22 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR14,
		 data_in => data,
		 data_out => R14out);


b2v_inst23 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR15,
		 data_in => data,
		 data_out => R15out);


b2v_inst24 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR16,
		 data_in => data,
		 data_out => R16out);


b2v_inst25 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR17,
		 data_in => data,
		 data_out => R17out);


b2v_inst26 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR18,
		 data_in => data,
		 data_out => R18out);


b2v_inst27 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR19,
		 data_in => data,
		 data_out => R19out);


b2v_inst28 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR20,
		 data_in => data,
		 data_out => R20out);


b2v_inst29 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR21,
		 data_in => data,
		 data_out => R21out);


b2v_inst30 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR22,
		 data_in => data,
		 data_out => R22out);


b2v_inst31 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR23,
		 data_in => data,
		 data_out => R23out);


b2v_inst32 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR24,
		 data_in => data,
		 data_out => R24out);


b2v_inst33 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR25,
		 data_in => data,
		 data_out => R25out);


b2v_inst34 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR26,
		 data_in => data,
		 data_out => R26out);


b2v_inst35 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR27,
		 data_in => data,
		 data_out => R27out);


b2v_inst36 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR28,
		 data_in => data,
		 data_out => R28out);


b2v_inst37 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR29,
		 data_in => data,
		 data_out => R29out);


b2v_inst38 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR30,
		 data_in => data,
		 data_out => R30out);


b2v_inst39 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR31,
		 data_in => data,
		 data_out => R31out);


b2v_inst5 : mux32_32
PORT MAP(data0x => R0out,
		 data10x => R10out,
		 data11x => R11out,
		 data12x => R12out,
		 data13x => R13out,
		 data14x => R14out,
		 data15x => R15out,
		 data16x => R16out,
		 data17x => R17out,
		 data18x => R18out,
		 data19x => R19out,
		 data1x => R1out,
		 data20x => R20out,
		 data21x => R21out,
		 data22x => R22out,
		 data23x => R23out,
		 data24x => R24out,
		 data25x => R25out,
		 data26x => R26out,
		 data27x => R27out,
		 data28x => R28out,
		 data29x => R29out,
		 data2x => R2out,
		 data30x => R30out,
		 data31x => R31out,
		 data3x => R3out,
		 data4x => R4out,
		 data5x => R5out,
		 data6x => R6out,
		 data7x => R7out,
		 data8x => R8out,
		 data9x => R9out,
		 sel => S1,
		 result => RS1);


b2v_inst7 : mux32_32
PORT MAP(data0x => R0out,
		 data10x => R10out,
		 data11x => R11out,
		 data12x => R12out,
		 data13x => R13out,
		 data14x => R14out,
		 data15x => R15out,
		 data16x => R16out,
		 data17x => R17out,
		 data18x => R18out,
		 data19x => R19out,
		 data1x => R1out,
		 data20x => R20out,
		 data21x => R21out,
		 data22x => R22out,
		 data23x => R23out,
		 data24x => R24out,
		 data25x => R25out,
		 data26x => R26out,
		 data27x => R27out,
		 data28x => R28out,
		 data29x => R29out,
		 data2x => R2out,
		 data30x => R30out,
		 data31x => R31out,
		 data3x => R3out,
		 data4x => R4out,
		 data5x => R5out,
		 data6x => R6out,
		 data7x => R7out,
		 data8x => R8out,
		 data9x => R9out,
		 sel => S2,
		 result => RS2);


b2v_inst8 : ldreg
GENERIC MAP(default_value => 0,
			size => 32
			)
PORT MAP(clk => clk,
		 ld => ldR1,
		 data_in => data,
		 data_out => R1out);


b2v_inst9 : const
GENERIC MAP(const => 0,
			size => 32
			)
PORT MAP(		 data => R0out);


END bdf_type;