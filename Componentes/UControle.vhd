-- Unidade de Controle
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY UControle IS
		  PORT(
		  opcode : IN std_logic_vector(2 DOWNTO 0);
		  funct : IN std_logic_vector (2 downto 0);
		  ula_op : OUT std_logic_vector(2 DOWNTO 0);
		  mem2reg, branch, readmem, writemem, ula2, writereg, estender, jump, writereg2 : OUT std_logic);
END UControle;


ARCHITECTURE Behavioral OF UControle IS
BEGIN
	PROCESS(opcode)
	BEGIN
		CASE opcode IS
			WHEN "000" =>  -- Instrução do tipo R
				mem2reg <= '0';
				ula_op <= funct;
				branch <= '0';
				readmem <= '0';
				writemem <= '0';
				ula2 <= '1';
				writereg <= '1';
				estender <= '1';
				jump <= '0';
				writereg2 <= '0';
			WHEN "111" => -- -- Instrução do tipo jump
				mem2reg <= '0';
				ula_op <= "111";
				branch <= '0';
				readmem <= '0';
				writemem <= '0';
				ula2 <= '0';
				writereg <= '0';
				estender <= '1';
				jump <= '1';
				writereg2 <= '0';
			WHEN "001" => -- -- Instrução do tipo lw
				mem2reg <= '1';
				ula_op <= "110";
				branch <= '0';
				readmem <= '1';
				writemem <= '0';
				ula2 <= '0';
				writereg <= '1';
				estender <= '1';
				jump <= '0';
				writereg2 <= '0';
			WHEN "110" => -- li
				mem2reg <= '0';
				ula_op <= "110";
				branch <= '0';
				readmem <= '0';
				writemem <= '0';
				ula2 <= '0';
				writereg <= '1';
				estender <= '1';
				jump <= '0';
				writereg2 <= '0';
			WHEN "010" => -- sw;
				mem2reg <= '0';
				ula_op <= "010";
				branch <= '0';
				readmem <= '0';
				writemem <= '1';
				ula2 <= '0';
				writereg <= '0';
				estender <= '0';
				jump <= '0';
				writereg2 <= '1';
			WHEN "011" => -- -- Instrução do tipo bne
				mem2reg <= '0';
				ula_op <= "101";
				branch <= '1';
				readmem <= '0';
				writemem <= '0';
				ula2 <= '1';
				writereg <= '0';
				estender <= '1';
				jump <= '0';
				writereg2 <= '0';
			WHEN OTHERS =>
				mem2reg <= '0';
				ula_op <= "111";
				branch <= '0';
				readmem <= '0';
				writemem <= '0';
				ula2 <= '0';
				writereg <= '0';
				estender <= '1';
				jump <= '0';
				writereg2 <= '0';
		END CASE;
	END PROCESS;
END Behavioral;
			
			
			