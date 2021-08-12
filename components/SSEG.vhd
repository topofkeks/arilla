library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SSEG is
	port
	(
		I:in std_logic_vector(3 downto 0) := (others => '0');
		O:out std_logic_vector(7 downto 0)
	);
end entity;

architecture rtl of SSEG is
begin
	process(I)
	begin
	case I is
		when "0000" => O <= "00000011"; -- "0"     
		when "0001" => O <= "10011111"; -- "1" 
		when "0010" => O <= "00100101"; -- "2" 
		when "0011" => O <= "00001101"; -- "3" 
		when "0100" => O <= "10011001"; -- "4" 
		when "0101" => O <= "01001001"; -- "5" 
		when "0110" => O <= "01000001"; -- "6" 
		when "0111" => O <= "00011111"; -- "7" 
		when "1000" => O <= "00000001"; -- "8"     
		when "1001" => O <= "00001001"; -- "9" 
		when "1010" => O <= "00000101"; -- a
		when "1011" => O <= "11000001"; -- b
		when "1100" => O <= "01100011"; -- C
		when "1101" => O <= "10000101"; -- d
		when "1110" => O <= "01100001"; -- E
		when "1111" => O <= "01110001"; -- F
	end case;
	end process;
end rtl;