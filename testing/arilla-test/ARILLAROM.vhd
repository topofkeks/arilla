library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ARILLAROM is
    port(
        ADDR: in std_logic_vector(3 downto 0);
        O: out std_logic_vector(24 downto 0)
    );
end entity;

architecture rtl of ARILLAROM is
    type romType is array (15 downto 0) of std_logic_vector(24 downto 0);
    signal ROM : romType := (others => (others =>'0'));
begin

    --program starts here
    ROM(0)<= "0000010000000000000000000";
    ROM(1)<= "1110011000000000000011111";
    ROM(2)<= "0000100000000000011101000";
    ROM(3)<= "0001001000000001100000000";
    ROM(4)<= "1101001000000000010001000";
    ROM(5)<= "0000001000000111100001110";
    ROM(6)<= "0000001000000111100010110";
    ROM(7)<= "0000001000011000000000000";
    ROM(8)<= "1110101000100100010010000";
    ROM(9)<= "0001001000000011000000000";
    ROM(10)<="1110101001100100000010000";
    ROM(11)<="0001001000000000000000000";
    ROM(12)<="0000000010000000010000000";
    ROM(13)<="0001001000000001000000000";
    ROM(14)<="1110001100000000000000000";
    --program ends here

process(ADDR)
begin

    O<=ROM(to_integer(unsigned(ADDR)));

end process;
end rtl;
