library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mult is 
    port(
        a_mult,b_mult  : in std_logic_vector(7 downto 0);
        clk            : in std_logic;
        p              : out std_logic_vector(15 downto 0)

    );
end mult;

---Use for generate
architecture behaivoral of mult is

    component carry_save_mult is generic(
        n : integer := 8
    );
        port(
            a : in  std_logic_vector(n - 1 downto 0);
            b : in  std_logic_vector(n - 1 downto 0);
            p : out std_logic_vector(2* n-1 downto 0)
        );
     
    end component;

    component reg8 is generic(
        n : integer := 8 
    );
    
    port ( 
        D : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0) ;
        clock : IN STD_LOGIC ;
        Q : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0) ) ;
    end component ;
    
    
    signal op_a :std_logic_vector(7 downto 0);
    signal op_b :std_logic_vector(7 downto 0);
    signal op_p : std_logic_vector(15 downto 0);

begin

    inst_reg_module : carry_save_mult
    port map(
        a =>op_a  ,
        b =>op_b , 
        p => p                

    );
    
    inst_reg_file1   : reg8 
    port map (
        D => a_mult,
        clock => clk,
        Q=> op_a              
    );
    
    
    inst_reg_file2   : reg8 
    port map (
        D => b_mult,  
        clock => clk,
        Q=> op_b  
    );
   
    

end behaivoral;


LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY reg8 IS
    generic ( n : integer := 8); 
PORT ( 
    D : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0) ;
    clock : IN STD_LOGIC ;
    Q : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0))  ;
END reg8;
ARCHITECTURE Behavior OF reg8 IS
BEGIN
PROCESS ( clock  )
BEGIN
IF rising_edge(clock ) THEN
Q <= D ;
END IF ;
END PROCESS ;
END Behavior ;