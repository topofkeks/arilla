library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FallingEdge is
	port
	(
		input		  : in std_logic;
		output	  : out std_logic;
		clk		  : in std_logic
	);

end entity;

architecture rtl of FallingEdge is
	signal state	   : std_logic_vector(1 downto 0):= (others => '0');
	signal state_next : std_logic_vector(1 downto 0):= (others => '0');
begin

	process (clk)
	begin
		if (rising_edge(clk)) then
			state(0)<=state_next(0);
			state(1)<=state_next(1);
		end if;
	end process;
	
	process (input, state)
	begin
		state_next(0)<=state(1);
		state_next(1)<=input;
	end process;

	output <= state(0) and not (state(1));
	
end rtl;
