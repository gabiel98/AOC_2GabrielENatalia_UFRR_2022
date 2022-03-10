-- Unidade de Logica Aritmetica

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY ULA IS 
	PORT(a, b 				: IN std_logic_vector(7 DOWNTO 0);
		  ula_control  	: IN std_logic_vector(2 DOWNTO 0);
		  ula_result   	: OUT std_logic_vector(7 DOWNTO 0);
		  zero 				: OUT std_logic);
END ULA;

ARCHITECTURE Behavioral OF ULA IS
SIGNAL resultado : std_logic_vector(7 DOWNTO 0);
SIGNAL teste : std_logic_vector(15 DOWNTO 0);

BEGIN
	PROCESS(ula_control, a, b)
	BEGIN
		CASE ula_control IS
			WHEN "000" =>
				resultado <= a + b; -- add
			WHEN "001" =>
				resultado <= a - b; -- sub
			WHEN "100" =>
				teste <= a * b; -- mult
				resultado <= teste(7 DOWNTO 0);
			WHEN "010" =>
				resultado <= b; -- sw
			WHEN "011" =>
				resultado <= a + "00000001"; -- Soma 1
			WHEN "110" => 
				resultado <= b; -- li	
			WHEN "101" => 
				if(b > "11111111") then
					resultado <= x"11"; -- bne
				else 
					resultado <= x"00";
				end if;
			WHEN "111" =>
				IF(a<b) THEN
					resultado <= x"01";
				ELSE
					resultado <= x"00";
				END IF;
			WHEN OTHERS => resultado <= a + b; -- add
		END CASE;
	END PROCESS;
	zero <= '1' when resultado = X"00" ELSE '0';
	ula_result <= resultado;
END Behavioral;
			
			
			
			
			
			