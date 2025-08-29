library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;

entity full_adder is
    port(
        a       : in     std_logic;
        b       : in     std_logic;
        cin     : in	 std_logic;
		cout    : out    std_logic;  
        sum     : out 	 std_logic
    );

end full_adder;

architecture dataflow of full_adder is
 
signal wire_s : std_logic;
 
begin
    wire_s  <= a xor b;
    sum <= wire_s  xor cin;
    cout  <=  b when wire_s = '0' else cin;
    
end dataflow ;
    

