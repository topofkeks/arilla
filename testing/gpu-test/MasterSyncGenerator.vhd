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
-- CREATED		"Sat Aug 28 12:38:58 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY MasterSyncGenerator IS 
	PORT
	(
		rst :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		H_SYNC :  OUT  STD_LOGIC;
		V_SYNC :  OUT  STD_LOGIC;
		VIDEO_OUTPUT :  OUT  STD_LOGIC;
		x :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0);
		y :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END MasterSyncGenerator;

ARCHITECTURE bdf_type OF MasterSyncGenerator IS 

COMPONENT cmp_vga_vsync_begin
	PORT(dataa : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 ageb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT cmp_vga_horizontal
	PORT(dataa : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 agb : OUT STD_LOGIC;
		 aleb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT cmp_vga_endline
	PORT(dataa : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 aeb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT vga_cmp_hsync_begin
	PORT(dataa : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 ageb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT vga_cmp_hsync_end
	PORT(dataa : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 alb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT const
GENERIC (const : INTEGER;
			size : INTEGER
			);
	PORT(		 data : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cmp_vga_vsync_end
	PORT(dataa : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 alb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT cmp_vga_endframe
	PORT(dataa : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 aeb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT cmp_vga_vertical
	PORT(dataa : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 ageb : OUT STD_LOGIC;
		 alb : OUT STD_LOGIC
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
		 data_in : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	gnd :  STD_LOGIC;
SIGNAL	h_end :  STD_LOGIC;
SIGNAL	h_visible :  STD_LOGIC;
SIGNAL	v_end :  STD_LOGIC;
SIGNAL	v_visible :  STD_LOGIC;
SIGNAL	vcc :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_17 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_18 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC;


BEGIN 
x <= SYNTHESIZED_WIRE_17;
y <= SYNTHESIZED_WIRE_16;



b2v_inst : cmp_vga_vsync_begin
PORT MAP(dataa => SYNTHESIZED_WIRE_16,
		 ageb => SYNTHESIZED_WIRE_8);


SYNTHESIZED_WIRE_12 <= h_end OR rst;


H_SYNC <= SYNTHESIZED_WIRE_1 AND SYNTHESIZED_WIRE_2;


b2v_inst15 : cmp_vga_horizontal
PORT MAP(dataa => SYNTHESIZED_WIRE_17,
		 aleb => h_visible);


b2v_inst16 : cmp_vga_endline
PORT MAP(dataa => SYNTHESIZED_WIRE_17,
		 aeb => h_end);


VIDEO_OUTPUT <= h_visible AND v_visible;


b2v_inst18 : vga_cmp_hsync_begin
PORT MAP(dataa => SYNTHESIZED_WIRE_17,
		 ageb => SYNTHESIZED_WIRE_1);


b2v_inst19 : vga_cmp_hsync_end
PORT MAP(dataa => SYNTHESIZED_WIRE_17,
		 alb => SYNTHESIZED_WIRE_2);


b2v_inst2 : const
GENERIC MAP(const => 600,
			size => 11
			)
PORT MAP(		 data => SYNTHESIZED_WIRE_18);


b2v_inst3 : cmp_vga_vsync_end
PORT MAP(dataa => SYNTHESIZED_WIRE_16,
		 alb => SYNTHESIZED_WIRE_9);


V_SYNC <= SYNTHESIZED_WIRE_8 AND SYNTHESIZED_WIRE_9;


b2v_inst5 : cmp_vga_endframe
PORT MAP(dataa => SYNTHESIZED_WIRE_16,
		 aeb => v_end);




SYNTHESIZED_WIRE_14 <= h_end AND v_end;


b2v_inst9 : cmp_vga_vertical
PORT MAP(dataa => SYNTHESIZED_WIRE_16,
		 alb => v_visible);


b2v_XCoord : idcreg
GENERIC MAP(clear_value => 0,
			default_value => 0,
			size => 11
			)
PORT MAP(clk => clk,
		 cl => SYNTHESIZED_WIRE_12,
		 inc => vcc,
		 dec => gnd,
		 ld => gnd,
		 data_in => SYNTHESIZED_WIRE_18,
		 data_out => SYNTHESIZED_WIRE_17);


b2v_YCoord : idcreg
GENERIC MAP(clear_value => 0,
			default_value => 0,
			size => 11
			)
PORT MAP(clk => clk,
		 cl => SYNTHESIZED_WIRE_14,
		 inc => h_end,
		 dec => gnd,
		 ld => rst,
		 data_in => SYNTHESIZED_WIRE_18,
		 data_out => SYNTHESIZED_WIRE_16);


gnd <= '0';
vcc <= '1';
END bdf_type;