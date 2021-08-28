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
-- CREATED		"Sat Aug 28 12:42:59 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY VACommandGenerator IS 
	PORT
	(
		VA_ACT :  IN  STD_LOGIC;
		VA_READ :  IN  STD_LOGIC;
		VA_PRE :  IN  STD_LOGIC;
		va_ADDR :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0);
		va_Command :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END VACommandGenerator;

ARCHITECTURE bdf_type OF VACommandGenerator IS 

SIGNAL	one :  STD_LOGIC;
SIGNAL	zero :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_5 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_4 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_7 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_6 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_2 <= (one & one & one);
GDFX_TEMP_SIGNAL_3 <= (one & zero & one);
GDFX_TEMP_SIGNAL_5 <= (zero & one & one);
GDFX_TEMP_SIGNAL_4 <= (zero & one & zero);
GDFX_TEMP_SIGNAL_7 <= (zero & one & zero);
GDFX_TEMP_SIGNAL_6 <= (zero & zero & one);
GDFX_TEMP_SIGNAL_0 <= (zero & zero & zero);
GDFX_TEMP_SIGNAL_1 <= (zero & zero & zero);


PROCESS(GDFX_TEMP_SIGNAL_0,SYNTHESIZED_WIRE_2)
BEGIN
if (SYNTHESIZED_WIRE_2 = '1') THEN
	va_ADDR(2) <= GDFX_TEMP_SIGNAL_0(2);
ELSE
	va_ADDR(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_0,SYNTHESIZED_WIRE_2)
BEGIN
if (SYNTHESIZED_WIRE_2 = '1') THEN
	va_ADDR(1) <= GDFX_TEMP_SIGNAL_0(1);
ELSE
	va_ADDR(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_0,SYNTHESIZED_WIRE_2)
BEGIN
if (SYNTHESIZED_WIRE_2 = '1') THEN
	va_ADDR(0) <= GDFX_TEMP_SIGNAL_0(0);
ELSE
	va_ADDR(0) <= 'Z';
END IF;
END PROCESS;


PROCESS(GDFX_TEMP_SIGNAL_1,SYNTHESIZED_WIRE_2)
BEGIN
if (SYNTHESIZED_WIRE_2 = '1') THEN
	va_Command(2) <= GDFX_TEMP_SIGNAL_1(2);
ELSE
	va_Command(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,SYNTHESIZED_WIRE_2)
BEGIN
if (SYNTHESIZED_WIRE_2 = '1') THEN
	va_Command(1) <= GDFX_TEMP_SIGNAL_1(1);
ELSE
	va_Command(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_1,SYNTHESIZED_WIRE_2)
BEGIN
if (SYNTHESIZED_WIRE_2 = '1') THEN
	va_Command(0) <= GDFX_TEMP_SIGNAL_1(0);
ELSE
	va_Command(0) <= 'Z';
END IF;
END PROCESS;




SYNTHESIZED_WIRE_2 <= NOT(VA_ACT OR VA_READ OR VA_PRE);


PROCESS(GDFX_TEMP_SIGNAL_2,VA_PRE)
BEGIN
if (VA_PRE = '1') THEN
	va_ADDR(2) <= GDFX_TEMP_SIGNAL_2(2);
ELSE
	va_ADDR(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_2,VA_PRE)
BEGIN
if (VA_PRE = '1') THEN
	va_ADDR(1) <= GDFX_TEMP_SIGNAL_2(1);
ELSE
	va_ADDR(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_2,VA_PRE)
BEGIN
if (VA_PRE = '1') THEN
	va_ADDR(0) <= GDFX_TEMP_SIGNAL_2(0);
ELSE
	va_ADDR(0) <= 'Z';
END IF;
END PROCESS;


PROCESS(GDFX_TEMP_SIGNAL_3,VA_PRE)
BEGIN
if (VA_PRE = '1') THEN
	va_Command(2) <= GDFX_TEMP_SIGNAL_3(2);
ELSE
	va_Command(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_3,VA_PRE)
BEGIN
if (VA_PRE = '1') THEN
	va_Command(1) <= GDFX_TEMP_SIGNAL_3(1);
ELSE
	va_Command(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_3,VA_PRE)
BEGIN
if (VA_PRE = '1') THEN
	va_Command(0) <= GDFX_TEMP_SIGNAL_3(0);
ELSE
	va_Command(0) <= 'Z';
END IF;
END PROCESS;


PROCESS(GDFX_TEMP_SIGNAL_4,VA_READ)
BEGIN
if (VA_READ = '1') THEN
	va_ADDR(2) <= GDFX_TEMP_SIGNAL_4(2);
ELSE
	va_ADDR(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_4,VA_READ)
BEGIN
if (VA_READ = '1') THEN
	va_ADDR(1) <= GDFX_TEMP_SIGNAL_4(1);
ELSE
	va_ADDR(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_4,VA_READ)
BEGIN
if (VA_READ = '1') THEN
	va_ADDR(0) <= GDFX_TEMP_SIGNAL_4(0);
ELSE
	va_ADDR(0) <= 'Z';
END IF;
END PROCESS;


PROCESS(GDFX_TEMP_SIGNAL_5,VA_READ)
BEGIN
if (VA_READ = '1') THEN
	va_Command(2) <= GDFX_TEMP_SIGNAL_5(2);
ELSE
	va_Command(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_5,VA_READ)
BEGIN
if (VA_READ = '1') THEN
	va_Command(1) <= GDFX_TEMP_SIGNAL_5(1);
ELSE
	va_Command(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_5,VA_READ)
BEGIN
if (VA_READ = '1') THEN
	va_Command(0) <= GDFX_TEMP_SIGNAL_5(0);
ELSE
	va_Command(0) <= 'Z';
END IF;
END PROCESS;


PROCESS(GDFX_TEMP_SIGNAL_6,VA_ACT)
BEGIN
if (VA_ACT = '1') THEN
	va_ADDR(2) <= GDFX_TEMP_SIGNAL_6(2);
ELSE
	va_ADDR(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_6,VA_ACT)
BEGIN
if (VA_ACT = '1') THEN
	va_ADDR(1) <= GDFX_TEMP_SIGNAL_6(1);
ELSE
	va_ADDR(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_6,VA_ACT)
BEGIN
if (VA_ACT = '1') THEN
	va_ADDR(0) <= GDFX_TEMP_SIGNAL_6(0);
ELSE
	va_ADDR(0) <= 'Z';
END IF;
END PROCESS;


PROCESS(GDFX_TEMP_SIGNAL_7,VA_ACT)
BEGIN
if (VA_ACT = '1') THEN
	va_Command(2) <= GDFX_TEMP_SIGNAL_7(2);
ELSE
	va_Command(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_7,VA_ACT)
BEGIN
if (VA_ACT = '1') THEN
	va_Command(1) <= GDFX_TEMP_SIGNAL_7(1);
ELSE
	va_Command(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(GDFX_TEMP_SIGNAL_7,VA_ACT)
BEGIN
if (VA_ACT = '1') THEN
	va_Command(0) <= GDFX_TEMP_SIGNAL_7(0);
ELSE
	va_Command(0) <= 'Z';
END IF;
END PROCESS;


one <= '1';
zero <= '0';
END bdf_type;