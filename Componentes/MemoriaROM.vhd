-- MemoriaROM
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY MemoriaROM IS

	PORT(address : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  saida : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END MemoriaROM;

ARCHITECTURE teste OF MemoriaROM IS
	TYPE memo_arranjo IS ARRAY (NATURAL RANGE <>) OF 	std_logic_vector(7 DOWNTO 0);
	CONSTANT dados: memo_arranjo (0 To 8) :=
	--(0 => "01000000", -- ADDI S0 0
  -- 1 => "00010000", -- SW S0
  -- 2 => "01000001", -- ADDI S0 1
  -- 3 => "01000101", -- ADDI S1 1
  -- 4 => "00001100", -- LW S3 00
  -- 5 => "00101101", -- ADD S3 S1
  --- 6 => "00100100", -- ADD S2 S1
  -- 7 => "00000000", -- LW S0 00
  -- 8 => "00100011", -- ADD S0 S3
   
   -- OTHERS => "11111111");
	



	(0 => "11000000", -- Coloca 0
	 1 => "11010001", -- Coloca 1 
	 2 => "00001000", -- ADD
	 3 => "00010000", -- ADD
	 4 => "01101010", -- bne;
		others => "10000000");
	
--Teste add e addi
--	(0 => "00010001", -- ADDI S0 0
--  1 => "00010010", -- SW S0
--  2 => "01000111", -- ADDI S0 1
-- 	 others => "10000000");
   
-- Teste addi sub e subi
  -- 0 =>"00010011", -- addi s0 3--
--	1 =>"00010101",--  addi s1 1
--	2 =>"00110001",-- subi s0 1
--	3 =>"00100001",--  subi s0 s1

-- Teste LI

--( 0 =>"01100010", 
--1 =>"00010001",
	
--others => "11111111");
	
BEGIN
	saida <= dados(conv_integer(unsigned(address)));
END teste;


