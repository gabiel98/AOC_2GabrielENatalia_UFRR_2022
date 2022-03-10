-- Program Counter
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ProgramCounter IS
PORT
(
		clocksys :  IN  STD_LOGIC;  
		pcin :  IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
		pcout : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)		
	);
END ProgramCounter;

ARCHITECTURE behavior OF ProgramCounter IS
BEGIN
	PROCESS(clocksys)
		BEGIN
			IF rising_edge(clocksys) THEN
				pcout <= pcin;
			END IF;
	END PROCESS;
END behavior;