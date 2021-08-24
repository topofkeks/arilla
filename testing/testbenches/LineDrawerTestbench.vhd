library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package Modules is

COMPONENT RectDrawer IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		FC :  IN  STD_LOGIC;
		start :  IN  STD_LOGIC;
		fill :  IN  STD_LOGIC;
		eX :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		eY :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		sX :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		sY :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		WR :  OUT  STD_LOGIC;
		opCMPL :  OUT  STD_LOGIC;
		eXout :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0);
		eYout :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0);
		sXout :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0);
		sYout :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT LineDrawer IS 
	PORT
	(
		start :  IN  STD_LOGIC;
		FC :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		eX :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		eY :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		sX :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		sY :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		WR :  OUT  STD_LOGIC;
		opCMPL :  OUT  STD_LOGIC;
		X :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0);
		Y :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.modules.all;

entity LineDrawerTestbench is
end LineDrawerTestbench;

architecture LineDrawerTestbench of LineDrawerTestbench is

signal start: STD_LOGIC :='0';
signal FC: STD_LOGIC :='0';
signal fill: STD_LOGIC :='0';
signal eX: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal eY: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal sX: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal sY: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal WR: STD_LOGIC :='0';
signal WRLD: STD_LOGIC :='0';
signal opCMPL: STD_LOGIC :='0';
signal opCMPLLD: STD_LOGIC :='0';
signal eXout: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal eYout: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal sXout: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal sYout: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal X: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal Y: STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
signal clk: std_logic;

constant clk_period : time := 10 ns;

begin

RD:RectDrawer port map(clk,opCMPLLD,start,fill,eX,eY,sX,sY,WR,opCMPL,eXout,eYout,sXout,sYout);
LD:LineDrawer port map(WR,FC,clk,eXout,eYout,sXout,sYout,WRLD,opCMPLLD,X,Y);

sX<="00000000111";
sY<="00000000101";
eX<="00000000011";
eY<="00000001000";


process
begin
	  clk <= '0';
	  wait for clk_period/2; 
	  clk <= '1';
	  wait for clk_period/2;
end process;

process(clk)
begin
	if (rising_edge(clk)) then
		FC<=WRLD;
	else
		FC<=FC;
	end if;
end process;

end LineDrawerTestbench;