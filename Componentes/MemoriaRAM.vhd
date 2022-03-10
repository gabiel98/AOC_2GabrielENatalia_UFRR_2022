-- Memoria RAM
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY MemoriaRAM IS
	port(entradaDATA : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  saidaDATA   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		  address     : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  writememory, readmemory, clocksys   : IN STD_LOGIC);

END MemoriaRAM;

ARCHITECTURE test OF MemoriaRAM IS

	TYPE memory1 IS ARRAY (0 TO 1) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL memoria : memory1:= (OTHERS => "00000000");
BEGIN
	PROCESS(clocksys)
		BEGIN
			IF(rising_edge(clocksys)) THEN
				IF(writememory = '1') THEN
					memoria(to_integer(unsigned(address))) <= entradaDATA;
				END IF;
				IF (readmemory = '1') THEN
					saidaDATA <= memoria(to_integer(unsigned(address)));
				END IF;
			END IF;
	END PROCESS;
END test;

