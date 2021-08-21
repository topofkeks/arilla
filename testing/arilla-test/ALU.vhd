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
-- CREATED		"Sat Aug 21 14:18:28 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ALU IS 
	PORT
	(
		A :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		B :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		op :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		aluzero :  OUT  STD_LOGIC;
		C :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ALU;

ARCHITECTURE bdf_type OF ALU IS 

COMPONENT mux16_32
	PORT(data0x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data10x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data11x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data12x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data13x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data14x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data15x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data2x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data3x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data4x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data5x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data6x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data7x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data8x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data9x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cmp32_zero
	PORT(dataa : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 aeb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT zeroext
GENERIC (in_width : INTEGER;
			out_width : INTEGER
			);
	PORT(I : IN STD_LOGIC_VECTOR(0 TO 0);
		 O : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cmp_32_alu
	PORT(dataa : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 aeb : OUT STD_LOGIC;
		 aneb : OUT STD_LOGIC;
		 ageb : OUT STD_LOGIC;
		 alb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT addsub_32
	PORT(add_sub : IN STD_LOGIC;
		 dataa : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT shift_32_l
	PORT(direction : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 distance : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT shiftr_32_a
	PORT(data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 distance : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cmp_32_alu_unsigned
	PORT(dataa : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ageb : OUT STD_LOGIC;
		 alb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mux16_1
	PORT(data15 : IN STD_LOGIC;
		 data14 : IN STD_LOGIC;
		 data13 : IN STD_LOGIC;
		 data12 : IN STD_LOGIC;
		 data11 : IN STD_LOGIC;
		 data10 : IN STD_LOGIC;
		 data9 : IN STD_LOGIC;
		 data8 : IN STD_LOGIC;
		 data7 : IN STD_LOGIC;
		 data6 : IN STD_LOGIC;
		 data5 : IN STD_LOGIC;
		 data4 : IN STD_LOGIC;
		 data3 : IN STD_LOGIC;
		 data2 : IN STD_LOGIC;
		 data1 : IN STD_LOGIC;
		 data0 : IN STD_LOGIC;
		 sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 result : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	C_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	one :  STD_LOGIC;
SIGNAL	zero :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_29 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_30 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_31 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_32 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_33 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_18 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC;


BEGIN 



b2v_inst : mux16_32
PORT MAP(data0x => SYNTHESIZED_WIRE_29,
		 data10x => A,
		 data11x => A,
		 data12x => A,
		 data13x => SYNTHESIZED_WIRE_1,
		 data14x => A,
		 data15x => A,
		 data1x => SYNTHESIZED_WIRE_30,
		 data2x => SYNTHESIZED_WIRE_3,
		 data3x => SYNTHESIZED_WIRE_4,
		 data4x => SYNTHESIZED_WIRE_5,
		 data5x => SYNTHESIZED_WIRE_30,
		 data6x => SYNTHESIZED_WIRE_7,
		 data7x => SYNTHESIZED_WIRE_8,
		 data8x => SYNTHESIZED_WIRE_29,
		 data9x => A,
		 sel => op,
		 result => C_ALTERA_SYNTHESIZED);


SYNTHESIZED_WIRE_12 <= NOT(op(3));



b2v_inst10 : cmp32_zero
PORT MAP(dataa => C_ALTERA_SYNTHESIZED,
		 aeb => SYNTHESIZED_WIRE_33);


SYNTHESIZED_WIRE_5 <= A XOR B;


SYNTHESIZED_WIRE_8 <= A AND B;


SYNTHESIZED_WIRE_7 <= B OR A;


b2v_inst15 : zeroext
GENERIC MAP(in_width => 1,
			out_width => 32
			)
PORT MAP(I(0) => SYNTHESIZED_WIRE_31,
		 O => SYNTHESIZED_WIRE_4);


b2v_inst16 : zeroext
GENERIC MAP(in_width => 1,
			out_width => 32
			)
PORT MAP(I(0) => SYNTHESIZED_WIRE_32,
		 O => SYNTHESIZED_WIRE_3);


b2v_inst18 : cmp_32_alu
PORT MAP(dataa => A,
		 datab => B,
		 aeb => SYNTHESIZED_WIRE_19,
		 aneb => SYNTHESIZED_WIRE_18,
		 ageb => SYNTHESIZED_WIRE_16,
		 alb => SYNTHESIZED_WIRE_32);


b2v_inst3 : addsub_32
PORT MAP(add_sub => SYNTHESIZED_WIRE_12,
		 dataa => A,
		 datab => B,
		 result => SYNTHESIZED_WIRE_29);


b2v_inst4 : shift_32_l
PORT MAP(direction => op(2),
		 data => A,
		 distance => B(4 DOWNTO 0),
		 result => SYNTHESIZED_WIRE_30);


b2v_inst5 : shiftr_32_a
PORT MAP(data => A,
		 distance => B(4 DOWNTO 0),
		 result => SYNTHESIZED_WIRE_1);



b2v_inst7 : cmp_32_alu_unsigned
PORT MAP(dataa => A,
		 datab => B,
		 ageb => SYNTHESIZED_WIRE_13,
		 alb => SYNTHESIZED_WIRE_31);



b2v_inst9 : mux16_1
PORT MAP(data15 => SYNTHESIZED_WIRE_13,
		 data14 => SYNTHESIZED_WIRE_31,
		 data13 => SYNTHESIZED_WIRE_33,
		 data12 => SYNTHESIZED_WIRE_16,
		 data11 => SYNTHESIZED_WIRE_32,
		 data10 => SYNTHESIZED_WIRE_18,
		 data9 => SYNTHESIZED_WIRE_19,
		 data8 => SYNTHESIZED_WIRE_33,
		 data7 => SYNTHESIZED_WIRE_33,
		 data6 => SYNTHESIZED_WIRE_33,
		 data5 => SYNTHESIZED_WIRE_33,
		 data4 => SYNTHESIZED_WIRE_33,
		 data3 => SYNTHESIZED_WIRE_33,
		 data2 => SYNTHESIZED_WIRE_33,
		 data1 => SYNTHESIZED_WIRE_33,
		 data0 => SYNTHESIZED_WIRE_33,
		 sel => op,
		 result => aluzero);

C <= C_ALTERA_SYNTHESIZED;

one <= '1';
zero <= '0';
END bdf_type;