LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_textio.all;
use ieee.std_logic_arith.all; 

LIBRARY std;
USE std.textio.all;

entity mult_tb is 
end mult_tb; 

architecture dataflow of mult_tb is 
    constant WAIT_TIME : time := 100ns;  
    component mult is 
     port (
        a_mult,b_mult  : in std_logic_vector(7 downto 0);
        clk            : in std_logic;
        p              : out std_logic_vector(15 downto 0)
        );
end component; 


signal clk : std_logic; 
signal a : std_logic_vector(7 downto 0); 
signal b :std_logic_vector( 7 downto 0); 
signal p : std_logic_vector(15 downto 0); 
    
file carry_save_file: text open read_mode is "mult8x8.dat"; 
    
 begin 
        
u_mult : mult 
port map (
    a_mult => a,
    b_mult => b,  
    clk => clk,
    p => p
);   
            
clck : process 
begin 
     clk <= '0'; 
     wait for 10ns ;
     clk <= '1'; 
     wait for 20ns; 
     
end process; 
 
 tb : process 
    variable v_line : line;
    variable v_space : character; 
    variable va :  std_logic_vector(7 downto 0); 
    variable vb :  std_logic_vector(7 downto 0); 
    variable vp :  std_logic_vector(15 downto 0); 
    variable cur_line : integer := 1; 
begin

    while not endfile(carry_save_file) loop 
        readline(carry_save_file, v_line); 
        hread(v_line, va); 
        read(v_line, v_space); 
        hread(v_line,vb); 
        read(v_line, v_space); 
        hread(v_line, vp); 
                
        a <= va; 
        b <= vb; 
        wait for WAIT_TIME; 
        --test if equal 
        assert p = vp 
           report "Actual value does not match expected value at line " & integer 'image(cur_line)
                severity failure; 
                cur_line := cur_line + 1;
    end loop; 
     
        report "Simulation complete"; 
       wait; 
    end process;     

end dataflow;