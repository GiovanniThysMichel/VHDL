LIBRARY ieee;
USE ieee.std_logic_1164.all;     
--USE ieee.std_logic_signed.all ;

entity mult is
	 port(
        sel : in std_logic;
        a   : in std_logic_vector(5 downto 0);
        b   : in std_logic_vector(5 downto 0);
        r   : out std_logic_vector(5 downto 0)
	     );
end mult;

architecture behaivoral of mult is
    
    signal prod : std_logic_vector(11 downto 0);

begin
    process
	prod <= a * b;

    if sel '1' then
        r <= prod (11 downto 6);
        
    else
        r <= prod (5 downto 0);
    end if;
    end process;
end behaivoral;
		
----multiply_alu
