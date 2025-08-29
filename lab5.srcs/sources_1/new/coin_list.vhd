--coin_list

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
use ieee.numeric_std.all; 

entity coin_list is
port(
    coin_sel : in  std_logic_vector(1 downto 0);
    coin_amt : out std_logic_vector(11 downto 0)
);
end coin_list;

architecture structural of coin_list is
begin
    with coin_sel select coin_amt <= 
    "000000000001" when "00", 
    "000000000101" when "01", 
    "000000001010" when "10", 
    "000000011001" when "11", 
    (others => '0') when others; 
     
end structural;