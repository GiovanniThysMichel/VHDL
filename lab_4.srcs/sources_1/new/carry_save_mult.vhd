library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;

entity carry_save_mult is
    generic( n : integer := 8);
    port(
            a : in  std_logic_vector(n - 1 downto 0);
            b : in  std_logic_vector(n - 1 downto 0);
            p : out std_logic_vector(2*n-1 downto 0)
    );
end carry_save_mult;

architecture dataflow of carry_save_mult is
    component full_adder is
        port(
            a       : in     std_logic;
            b       : in     std_logic;
            cin     : in	 std_logic;
            cout    : out    std_logic;  
            sum     : out 	 std_logic
        );
    
    end component;


    --variable array of n-bit std_logic_vector
    type array_2d is array (integer range <> ) of std_logic_vector(n -1 downto 0);

    --and matrix
    --2d array
    signal ab : array_2d(0 to n-1);
    
    --signals for full adders    
    signal fa_a      : array_2d(0 to n-2);
    signal fa_b      : array_2d(0 to n-2);
    signal fa_cin    : array_2d(0 to n-2);
    signal fa_sum    : array_2d(0 to n-2);
    signal fa_cout   : array_2d(0 to n-2);

    begin
        gen_row_and_matrix  : for i in 0 to n-1 generate
            gen_col_and_matrix  : for j in 0 to n-1 generate
                ab(i)(j)    <= a(j) and b(i);
            end generate;
        end generate;

    
    gen_ab_rows  : for i in 0 to n-2 generate
        gen_ab_cols  : for j in 0 to n-1 generate
        u_fa : full_adder
        port map(
            a        =>fa_a(i)(j)   ,
            b        =>fa_b(i)(j)   ,
            cin      =>fa_cin(i)(j) ,
            cout     =>fa_cout(i)(j),
            sum      => fa_sum(i)(j)

    );
        end generate;
    end generate;

    fa_a(0)     <= "0" & ab(0)(n-1 downto 1) ;
    fa_b(0)     <= ab(1)(n-1 downto 0) ;
    fa_cin(0)   <= ab(2)(n-2 downto 0) & "0" ;
    

    gen_ab_inter  : for i in 1 to n-3 generate
    fa_a(i) <= ab(i+1)(n-1) & fa_sum(i-1)(n-1 downto 1);
    fa_b(i) <= fa_cout(i-1)(n-1 downto 0);
    fa_cin(i) <=  ab(i+2)(n-2 downto 0) & '0';
    end generate;


   fa_a(n-2) <=  ab(n-1)(n-1) & fa_sum(n-3)(n-1 downto 1);
   fa_b(n-2) <=  fa_cout(n-3)(n-1 downto 0);
   fa_cin(n-2) <=  fa_cout(n-2)(n-2 downto 0) & '0';


    
     p(0) <= ab(0)(0);
    --bit 1 to n-2
    gen_index_prod:   for i in 1 to n-2 generate
            p(i) <= fa_sum(i-1)(0);
        
    end generate;
    
    --- Bits n-1 to 2n-2 are wired to the sum in the last row of FAs.
    -- Bit 2n-1 are wired to the cout of the last FA in the last row.
    p(n-1)<= fa_sum(n-2)(0);
    p(n)<=fa_sum(n-2)(1);
    p(n+1)<=fa_sum(n-2)(2);
    p(2*n-3)<= fa_sum(n-2)(n-2);
    p(2*n-2)<= fa_sum(n-2)(n-1);
    p(2*n-2 downto n-1)<= fa_sum(n-2)(n-1 downto 0);    
    p(2*n -1) <= fa_cout(n-2)(n-1);  --last one

end dataflow;

