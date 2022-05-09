LIBRARY ieee;
USE ieee.std_logic_1164.all;     
--USE ieee.std_logic_signed.all ;

entity logic_unit is
	 port(
        sel : in std_logic_vector(1 downto 0);
        a   : in std_logic_vector(5 downto 0);
        b   : in std_logic_vector(5 downto 0);
        r   : out std_logic_vector(5 downto 0)
	     );
end logic_unit;

architecture behaivoral of logic_unit is


    signal a_long           : std_logic_vector(5 downto 0);

    signal and_long         : std_logic_vector(5 downto 0);
    signal or_long          : std_logic_vector(5 downto 0);
    signal xor_long         : std_logic_vector(5 downto 0);



    
    begin 
    
    a_long <= not a;
    and_long <= a and b;
    or_long <= a or b;
    xor_long <= a xor b;
    
    with sel(1 downto 0) select r <=
        a_long when "00", 
        --sum  x XOR y XOR Cin ;
        and_long  when "01",
        or_long  when "10",
        xor_long when "11",
        (others => '0') when others;
        
end behaivoral;


--logicunit_alu