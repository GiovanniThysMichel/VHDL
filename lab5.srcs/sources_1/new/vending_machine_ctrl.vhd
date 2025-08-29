library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity vending_machine_ctrl is 
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
        
end vending_machine_ctrl; 

architecture structural of vending_machine_ctrl is 
type fsm_state is 
( idle, coin_check, 
coin_accept, coin_decline, 
soda_accept_wait, soda_accept, 
soda_check, soda_decline_amt,
soda_decline_reserved );
 
signal state : fsm_state; 
begin       
    FSM : process(clk)    
    begin
        if rising_edge(clk) then 
            if rst = '0' then 
                state <= idle; 
            else 
                case state is 
                    when idle => 
                        if coin_push = '1' then 
                            state <= coin_check;
                        elsif(soda_req = '1') then 
                            state <= soda_check; 
                        end if;  
                    when coin_check => 
                        if (coin_amt + deposit_amt <= x"3E8") then
                            state <= coin_accept;                      
                        else 
                            state <= coin_decline; 
                        end if; 
                    when coin_accept => 
                        state <= idle; 
                        
                    when coin_decline => 
                        if (lock = '0') then
                            state <= idle; 
                        end if;
                     ---done with left part----
                     ----starting right states---                   
                    when soda_check => 
                    
                        if(soda_reserved = '1') then
                            state <= soda_decline_reserved; 
                        elsif(soda_reserved = '0' and deposit_amt >= soda_price) then                        
                            state <= soda_accept; 
                        else 
                            state <= soda_decline_amt; 
                        end if;
                        
                    when soda_accept => 
                        state <= soda_accept_wait; 
                        
                    when soda_accept_wait => 
                        if(lock = '0') then
                            state <= idle; 
                        end if;
                        
                    when soda_decline_amt => 
                        if(lock = '0') then
                            state <= idle; 
                        end if;                       
                    when soda_decline_reserved => 
                        if(lock = '0') then
                            state <= idle;  
                      end if;                    
        end case; 
      end if; 
     end if; 
    end process;  
    
deposit_incr <= '1' when (state = coin_accept) else '0';
coin_reject <= '1' when (state = coin_decline) else '0'; 
soda_drop <= '1' when (state = soda_accept_wait) else '0';     
deposit_decr <= '1' when (state = soda_accept) else '0';
error_amt <= '1' when (state = soda_decline_amt) else '0';
error_reserved <= '1' when (state = soda_decline_reserved) else '0';
                                          
end structural;                  
                 
                  
               
                 
                         
                     
                         
                         
                  
                         
                         
                                 
    


