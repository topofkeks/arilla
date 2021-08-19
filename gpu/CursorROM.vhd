library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CursorROM is
    port(
        ADDR: in std_logic_vector(2 downto 0);
        O: out std_logic_vector(23 downto 0)
    );
end entity;

architecture rtl of CursorROM is
    type romType is array (7 downto 0) of std_logic_vector(23 downto 0);
    signal ROM : romType := (others => (others =>'0'));
begin

    --program starts here
    ROM(0)<= "111111111111111111101100";
    ROM(1)<= "001001010101010101100000";
    ROM(2)<= "000010010101010110000000";
    ROM(3)<= "000000100101010110110000";
    ROM(4)<= "000000001001010110011011";
    ROM(5)<= "000000000010011011110110";
    ROM(6)<= "000000000000100100001100";
    ROM(7)<= "000000000000001100000000";
    --program ends here

process(ADDR)
begin

    O<=ROM(to_integer(unsigned(ADDR)));

end process;
end rtl;
