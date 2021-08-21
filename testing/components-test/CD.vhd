library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CD is
	generic
	(
		output_bits:  integer := 2
	);
	port
	(
		I:in std_logic_vector((2**output_bits)-1 downto 0) := (others => '0');
		E:in std_logic := '0';
		O:out std_logic_vector(output_bits-1 downto 0);
		W:out std_logic
	);
end entity;

architecture rtl of CD is
begin
	process(I,E)
	begin
		if E='1' then
			W<='0';
			O<=(others => '0');
			for n in ((2**output_bits)-1) downto 0 loop
				if(I(n)='1') then
					O<=std_logic_vector(to_unsigned(n, output_bits));
					W<='1';
					exit;
				end if;
			end loop;
		else
			O<=(others => '0');
			W<='0';
		end if;
	end process;
end rtl;