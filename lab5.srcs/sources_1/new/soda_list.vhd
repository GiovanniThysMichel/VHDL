library ieee;                                  
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 

entity soda_list is
    port(
         soda_sel      : in std_logic_vector(3 downto 0);
         soda_reserved : out std_logic;
         soda_price    : out std_logic_vector(11 downto 0)
         );
end soda_list;

architecture dataflow of soda_list is

begin
    --conv_std_logic_vector(55,12); --change here 
    with soda_sel select soda_price <=
         conv_std_logic_vector(55,12)  when "0000",
         conv_std_logic_vector(85,12)  when "0001",
         conv_std_logic_vector(95,12)  when "0010",
         conv_std_logic_vector(125,12) when "0011",
         conv_std_logic_vector(135,12) when "0100",
         conv_std_logic_vector(150,12) when "0101",
         conv_std_logic_vector(225,12) when "0110",
         conv_std_logic_vector(250,12) when "0111",
         conv_std_logic_vector(300,12) when "1000",
         (others => '0') when others; 
         
    with soda_sel select soda_reserved <=
         '1' when "1001",
         '1' when "1010",
         '1' when "1011",
         '1' when "1100",
         '1' when "1101",
         '1' when "1110",
         '1' when "1111",
         '0' when others;

end dataflow;