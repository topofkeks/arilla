library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SDRAM_ReadROM is
    port(
        ADDR: in std_logic_vector(2 downto 0);
        O: out std_logic_vector(15 downto 0)
    );
end entity;

architecture rtl of SDRAM_ReadROM is
    type romType is array (7 downto 0) of std_logic_vector(15 downto 0);
    signal ROM : romType := (others => (others =>'0'));
begin

    --program starts here
    ROM(0)<= "0000100000000000";
    ROM(1)<= "0010110000000000";
    ROM(2)<= "0000000000000111";
    ROM(3)<= "0000000001111011";
    ROM(4)<= "1001000110000000";
    ROM(5)<= "0000001010001110";
    ROM(6)<= "0000000010000000";
    ROM(7)<= "0010010000000000";
    --program ends here

process(ADDR)
begin

    O<=ROM(to_integer(unsigned(ADDR)));

end process;
end rtl;
