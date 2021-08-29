library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SDRAM_WriteROM is
    port(
        ADDR: in std_logic_vector(2 downto 0);
        O: out std_logic_vector(10 downto 0)
    );
end entity;

architecture rtl of SDRAM_WriteROM is
    type romType is array (7 downto 0) of std_logic_vector(10 downto 0);
    signal ROM : romType := (others => (others =>'0'));
begin

    --program starts here
    ROM(0)<= "00010000000";
    ROM(1)<= "00111000000";
    ROM(2)<= "00000000111";
    ROM(3)<= "00000111000";
    ROM(4)<= "00101000000";
    --program ends here

process(ADDR)
begin

    O<=ROM(to_integer(unsigned(ADDR)));

end process;
end rtl;
