-- Extensorde Sinal de 3 para 8 bits 
LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;  
USE ieee.std_logic_unsigned.all;


ENTITY ExtensordeSinalde3para8bits  IS
	PORT(
		ENTRADA : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		ENTRADA2: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		SAIDA   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		estender : IN STD_LOGIC
	);
	
END ExtensordeSinalde3para8bits ;

ARCHITECTURE BEHAVIOR OF ExtensordeSinalde3para8bits   IS

BEGIN
 process(ENTRADA, ENTRADA2)
  begin
	if(estender = '1') then
			SAIDA <= ("00000") & ENTRADA;		
	end if;
	if(estender = '0') then
			SAIDA <= ("0000") & ENTRADA2;		
	end if;
 end process;
END BEHAVIOR;
