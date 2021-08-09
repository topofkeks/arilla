-- clockDivider

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CLK_DIVIDER is

	generic
	(
		period_InMHz: natural:=50;
		period_OutMiliSec: natural:=1
	);

	port
	(
		in_clk		: in std_logic;
		reset	  		: in std_logic;
		pause			: in std_logic;
		out_clk		: out std_logic
	);

end entity;

architecture rtl of CLK_DIVIDER is

	constant range_from:natural := (period_OutMiliSec)*((period_InMHz*1000))/2 -1; -- poluperioda
	
begin

	process (in_clk)
		variable cnt: natural range range_from downto 0;
		variable out_clk_next: std_logic:='0';
	begin
	
		if (rising_edge(in_clk)) then

			if reset = '1' then
				-- Reset the counter
				cnt := range_from;

			else	   
				if pause='0' then
					cnt := cnt - 1;
				end if;
			end if;
			
			-- Output the current count
			if cnt=0 then
				out_clk_next := not out_clk_next;
			end if;
			
			
		end if;
		
		out_clk<=out_clk_next;
		
	end process;

end rtl;
