library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package Modules4 is

COMPONENT MasterSyncGenerator IS 
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
END COMPONENT;

end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.modules4.all;

entity SyncGenTestbench is
end SyncGenTestbench;

architecture SyncGenTestbench of SyncGenTestbench is

signal rst: STD_LOGIC := '0';
signal H_SYNC: STD_LOGIC := '0';
signal V_SYNC: STD_LOGIC := '0';
signal VIDEO_OUTPUT: STD_LOGIC := '0';
signal x: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal y: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal clk: std_logic;

constant clk_period : time := 10 ns;

begin

SG:MAsterSyncGenerator port map(rst,clk,H_SYNC,V_SYNC,VIDEO_OUTPUT,x,y);

process
begin
	  clk <= '0';
	  wait for clk_period/2; 
	  clk <= '1';
	  wait for clk_period/2;
end process;
end SyncGenTestbench;