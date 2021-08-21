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
-- CREATED		"Sat Aug 21 13:39:21 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ControlUnitOpSwitch IS 
	PORT
	(
		lui :  IN  STD_LOGIC;
		auipc :  IN  STD_LOGIC;
		jal :  IN  STD_LOGIC;
		jalr :  IN  STD_LOGIC;
		branch :  IN  STD_LOGIC;
		load :  IN  STD_LOGIC;
		store :  IN  STD_LOGIC;
		ri :  IN  STD_LOGIC;
		fault :  IN  STD_LOGIC;
		BranchAddress :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ControlUnitOpSwitch;

ARCHITECTURE bdf_type OF ControlUnitOpSwitch IS 

SIGNAL	one :  STD_LOGIC;
SIGNAL	zero :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_8 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_5 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_6 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_7 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_4 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_8 <= (one & one & zero & zero);
GDFX_TEMP_SIGNAL_0 <= (zero & zero & one & one);
GDFX_TEMP_SIGNAL_5 <= (zero & one & one & one);
GDFX_TEMP_SIGNAL_6 <= (one & zero & zero & zero);
GDFX_TEMP_SIGNAL_7 <= (one & zero & one & zero);
GDFX_TEMP_SIGNAL_2 <= (one & one & one & zero);
GDFX_TEMP_SIGNAL_4 <= (zero & one & one & zero);
GDFX_TEMP_SIGNAL_3 <= (zero & one & zero & one);
GDFX_TEMP_SIGNAL_1 <= (zero & one & zero & zero);


PROCESS(GDFX_TEMP_SIGNAL_0,lui)
BEGIN
if (lui = '1') THEN
	BranchAddress(3) <= GDFX_TEMP_SIGNAL_0(3);
ELSE
	BranchAddress(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_0,lui)
BEGIN
if (lui = '1') THEN
	BranchAddress(2) <= GDFX_TEMP_SIGNAL_0(2);
ELSE
	BranchAddress(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_0,lui)
BEGIN
if (lui = '1') THEN
	BranchAddress(1) <= GDFX_TEMP_SIGNAL_0(1);
ELSE
	BranchAddress(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_0,lui)
BEGIN
if (lui = '1') THEN
	BranchAddress(0) <= GDFX_TEMP_SIGNAL_0(0);
ELSE
	BranchAddress(0) <= 'Z';
END IF;
END PROCESS;


PROCESS(GDFX_TEMP_SIGNAL_1,auipc)
BEGIN
if (auipc = '1') THEN
	BranchAddress(3) <= GDFX_TEMP_SIGNAL_1(3);
ELSE
	BranchAddress(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,auipc)
BEGIN
if (auipc = '1') THEN
	BranchAddress(2) <= GDFX_TEMP_SIGNAL_1(2);
ELSE
	BranchAddress(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,auipc)
BEGIN
if (auipc = '1') THEN
	BranchAddress(1) <= GDFX_TEMP_SIGNAL_1(1);
ELSE
	BranchAddress(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,auipc)
BEGIN
if (auipc = '1') THEN
	BranchAddress(0) <= GDFX_TEMP_SIGNAL_1(0);
ELSE
	BranchAddress(0) <= 'Z';
END IF;
END PROCESS;


PROCESS(GDFX_TEMP_SIGNAL_2,fault)
BEGIN
if (fault = '1') THEN
	BranchAddress(3) <= GDFX_TEMP_SIGNAL_2(3);
ELSE
	BranchAddress(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_2,fault)
BEGIN
if (fault = '1') THEN
	BranchAddress(2) <= GDFX_TEMP_SIGNAL_2(2);
ELSE
	BranchAddress(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_2,fault)
BEGIN
if (fault = '1') THEN
	BranchAddress(1) <= GDFX_TEMP_SIGNAL_2(1);
ELSE
	BranchAddress(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_2,fault)
BEGIN
if (fault = '1') THEN
	BranchAddress(0) <= GDFX_TEMP_SIGNAL_2(0);
ELSE
	BranchAddress(0) <= 'Z';
END IF;
END PROCESS;


PROCESS(GDFX_TEMP_SIGNAL_3,jal)
BEGIN
if (jal = '1') THEN
	BranchAddress(3) <= GDFX_TEMP_SIGNAL_3(3);
ELSE
	BranchAddress(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_3,jal)
BEGIN
if (jal = '1') THEN
	BranchAddress(2) <= GDFX_TEMP_SIGNAL_3(2);
ELSE
	BranchAddress(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_3,jal)
BEGIN
if (jal = '1') THEN
	BranchAddress(1) <= GDFX_TEMP_SIGNAL_3(1);
ELSE
	BranchAddress(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_3,jal)
BEGIN
if (jal = '1') THEN
	BranchAddress(0) <= GDFX_TEMP_SIGNAL_3(0);
ELSE
	BranchAddress(0) <= 'Z';
END IF;
END PROCESS;


PROCESS(GDFX_TEMP_SIGNAL_4,jalr)
BEGIN
if (jalr = '1') THEN
	BranchAddress(3) <= GDFX_TEMP_SIGNAL_4(3);
ELSE
	BranchAddress(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_4,jalr)
BEGIN
if (jalr = '1') THEN
	BranchAddress(2) <= GDFX_TEMP_SIGNAL_4(2);
ELSE
	BranchAddress(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_4,jalr)
BEGIN
if (jalr = '1') THEN
	BranchAddress(1) <= GDFX_TEMP_SIGNAL_4(1);
ELSE
	BranchAddress(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_4,jalr)
BEGIN
if (jalr = '1') THEN
	BranchAddress(0) <= GDFX_TEMP_SIGNAL_4(0);
ELSE
	BranchAddress(0) <= 'Z';
END IF;
END PROCESS;




PROCESS(GDFX_TEMP_SIGNAL_5,branch)
BEGIN
if (branch = '1') THEN
	BranchAddress(3) <= GDFX_TEMP_SIGNAL_5(3);
ELSE
	BranchAddress(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_5,branch)
BEGIN
if (branch = '1') THEN
	BranchAddress(2) <= GDFX_TEMP_SIGNAL_5(2);
ELSE
	BranchAddress(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_5,branch)
BEGIN
if (branch = '1') THEN
	BranchAddress(1) <= GDFX_TEMP_SIGNAL_5(1);
ELSE
	BranchAddress(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_5,branch)
BEGIN
if (branch = '1') THEN
	BranchAddress(0) <= GDFX_TEMP_SIGNAL_5(0);
ELSE
	BranchAddress(0) <= 'Z';
END IF;
END PROCESS;


PROCESS(GDFX_TEMP_SIGNAL_6,load)
BEGIN
if (load = '1') THEN
	BranchAddress(3) <= GDFX_TEMP_SIGNAL_6(3);
ELSE
	BranchAddress(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_6,load)
BEGIN
if (load = '1') THEN
	BranchAddress(2) <= GDFX_TEMP_SIGNAL_6(2);
ELSE
	BranchAddress(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_6,load)
BEGIN
if (load = '1') THEN
	BranchAddress(1) <= GDFX_TEMP_SIGNAL_6(1);
ELSE
	BranchAddress(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_6,load)
BEGIN
if (load = '1') THEN
	BranchAddress(0) <= GDFX_TEMP_SIGNAL_6(0);
ELSE
	BranchAddress(0) <= 'Z';
END IF;
END PROCESS;


PROCESS(GDFX_TEMP_SIGNAL_7,store)
BEGIN
if (store = '1') THEN
	BranchAddress(3) <= GDFX_TEMP_SIGNAL_7(3);
ELSE
	BranchAddress(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_7,store)
BEGIN
if (store = '1') THEN
	BranchAddress(2) <= GDFX_TEMP_SIGNAL_7(2);
ELSE
	BranchAddress(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_7,store)
BEGIN
if (store = '1') THEN
	BranchAddress(1) <= GDFX_TEMP_SIGNAL_7(1);
ELSE
	BranchAddress(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_7,store)
BEGIN
if (store = '1') THEN
	BranchAddress(0) <= GDFX_TEMP_SIGNAL_7(0);
ELSE
	BranchAddress(0) <= 'Z';
END IF;
END PROCESS;


PROCESS(GDFX_TEMP_SIGNAL_8,ri)
BEGIN
if (ri = '1') THEN
	BranchAddress(3) <= GDFX_TEMP_SIGNAL_8(3);
ELSE
	BranchAddress(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_8,ri)
BEGIN
if (ri = '1') THEN
	BranchAddress(2) <= GDFX_TEMP_SIGNAL_8(2);
ELSE
	BranchAddress(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_8,ri)
BEGIN
if (ri = '1') THEN
	BranchAddress(1) <= GDFX_TEMP_SIGNAL_8(1);
ELSE
	BranchAddress(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_8,ri)
BEGIN
if (ri = '1') THEN
	BranchAddress(0) <= GDFX_TEMP_SIGNAL_8(0);
ELSE
	BranchAddress(0) <= 'Z';
END IF;
END PROCESS;


one <= '1';
zero <= '0';
END bdf_type;