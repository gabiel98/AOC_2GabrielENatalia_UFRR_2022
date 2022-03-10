--Porta Lógica And
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY PortaAND IS
	Port(
		A, B : IN std_logic;
		R : OUT std_logic);
END PortaAND;

ARCHITECTURE GateAnd of PortaAND IS

BEGIN
		R <= A and B;
END GateAnd;