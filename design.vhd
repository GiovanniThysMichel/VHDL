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


    ----adder_alu


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

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY mux4to1 IS
	PORT (
		    a1, a2, a3, a4	: IN 	STD_LOGIC_VECTOR(5 DOWNTO 0) ;
			sel	            : IN 	STD_LOGIC_VECTOR(1 DOWNTO 0) ;
			r	            : OUT 	STD_LOGIC_VECTOR(5 DOWNTO 0) 
		) ;
END mux4to1 ;


SIGNAL mux_res : STD_LOGIC_VECTOR(5 DOWNTO 0) ;


ARCHITECTURE Dataflow OF mux4to1 IS	
BEGIN
	WITH sel SELECT
		r <= w0 WHEN "00",
	                a1 WHEN "01",
	                a2 WHEN "10",
	                a3 WHEN OTHERS ;
END Dataflow ;

--4_to_1mux


LIBRARY ieee;
USE ieee.std_logic_1164.all;     
--USE ieee.std_logic_signed.all ;

entity alu is
	 port(
        sel : in std_logic_vector(3 downto 0);
        a   : in std_logic_vector(5 downto 0);
        b   : in std_logic_vector(5 downto 0);
        r   : out std_logic_vector(5 downto 0)
	     );
end alu;

architecture structural of reg_file is
    
    component logic_unit is generic(
        n : integer := 4
    );
    port(
        sel : in std_logic_vector(3 downto 0);
        a   : in std_logic_vector(5 downto 0);
        b   : in std_logic_vector(5 downto 0);
        r   : out std_logic_vector(5 downto 0)
	     );

    );
    end component;

    component adder is generic(
        n : integer := 4
    );
        port (
        sel : in std_logic_vector(1 downto 0);
        a   : in std_logic_vector(5 downto 0);
        b   : in std_logic_vector(5 downto 0);
        r   : out std_logic_vector(5 downto 0)
    );
    end component;

    component multiply is generic(
        n : integer := 4
    );
    port(
        sel : in std_logic;
        a   : in std_logic_vector(5 downto 0);
        b   : in std_logic_vector(5 downto 0);
        r   : out std_logic_vector(5 downto 0)
	    );
    );
    end component;


    component shifter is generic(
        n : integer := 4
    );
        port (
        sel : in std_logic_vector(1 downto 0);
        a   : in std_logic_vector(5 downto 0);
        b   : in std_logic_vector(5 downto 0);
        r   : out std_logic_vector(5 downto 0)
    );
    end component;




    signal alu_dout :std_logic_vector(5 downto 0);


    begin
        
        inst_adder : adder
        port map(
           sel => sel(1 downto 0),
           a => a, 
           b => b, 
           r => a1
    );
    
        inst_mult : mult
            port map(
                sel => sel(0), 
                a => a, 
                b => b, 
                r => a2
        );
        
        inst_logic : logic_unit
            port map(
                sel => sel(1 downto 0), 
                a => a, 
                b => b, 
                r => a3
        ); 
        
        inst_shift : shifter_unit
            port map(
                sel => sel(1 downto 0),
                a => a, 
                b => b(2 downto 0), 
                r => a4
        );  
        inst_mux : mux_4to1  
        port map(
           sel => sel(3 downto 2),
            a1 => a1, 
            a2 => a2,
            a3 => a3, 
            a4 => a4,
            r => r
        );


        with sel(3 downto 2) select r <=
            adder_res when "00",
            mult_res when "10",
            logic_res when "01",
            shifter_res when "11",
            "000000"    when others;



end structural;


--ALU
