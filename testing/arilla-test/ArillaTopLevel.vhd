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
-- CREATED		"Mon Aug 30 20:14:15 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ArillaTopLevel IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		PS2_DATA :  INOUT  STD_LOGIC;
		PS2_CLK :  INOUT  STD_LOGIC;
		BUTTON :  IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		SDRAM_DQ :  INOUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		SW :  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
		SDRAM_RAS_N :  OUT  STD_LOGIC;
		SDRAM_CAS_N :  OUT  STD_LOGIC;
		SDRAM_LDQM :  OUT  STD_LOGIC;
		SDRAM_UDQM :  OUT  STD_LOGIC;
		SDRAM_CKE :  OUT  STD_LOGIC;
		SDRAM_CLK :  OUT  STD_LOGIC;
		SDRAM_WE_N :  OUT  STD_LOGIC;
		SDRAM_CS_N :  OUT  STD_LOGIC;
		VGA_HSYNC :  OUT  STD_LOGIC;
		VGA_VSYNC :  OUT  STD_LOGIC;
		HEX0_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX1_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX2_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX3_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		LED :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		SDRAM_ADDR :  OUT  STD_LOGIC_VECTOR(12 DOWNTO 0);
		SDRAM_BA :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		VGA_B :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		VGA_G :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		VGA_R :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ArillaTopLevel;

ARCHITECTURE bdf_type OF ArillaTopLevel IS 

COMPONENT arillacore
	PORT(FPGA_CLK : IN STD_LOGIC;
		 BUTTON : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 DATA : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 WR : OUT STD_LOGIC;
		 RD : OUT STD_LOGIC;
		 ADDR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 LED : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 MemoryByteEnable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT gpu
	PORT(WR : IN STD_LOGIC;
		 RD : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 ADDR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 DATA : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 mX : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 mY : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 SDRAM_DQ : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 H_SYNC : OUT STD_LOGIC;
		 V_SYNC : OUT STD_LOGIC;
		 B : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 G : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 R : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 SDRAM_CTRL : OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
	);
END COMPONENT;

COMPONENT const
GENERIC (const : INTEGER;
			size : INTEGER
			);
	PORT(		 data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sevensegmentinterface4
	PORT(input : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 HEX0 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 HEX1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 HEX2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 HEX3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
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

COMPONENT sramadapter
	PORT(RD : IN STD_LOGIC;
		 WR : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 ADDR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ByteEnable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 DATA : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cmp13
	PORT(dataa : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
		 aneb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT addsubs_16
	PORT(add_sub : IN STD_LOGIC;
		 dataa : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
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
		 data_in : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(12 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	ByteEnable :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	gdfx_temp0 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	MouseX :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	MouseY :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	one :  STD_LOGIC;
SIGNAL	PC :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	rst :  STD_LOGIC;
SIGNAL	zero :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC_VECTOR(22 DOWNTO 0);

SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(12 DOWNTO 0);

BEGIN 
SDRAM_RAS_N <= SYNTHESIZED_WIRE_24(7);
SDRAM_CAS_N <= SYNTHESIZED_WIRE_24(6);
SDRAM_LDQM <= SYNTHESIZED_WIRE_24(5);
SDRAM_UDQM <= SYNTHESIZED_WIRE_24(4);
SDRAM_CKE <= SYNTHESIZED_WIRE_24(3);
SDRAM_CLK <= SYNTHESIZED_WIRE_24(2);
SDRAM_WE_N <= SYNTHESIZED_WIRE_24(1);
SDRAM_CS_N <= SYNTHESIZED_WIRE_24(0);
SDRAM_ADDR(12 DOWNTO 0) <= SYNTHESIZED_WIRE_24(22 DOWNTO 10);
SDRAM_BA(1 DOWNTO 0) <= SYNTHESIZED_WIRE_24(9 DOWNTO 8);

GDFX_TEMP_SIGNAL_0 <= (zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero & zero);


b2v_inst : arillacore
PORT MAP(FPGA_CLK => clk,
		 BUTTON => BUTTON,
		 DATA => gdfx_temp0,
		 SW => SW,
		 WR => SYNTHESIZED_WIRE_21,
		 RD => SYNTHESIZED_WIRE_22,
		 ADDR => SYNTHESIZED_WIRE_23,
		 LED => LED,
		 MemoryByteEnable => ByteEnable,
		 PC => PC);


b2v_inst1 : gpu
PORT MAP(WR => SYNTHESIZED_WIRE_21,
		 RD => SYNTHESIZED_WIRE_22,
		 clk => clk,
		 rst => rst,
		 ADDR => SYNTHESIZED_WIRE_23,
		 DATA => gdfx_temp0,
		 mX => MouseX,
		 mY => MouseY,
		 SDRAM_DQ => SDRAM_DQ,
		 H_SYNC => VGA_HSYNC,
		 V_SYNC => VGA_VSYNC,
		 B => VGA_B,
		 G => VGA_G,
		 R => VGA_R,
		 SDRAM_CTRL => SYNTHESIZED_WIRE_24);


b2v_inst10 : const
GENERIC MAP(const => 148,
			size => 16
			)
PORT MAP(		 data => SYNTHESIZED_WIRE_11);


b2v_inst2 : sevensegmentinterface4
PORT MAP(input => SYNTHESIZED_WIRE_3,
		 HEX0 => HEX0_D,
		 HEX1 => HEX1_D,
		 HEX2 => HEX2_D,
		 HEX3 => HEX3_D);


b2v_inst3 : controller
PORT MAP(CLK => clk,
		 RD => SYNTHESIZED_WIRE_22,
		 WR => SYNTHESIZED_WIRE_21,
		 PS2_DATA => PS2_DATA,
		 PS2_CLK => PS2_CLK,
		 ADDR => SYNTHESIZED_WIRE_23,
		 DATA => gdfx_temp0,
		 MouseX => MouseX,
		 MouseY => MouseY);




b2v_inst6 : sramadapter
PORT MAP(RD => SYNTHESIZED_WIRE_22,
		 WR => SYNTHESIZED_WIRE_21,
		 clk => clk,
		 ADDR => SYNTHESIZED_WIRE_23,
		 ByteEnable => ByteEnable,
		 DATA => gdfx_temp0);


b2v_inst8 : cmp13
PORT MAP(dataa => SYNTHESIZED_WIRE_10,
		 aneb => rst);


b2v_inst9 : addsubs_16
PORT MAP(add_sub => one,
		 dataa => PC(15 DOWNTO 0),
		 datab => SYNTHESIZED_WIRE_11,
		 result => SYNTHESIZED_WIRE_3);


b2v_Timer : idreg
GENERIC MAP(default_value => 5050,
			size => 13
			)
PORT MAP(clk => clk,
		 inc => zero,
		 dec => rst,
		 ld => zero,
		 data_in => GDFX_TEMP_SIGNAL_0,
		 data_out => SYNTHESIZED_WIRE_10);


one <= '1';
zero <= '0';
END bdf_type;