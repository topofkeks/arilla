library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CONSTX is

	generic
	(
		size  : natural  := 16;
		const : integer  :=0
	);

	port 
	(
		data: out std_logic_vector(size-1 downto 0)
	);

end entity;

architecture rtl of CONSTX is
begin
	data<=std_logic_vector(to_signed(const,size));
end rtl;
