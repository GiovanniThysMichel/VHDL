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