library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package Modules is

component LDREG is

	generic
	(
		size : natural := 16;
		default_value: natural:=0
	);

	port 
	(
		data_in	: in  std_logic_vector(size-1 downto 0);
		ld	      : in  std_logic := '0';
		clk		: in  std_logic := '0';
		data_out	: out std_logic_vector(size-1 downto 0) :=std_logic_vector(to_unsigned( default_value, size))
	);

end component;

end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.modules.all;

entity testbench is
end testbench;

architecture testbench of testbench is

signal data_in: std_logic_vector(15 downto 0) := (others => '0');
signal ld: std_logic := '0';
signal data_out: std_logic_vector(15 downto 0);
signal clk: std_logic;

constant clk_period : time := 10 ns;

begin

l:LDREG generic map(16,5) port map(data_in,ld,clk,data_out);

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

data_in<="1010101010101010";
wait for 50 ns;

ld<='1';
wait for 50 ns;
ld<='0';
wait for 50 ns;
data_in<="1111111111111111";

wait;
end process;

end testbench;