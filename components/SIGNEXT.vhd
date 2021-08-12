library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SIGNEXT is
	generic
	(
		in_width:  integer := 8;
		out_width: integer := 16
	);
	port
	(
		I:in std_logic_vector(in_width-1 downto 0) := (others => '0');
		O:out std_logic_vector(out_width-1 downto 0)
	);
end entity;

architecture rtl of SIGNEXT is
begin
	process(I)
	begin
	O<=(others => I(in_width-1));
	O(in_width-1 downto 0)<=I(in_width-1 downto 0);
	
	end process;
end rtl;