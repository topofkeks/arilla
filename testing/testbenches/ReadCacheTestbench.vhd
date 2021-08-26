library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package Modules3 is

COMPONENT ReadCacheRAM IS
	PORT
	(
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wraddress		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC  := '0';
		q		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ActualReadCacheRAM IS 
	PORT
	(
		wren :  IN  STD_LOGIC;
		clock :  IN  STD_LOGIC;
		data :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		rdaddress :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		wraddress :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		q :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.modules3.all;

entity ReadCacheTestbench is
end ReadCacheTestbench;

architecture ReadCacheTestbench of ReadCacheTestbench is

signal data: STD_LOGIC_VECTOR (11 DOWNTO 0) := (others => '0');
signal rdaddress: STD_LOGIC_VECTOR (7 DOWNTO 0) := (others => '0');
signal wraddress: STD_LOGIC_VECTOR (7 DOWNTO 0) := (others => '0');
signal wren: STD_LOGIC  := '0';
signal q: STD_LOGIC_VECTOR (11 DOWNTO 0) := (others => '0');
signal qq: STD_LOGIC_VECTOR (11 DOWNTO 0) := (others => '0');
signal clk: std_logic;

constant clk_period : time := 10 ns;

begin

RAM:ReadCacheRAM port map(clk,data,rdaddress,wraddress,wren,q);
ARAM:ActualReadCacheRAM port map(wren,clk,data,rdaddress,wraddress,qq);

process
begin
	  clk <= '0';
	  wait for clk_period/2; 
	  clk <= '1';
	  wait for clk_period/2;
end process;
end ReadCacheTestbench;