library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ARILLAROM is
    port(
        ADDR: in std_logic_vector(3 downto 0);
        O: out std_logic_vector(25 downto 0)
    );
end entity;

architecture rtl of ARILLAROM is
    type romType is array (15 downto 0) of std_logic_vector(25 downto 0);
    signal ROM : romType := (others => (others =>'0'));
begin

    --program starts here
    ROM(0)<= "00000100000000000000000000";
    ROM(1)<= "11100110000000000000011111";
    ROM(2)<= "00001000000000000111100000";
    ROM(3)<= "00000010000000011000000000";
    ROM(4)<= "11010010000000000110000000";
    ROM(5)<= "00000010000001111010000110";
    ROM(6)<= "00000010000001111000010110";
    ROM(7)<= "00000010000110000000000000";
    ROM(8)<= "11101010001001000100010000";
    ROM(9)<= "00000010000000110000000000";
    ROM(10)<="11101010011001000001000000";
    ROM(11)<="00000010000000000000000000";
    ROM(12)<="00000000100000000100000000";
    ROM(13)<="00000010000000010000000000";
    ROM(14)<="11100011000000000000000000";
    --program ends here

process(ADDR)
begin

    O<=ROM(to_integer(unsigned(ADDR)));

end process;
end rtl;
