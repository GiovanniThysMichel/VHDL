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