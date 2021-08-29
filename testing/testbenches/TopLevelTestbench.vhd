library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package Modules8 is

COMPONENT ArillaTopLevel IS 
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
END COMPONENT;

end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.modules8.all;

entity TopLevelTestbench is
end TopLevelTestbench;

architecture TopLevelTestbench of TopLevelTestbench is

signal BUTTON : STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '1');
signal SW : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
signal LED : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
signal PS2_DATA : STD_LOGIC;
signal PS2_CLK : STD_LOGIC;
signal SDRAM_DQ : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
signal SDRAM_RAS_N : STD_LOGIC :='0';
signal SDRAM_CAS_N : STD_LOGIC :='0';
signal SDRAM_LDQM : STD_LOGIC:='0' ;
signal SDRAM_UDQM : STD_LOGIC :='0';
signal SDRAM_CKE : STD_LOGIC :='0';
signal SDRAM_CLK : STD_LOGIC :='0';
signal SDRAM_WE_N : STD_LOGIC :='0';
signal SDRAM_CS_N : STD_LOGIC :='0';
signal VGA_HSYNC : STD_LOGIC :='0';
signal HEX0_D : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
signal HEX1_D : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
signal HEX2_D : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
signal HEX3_D : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
signal SDRAM_ADDR : STD_LOGIC_VECTOR(12 DOWNTO 0) := (others => '0');
signal SDRAM_BA : STD_LOGIC_VECTOR(1 DOWNTO 0):= (others => '0') ;
signal VGA_B : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
signal VGA_G : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
signal VGA_R : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
signal clk: std_logic;

constant clk_period : time := 10 ns;

begin

A:ArillaTopLevel port map(clk,PS2_DATA,PS2_CLK,BUTTON,SDRAM_DQ,SW,SDRAM_RAS_N,SDRAM_CAS_N,SDRAM_LDQM,SDRAM_UDQM,SDRAM_CKE,SDRAM_CLK,SDRAM_WE_N,SDRAM_CS_N,VGA_HSYNC,HEX0_D,HEX1_D,HEX2_D,HEX3_D,LED,SDRAM_ADDR,SDRAM_BA,VGA_B,VGA_G,VGA_R);

process
begin
	  clk <= '0';
	  wait for clk_period/2; 
	  clk <= '1';
	  wait for clk_period/2;
end process;

process
begin
wait for 5 ns;
end process;

end TopLevelTestbench;