library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MP2X is

	generic
	(
		size : natural := 16
	);

	port 
	(
		X0	: in std_logic_vector(size-1 downto 0);
		X1	: in std_logic_vector(size-1 downto 0);
		S : in std_logic;
		Y : out std_logic_vector(size-1 downto 0)
		
	);

end entity;

architecture rtl of MP2X is
begin

	process (S,X0,X1)
	begin
		if S='0' then
			Y<=X0;
		else
			Y<=X1;
		end if;
	end process;
end rtl;
