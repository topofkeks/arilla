library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DEMUX is
	generic
	(
		size:  integer := 2;
		width: integer := 16
	);
	port
	(
		I:in std_logic_vector(width-1 downto 0) := (others => '0');
		S:in std_logic_vector(size-1 downto 0) := (others => '0');
		E:in std_logic := '0';
		O:out std_logic_vector(((2**size)*width)-1 downto 0)
	);
end entity;

architecture rtl of DEMUX is
	type arr is array((2**size)-1 downto 0) of std_logic_vector(width-1 downto 0);
	signal output : arr;
begin
	genOutput:for n in 0 to (2**size)-1 generate
		O(((n+1)*width)-1 downto n*width)<=output(n)(width-1 downto 0);
	end generate;
	process(I,S,E)
	begin
		output<=(others => (others => '0'));
		if E='1' then
			output(to_integer(unsigned(S)))<=I;
		end if;
	end process;
end rtl;