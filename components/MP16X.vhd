library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MP16X is

	generic
	(
		size : natural := 16
	);

	port 
	(
		X0	: in std_logic_vector(size-1 downto 0);
		X1	: in std_logic_vector(size-1 downto 0);
		X2	: in std_logic_vector(size-1 downto 0);
		X3	: in std_logic_vector(size-1 downto 0);
		X4	: in std_logic_vector(size-1 downto 0);
		X5	: in std_logic_vector(size-1 downto 0);
		X6	: in std_logic_vector(size-1 downto 0);
		X7	: in std_logic_vector(size-1 downto 0);
		X8	: in std_logic_vector(size-1 downto 0);
		X9	: in std_logic_vector(size-1 downto 0);
		X10	: in std_logic_vector(size-1 downto 0);
		X11	: in std_logic_vector(size-1 downto 0);
		X12	: in std_logic_vector(size-1 downto 0);
		X13	: in std_logic_vector(size-1 downto 0);
		X14	: in std_logic_vector(size-1 downto 0);
		X15	: in std_logic_vector(size-1 downto 0);
		S0 : in std_logic;
		S1 : in std_logic;
		S2 : in std_logic;
		S3 : in std_logic;
		Y : out std_logic_vector(size-1 downto 0)
		
	);

end entity;

architecture rtl of MP16X is
begin

	process (S0,S1,S2,X0,X1,X2,X3,X4,X5,X6,X7)
	begin
		if S3='0' then
			if S2='0' then
				if S1='0' then
					if S0='0' then
						Y<=X0;
					else
						Y<=X1;
					end if;
				else
					if S0='0' then
						Y<=X2;
					else
						Y<=X3;
					end if;
				end if;
			else
				if S1='0' then
					if S0='0' then
						Y<=X4;
					else
						Y<=X5;
					end if;
				else
					if S0='0' then
						Y<=X6;
					else
						Y<=X7;
					end if;
				end if;
			end if;
		else
			if S2='0' then
				if S1='0' then
					if S0='0' then
						Y<=X8;
					else
						Y<=X9;
					end if;
				else
					if S0='0' then
						Y<=X10;
					else
						Y<=X11;
					end if;
				end if;
			else
				if S1='0' then
					if S0='0' then
						Y<=X12;
					else
						Y<=X13;
					end if;
				else
					if S0='0' then
						Y<=X14;
					else
						Y<=X15;
					end if;
				end if;
			end if;
		end if;
	end process;
end rtl;
