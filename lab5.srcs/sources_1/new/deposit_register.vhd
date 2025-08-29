library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity deposit_register is 
    port (
        clk : in std_logic; 
        rst : in std_logic; 
        incr : in std_logic; 
        incr_amt : in std_logic_vector(11 downto 0); 
        decr : in std_logic; 
        decr_amt : in std_logic_vector(11 downto 0); 
        amt : out std_logic_vector(11 downto 0)); 
end deposit_register; 

architecture dataflow of deposit_register is 
    signal amts : std_logic_vector(11 downto 0); 
begin
    process(clk) 
        begin       
          if rising_edge(clk) then 
             if (rst = '0') then 
                    amts <= "000000000000"; 
             else 
                if(incr = '1') then
                amts <= amts + incr_amt; 
             elsif(decr = '1') then
                amts <= amts - decr_amt; 
                end if; 
          end if;
        end if; 
 end process; 
 amt <= amts; 
end dataflow; 