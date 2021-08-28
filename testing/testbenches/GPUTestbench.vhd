library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package Modules9 is

COMPONENT GPU IS 
	PORT
	(
		WR :  IN  STD_LOGIC;
		RD :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		rst :  IN  STD_LOGIC;
		ADDR :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		DATA :  INOUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		mX :  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
		mY :  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
		SDRAM_DQ :  INOUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		H_SYNC :  OUT  STD_LOGIC;
		V_SYNC :  OUT  STD_LOGIC;
		B :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		G :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		R :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		SDRAM_CTRL :  OUT  STD_LOGIC_VECTOR(22 DOWNTO 0)
	);
END COMPONENT;

end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.modules9.all;

entity GPUTestbench is
end GPUTestbench;

architecture GPUTestbench of GPUTestbench is

signal WR : STD_LOGIC := '0';
signal RD : STD_LOGIC := '0';
signal clk : STD_LOGIC := '0';
signal rst : STD_LOGIC := '1';
signal ADDR : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
signal DATA : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
signal mX : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
signal mY : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
signal SDRAM_DQ : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
signal H_SYNC : STD_LOGIC := '0';
signal V_SYNC : STD_LOGIC := '0';
signal B : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
signal G : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
signal R : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
signal SDRAM_CTRL : STD_LOGIC_VECTOR(22 DOWNTO 0) := (others => '0');

constant clk_period : time := 10 ns;

begin

GP:GPU port map(WR,RD,clk,rst,ADDR,DATA,mX,mY,SDRAM_DQ,H_SYNC,V_SYNC,B,G,R,SDRAM_CTRL);

process
begin
	  clk <= '0';
	  wait for clk_period/2; 
	  clk <= '1';
	  wait for clk_period/2;
end process;
end GPUTestbench;