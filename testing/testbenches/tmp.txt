library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package Modules9 is

COMPONENT MemorySequencer IS 
	PORT
	(
		WR :  IN  STD_LOGIC;
		RD :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		rst :  IN  STD_LOGIC;
		color :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		opX :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		opY :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		SDRAM_DQ :  INOUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		syncX :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		syncY :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		FC :  OUT  STD_LOGIC;
		O :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		SDRAM_CTRL :  OUT  STD_LOGIC_VECTOR(22 DOWNTO 0)
	);
END COMPONENT;

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
use work.modules9.all;

entity GPUTestbench is
end GPUTestbench;

architecture GPUTestbench of GPUTestbench is

signal WR : STD_LOGIC :='0';
signal RD : STD_LOGIC :='0';
signal startRC : STD_LOGIC :='0';
signal startLD : STD_LOGIC :='0';
signal opCMPLRC : STD_LOGIC :='0';
signal opCMPLLD : STD_LOGIC :='0';
signal rst : STD_LOGIC :='1';
signal FC : STD_LOGIC :='0';
signal color : STD_LOGIC_VECTOR(11 DOWNTO 0) := (others =>'0');
signal opX : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others =>'0');
signal opY : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others =>'0');
signal syncX : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others =>'0');
signal syncY : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others =>'0');
signal sX : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others =>'0');
signal sY : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others =>'0');
signal eX : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others =>'0');
signal eY : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others =>'0');
signal X : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others =>'0');
signal Y : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others =>'0');
signal cacheType : STD_LOGIC_VECTOR(10 downto 0) := (others =>'0');
signal O : STD_LOGIC_VECTOR(11 DOWNTO 0) := (others =>'0');
signal RCO : STD_LOGIC_VECTOR(11 DOWNTO 0) := (others =>'0');
signal SDRAM_DQ : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others =>'0');
signal SDRAM_CTRL : STD_LOGIC_VECTOR(22 DOWNTO 0) := (others =>'0');
signal H_SYNC : STD_LOGIC :='0';
signal V_SYNC : STD_LOGIC :='0';
signal VIDEO_OUTPUT : STD_LOGIC :='0';
signal clk : STD_LOGIC :='0';

constant clk_period : time := 10 ns;

begin

MS:MemorySequencer port map(WR,RD,clk,rst,color,opX,opY,SDRAM_DQ,syncX,syncY,FC,O,SDRAM_CTRL);
GS:MasterSyncGenerator port map(rst,clk,H_SYNC,V_SYNC,VIDEO_OUTPUT,syncX,syncY);
RC:ReadCache port map(clk,startRC,FC,startLD,O,syncX,syncY,sX,sY,RD,opCMPLRC,RCO);
LD:LineDrawer port map(startLD,FC,clk,eX,eY,sX,sY,WR,opCMPLLD,X,Y);

opX <= (sX AND cacheType) OR (X AND NOT cacheType);
opY <= (sY AND cacheType) OR (Y AND NOT cacheType);

process
begin
	  clk <= '0';
	  wait for clk_period/2; 
	  clk <= '1';
	  wait for clk_period/2;
end process;
end GPUTestbench;