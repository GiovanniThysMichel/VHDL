library ieee ;
use ieee.std_logic_1164.all ;
use IEEE.numeric_std.all;
--use IEEE.std_logic_unsigned.all;

----multiple full adders for a + b

entity shifter is
    port (
    sel : in std_logic_vector(1 downto 0);
    a   : in std_logic_vector(5 downto 0);
    b   : in std_logic_vector(5 downto 0);
    r   : out std_logic_vector(5 downto 0)
);
end shifter;


architecture behavior of shifter_unit is 
begin 
    process(sel)
begin 
    if (sel = "00") or (sel = "01") then
        r <= std_logic_vector(shift_left(unsigned(b),to_interger(unsigned(a))));
    elsif (sel = "10") then
        r <= std_logic_vector(shift_right(unsigned(b),to_interger(unsigned(a))));
    elsif ( sel = "11") then
        r <= std_logic_vector(shift_right(signed(a),to_integer(unsigned(b))));
end process; 
end behavior; 

--shifter_alu