library ieee; 
use ieee.std_logic_1164.all; 
USE ieee.std_logic_unsigned.all;

----multiple full adders for a + b

entity adder is
    port (
    sel : in std_logic_vector(1 downto 0);
    a   : in std_logic_vector(5 downto 0);
    b   : in std_logic_vector(5 downto 0);
    r   : out std_logic_vector(5 downto 0)
);
end adder;

architecture behaivoral of adder is
    
    signal a_long           : std_logic_vector(6 downto 0);
    signal b_long           : std_logic_vector(6 downto 0);
    signal negative_b       : std_logic_vector(6 downto 0);
    signal sum_long         : std_logic_vector(6 downto 0);
    signal sum              : std_logic_vector(5 downto 0);
    
    signal carry            : std_logic;
    signal borrow           : std_logic;
    signal adder_borrow     : std_logic;
    
    
    signal negative_sum         : std_logic_vector(6 downto 0);
    signal difference           : std_logic_vector(5 downto 0);
    signal carry_long           : std_logic_vector(6 downto 0);
    signal borrow_long          : std_logic_vector(6 downto 0);
    
    begin

        a_long <= '0' & a;
        b_long <= '0' & b;
        negative_b <= '0' & (not b);
        negative_sum <= a_long + negative_b + 1;
        sum_long <= a_long + b_long;
        difference <= negative_sum(5 downto 0);
        borrow <= negative_sum(6);

        carry_long(0) <= carry;
        carry_long(5 downto 1) <= "00000"; --(others => '0);
        

        borrow_long(0) <= borrow;
        borrow_long(5 downto 1) <= "00000"; --(others => '0);
        


        with sel(1 downto 0) select r <=
            sum         when "00", 
            carry_long  when "01",
            difference  when "10",
            borrow_long when "11",
            (others => '0') when others;
             


    end behaivoral;
