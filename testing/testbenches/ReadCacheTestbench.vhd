library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package Modules3 is

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

COMPONENT ReadCache IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		start :  IN  STD_LOGIC;
		msfc :  IN  STD_LOGIC;
		invalidate :  IN  STD_LOGIC;
		I :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		sX :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		sY :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		X :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		Y :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		RD :  OUT  STD_LOGIC;
		opCMPL :  OUT  STD_LOGIC;
		O :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0)
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

signal rst: STD_LOGIC := '1';
signal H_SYNC: STD_LOGIC := '0';
signal V_SYNC: STD_LOGIC := '0';
signal VIDEO_OUTPUT: STD_LOGIC := '0';
signal sx: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal sy: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal clk: std_logic := '0';
signal start: STD_LOGIC := '0';
signal msfc: STD_LOGIC := '0';
signal invalidate: STD_LOGIC := '0';
signal I: STD_LOGIC_VECTOR(11 DOWNTO 0) := (others => '0');
signal X: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal Y: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal RD: STD_LOGIC := '0';
signal opCMPL: STD_LOGIC := '0';
signal O: STD_LOGIC_VECTOR(11 DOWNTO 0) := (others => '0');

constant clk_period : time := 10 ns;

begin

RC:ReadCache port map(clk,start,msfc,invalidate,I,sx,sy,X,Y,RD,opCMPL,O);
SG:MAsterSyncGenerator port map(rst,clk,H_SYNC,V_SYNC,VIDEO_OUTPUT,sx,sy);

I<= sy(0 downto 0) & sx(10 downto 0);

process
begin
	  clk <= '0';
	  wait for clk_period/2; 
	  clk <= '1';
	  wait for clk_period/2;
end process;
end ReadCacheTestbench;