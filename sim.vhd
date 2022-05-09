library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu_tb is
end alu_tb;

architecture behavioral of alu_tb  is

component alu is 
    port (
        sel:in std_logic_vector(3 downto 0); -- 4 bits for the ALU 
        a: in std_logic_vector(5 downto 0); --input 1 of the 6 bit
        b: in std_logic_vector(5 downto 0); --input 2 of the 6 bit 
        r: out std_logic_vector(5 downto 0) --output of 6 bit 
    );
end component;


signal sel  :  std_logic_vector(3 downto 0); 
signal a    :  std_logic_vector(5 downto 0); 
signal b    :  std_logic_vector(5 downto 0);
signal r    :   std_logic_vector(5 downto 0);


begin 
    UUT: alu
    port map(
        sel   => sel,
        a   => a,
        b   => b,
        r  => r
    );
        tb: process 
    begin 

  a <= "110001"; 
  b <= "110010"; 
  wait for 100 ns;   
 
 sel <= "0000"; 
  wait for 100 ns; 
  sel <= "0001"; 
  wait for 100 ns; 
  sel <= "0010"; 
  wait for 100 ns; 
  sel <= "0011"; 
  wait for 100 ns;
  sel <= "0100"; 
  wait for 100 ns;
  sel <= "0101"; 
  wait for 100 ns;
  sel <= "0110";
  wait for 100 ns;
  sel <= "0111";
  wait for 100 ns;
  sel <= "1000";
  wait for 100 ns;
  sel <= "1001"; 
  wait for 100 ns; 
  sel <= "1010"; 
  wait for 100 ns; 
  sel <= "1011"; 
  wait for 100 ns;
  sel <= "1100"; 
  wait for 100 ns;
  sel <= "1101"; 
  wait for 100 ns;
  sel <= "1110";
  wait for 100 ns;
  sel <= "1111";
  wait for 100 ns;
    end process; 
 end behavioral; 