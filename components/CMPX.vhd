library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CMPX is

	generic
	(
		size : natural := 16
	);

	port 
	(
		A	: in  std_logic_vector(size-1 downto 0);
		B	: in std_logic_vector(size-1 downto 0);
		eq : out std_logic;
		ls : out std_logic;
		gr : out std_logic
	);

end entity;

architecture rtl of CMPX is
begin

	process (A,B)
	begin
		if A=B then
			eq<='1';
		else
			eq<='0';
		end if;
		
		if unsigned(A)>unsigned(B) then
			gr<='1';
		else
			gr<='0';
		end if;
		
		if unsigned(A)<unsigned(B) then
			ls<='1';
		else
			ls<='0';
		end if;
		
	end process;
end rtl;
