library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADDX is

	generic
	(
		size : natural :=16
	);
	
	port 
	(
		A	   : in std_logic_vector  (size-1 downto 0);
		B	   : in std_logic_vector  (size-1 downto 0);
		Cin   : in std_logic;
		F		: out std_logic_vector (size-1 downto 0);
		Cout  : out std_logic
	);

end entity;

architecture rtl of ADDX is
	
begin

	process (A,B,Cin) is
		variable varA,varB,varF: std_logic_vector (size downto 0);
	begin
			varA(size downto 0):=A(size-1)&A(size-1 downto 0);
			varB(size downto 0):=B(size-1)&B(size-1 downto 0);
			if Cin='1' then
				varF := std_logic_vector(unsigned(varA)+unsigned(varB)+1);
			else
				varF := std_logic_vector(unsigned(varA)+unsigned(varB));
			end if;

			F(size-1 downto 0)<=varF(size-1 downto 0);
			Cout <=varF(size);
			
	end process;



end rtl;
