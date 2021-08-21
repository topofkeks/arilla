library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IDCREG is

	generic
	(
		size : natural := 16;
		default_value: natural:=0;
		clear_value: natural:=0
	);

	port 
	(
		data_in	: in  std_logic_vector(size-1 downto 0);
		ld	      : in  std_logic := '0';
		cl	      : in  std_logic := '0';
		inc	      : in  std_logic := '0';
		dec	      : in  std_logic := '0';
		clk		: in  std_logic := '0';
		data_out	: out std_logic_vector(size-1 downto 0)
	);

end entity;

architecture rtl of IDCREG is
	signal data : std_logic_vector(size-1 downto 0) :=std_logic_vector(to_unsigned( default_value, size));
begin
	data_out <= data;
	process (clk)
	begin
		if (rising_edge(clk)) then
				if cl = '1' then
					data<=std_logic_vector(to_unsigned( clear_value, size));
				elsif ld = '1' then
					data<=data_in;
				elsif inc = '1' then
					data<=std_logic_vector(to_unsigned(to_integer(unsigned( data )) + 1, size));
				elsif dec = '1' then
					data<=std_logic_vector(to_unsigned(to_integer(unsigned( data )) - 1, size));
				end if;
		end if;
	end process;
end rtl;
