library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity vending_machine_subsystem is
        port(
            clk             : in  std_logic;
            rst             : in  std_logic;
            lock            : in  std_logic;
            soda_sel        : in  std_logic_vector(3 downto 0);
            soda_req        : in  std_logic;
            coin_push       : in  std_logic;
            coin_sel        : in  std_logic_vector(1 downto 0);
            
            coin_reject     : out std_logic;
            soda_reserved   : out std_logic;
            soda_price      : out std_logic_vector(11 downto 0);
            soda_drop       : out std_logic;
            deposit_amt     : out std_logic_vector(11 downto 0);
            error_amt       : out std_logic;
            error_reserved  : out std_logic
);
end vending_machine_subsystem;

architecture behavioral of vending_machine_subsystem is 

component vending_machine_ctrl is 
    port(
        clk : in std_logic; 
        rst : in std_logic;
        lock : in std_logic; 
        soda_reserved : in std_logic; 
        soda_price : in std_logic_vector(11 downto 0); 
        soda_req : in std_logic; 
        deposit_amt : in std_logic_vector(11 downto 0); 
        coin_push : in std_logic; 
        coin_amt : in std_logic_vector(11 downto 0);
        
        soda_drop : out std_logic; 
        deposit_incr : out std_logic; 
        deposit_decr : out std_logic; 
        coin_reject : out std_logic; 
        error_amt : out std_logic; 
        error_reserved : out std_logic );  
        
end component; 

component deposit_register is 
    port (
        clk : in std_logic; 
        rst : in std_logic; 
        incr : in std_logic; 
        decr : in std_logic; 
        incr_amt : in std_logic_vector(11 downto 0); 
        decr_amt : in std_logic_vector(11 downto 0); 
        
        amt : out std_logic_vector(11 downto 0)); 
end component; 

component soda_list is
    port(
         soda_sel      : in std_logic_vector(3 downto 0);
         soda_reserved : out std_logic;
         soda_price    : out std_logic_vector(11 downto 0)
         );
end component;

component coin_list is 
    port (
        coin_sel : in std_logic_vector(1 downto 0); 
        coin_amt : out std_logic_vector(11 downto 0));     
end component; 

----signals  -----
   signal coin_l : std_logic_vector(11 downto 0);  
   signal soda_res : std_logic; 
   signal soda_p : std_logic_vector(11 downto 0); 
   
   signal  amts : std_logic_vector(11 downto 0);
   signal incr_d : std_logic;
   signal decr_d :std_logic;
   

begin 


    coin : coin_list 
        port map(
            coin_sel => coin_sel, 
            coin_amt => coin_l
        );
        
    soda : soda_list 
        port map(
            soda_sel => soda_sel, 
            soda_reserved => soda_res,   
            soda_price => soda_p         
        ); 
        
    deposit : deposit_register
        port map (
            clk => clk, 
            rst => rst, 
            incr_amt => coin_l, 
            incr => incr_d, 
            decr => decr_d, 
            decr_amt => soda_p,    
            amt => amts            
        ); 
    vending_machine_control : vending_machine_ctrl 
        port map(
            clk => clk, 
            rst => rst,
            soda_req => soda_req, 
            lock => lock, 
            coin_push => coin_push, 
            soda_drop => soda_drop, 
            error_amt => error_amt, 
            error_reserved => error_reserved,
            coin_reject => coin_reject, 
            soda_reserved => soda_res, 
            soda_price => soda_p,
            deposit_amt => amts,
            coin_amt => coin_l,
            deposit_incr =>  incr_d, 
            deposit_decr => decr_d       
        ); 
        
soda_reserved <= soda_res;
deposit_amt <= amts; 
soda_price <= soda_p;     
       
end behavioral; 
        
        
        