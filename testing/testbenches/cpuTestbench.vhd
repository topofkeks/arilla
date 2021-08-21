library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package Modules is

component ArillaTopLevel IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		BUTTON :  IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		SW :  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
		LED :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END component;

end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.modules.all;

entity cpuTestbench is
end cpuTestbench;

architecture cpuTestbench of cpuTestbench is

signal BUTTON : STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '1');
signal SW : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
signal LED : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
signal clk: std_logic;

constant clk_period : time := 10 ns;

begin

A:ArillaTopLevel port map(clk,BUTTON,SW,LED);

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

end cpuTestbench;