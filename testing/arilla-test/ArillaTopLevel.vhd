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
-- CREATED		"Sat Aug 21 01:59:42 2021"

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
		HEX0_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX1_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX2_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX3_D :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		LED :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		SDRAM_ADDR :  OUT  STD_LOGIC_VECTOR(12 DOWNTO 0);
		SDRAM_BA :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END ArillaTopLevel;

ARCHITECTURE bdf_type OF ArillaTopLevel IS 

COMPONENT arillacore
	PORT(FPGA_CLK : IN STD_LOGIC;
		 BUTTON : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 MemoryDataOut : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 MemoryWrite : OUT STD_LOGIC;
		 MemoryRead : OUT STD_LOGIC;
		 HEX0_D : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 HEX1_D : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 HEX2_D : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 HEX3_D : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 LED : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 MemoryAddress : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 MemoryByteEnable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 MemoryDataIn : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sram32_arilla
	PORT(wren : IN STD_LOGIC;
		 rden : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
		 byteena : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
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

SIGNAL	CPUAddress :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	one :  STD_LOGIC;
SIGNAL	sram_addr :  STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL	zero :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(31 DOWNTO 0);


BEGIN 



b2v_inst : arillacore
PORT MAP(FPGA_CLK => clk,
		 BUTTON => BUTTON,
		 MemoryDataOut => SYNTHESIZED_WIRE_0,
		 SW => SW,
		 MemoryWrite => SYNTHESIZED_WIRE_1,
		 MemoryRead => SYNTHESIZED_WIRE_2,
		 HEX0_D => HEX0_D,
		 HEX1_D => HEX1_D,
		 HEX2_D => HEX2_D,
		 HEX3_D => HEX3_D,
		 LED => LED,
		 MemoryAddress => CPUAddress,
		 MemoryByteEnable => SYNTHESIZED_WIRE_3,
		 MemoryDataIn => SYNTHESIZED_WIRE_4);

sram_addr <= CPUAddress(14 DOWNTO 2);





b2v_inst7 : sram32_arilla
PORT MAP(wren => SYNTHESIZED_WIRE_1,
		 rden => SYNTHESIZED_WIRE_2,
		 clock => clk,
		 address => sram_addr,
		 byteena => SYNTHESIZED_WIRE_3,
		 data => SYNTHESIZED_WIRE_4,
		 q => SYNTHESIZED_WIRE_0);


b2v_inst8 : controller
PORT MAP(CLK => clk,
		 PS2_DATA => PS2_DATA,
		 PS2_CLK => PS2_CLK);


one <= '1';
zero <= '0';
END bdf_type;