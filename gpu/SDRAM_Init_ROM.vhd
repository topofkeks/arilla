library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SDRAM_InitROM is
    port(
        ADDR: in std_logic_vector(3 downto 0);
        O: out std_logic_vector(12 downto 0)
    );
end entity;

architecture rtl of SDRAM_InitROM is
    type romType is array (15 downto 0) of std_logic_vector(12 downto 0);
    signal ROM : romType := (others => (others =>'0'));
begin

    --program starts here
    ROM(0)<= "0000100000001";
    ROM(1)<= "0000000001111";
    ROM(2)<= "0000000000001";
    ROM(3)<= "0000000010010";
    ROM(4)<= "0000000000001";
    ROM(5)<= "0000000000001";
    ROM(6)<= "0000000000001";
    ROM(7)<= "0000000010010";
    ROM(8)<= "0000000000001";
    ROM(9)<= "0000000000001";
    ROM(10)<="0000000000001";
    ROM(11)<="0000000110011";
    ROM(12)<="0000000000001";
    ROM(13)<="0000000000001";
    ROM(14)<="1110011000000";
    --program ends here

process(ADDR)
begin

    O<=ROM(to_integer(unsigned(ADDR)));

end process;
end rtl;
