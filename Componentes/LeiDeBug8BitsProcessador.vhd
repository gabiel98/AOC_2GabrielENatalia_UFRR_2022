-- LeiDeBug8BitsProcessador
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY LeiDeBug8BitsProcessador IS
		PORT(
		clock 					: IN  std_logic; 
		--
		out_pc 					: OUT std_logic_vector(7 DOWNTO 0);
		-- 
		out_extensordesinal 	: OUT std_logic_vector(7 DOWNTO 0);
		--
		ENOIS 					: OUT std_logic_vector(7 DOWNTO 0);
		enterrom 				: OUT std_logic_vector(7 DOWNTO 0);
		out_opcode 				: OUT std_logic_vector(2 DOWNTO 0);
		QUEVOA 						: OUT std_logic_vector(7 DOWNTO 0);
		BRUXAO 						: OUT std_logic_vector(7 DOWNTO 0);
		--
		out_mux1 		: OUT std_logic_vector(7 DOWNTO 0);
		out_mux2 		: OUT std_logic_vector(7 DOWNTO 0);
		out_mux3 		: OUT std_logic_vector(7 DOWNTO 0);
		out_mux4 		: OUT std_logic_vector(7 DOWNTO 0);
		
		--
		out_branch 				: OUT std_logic;
		out_readmem 			: OUT std_logic;
		out_writemem 			: OUT std_logic;
		out_ula2 				: OUT std_logic;
		out_writereg 			: OUT std_logic;
		out_mem2reg 			: OUT std_logic;
		out_ulaop 				: OUT std_logic_vector(2 DOWNTO 0);
		--
		out_ram 					: OUT std_logic_vector(7 DOWNTO 0);
		--
		out_zero 				: OUT std_logic;
		out_ula_result 		: OUT std_logic_vector(7 DOWNTO 0));
	
	END LeiDeBug8BitsProcessador;
	
----------------------------------------------------------------------------------------
-- -- -- -- -- -- -- -- -- -- -- --  COMPONENTES -- -- -- -- -- -- -- -- -- -- -- -- -
----------------------------------------------------------------------------------------

ARCHITECTURE behavior OF LeiDeBug8BitsProcessador IS

	COMPONENT ProgramCounter IS
		PORT(
		clocksys 				: IN  STD_LOGIC;  
		pcin 						: IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
		pcout 					: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
	END COMPONENT;
	

	COMPONENT SomadorPC IS
		PORT(
		SomaIn 					: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Soma2						: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		SomaOut 					: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT MemoriaROM IS
		PORT(
		address 					: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		saida 					: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT ExtensordeSinalde3para8bits IS
		PORT(
		ENTRADA 					: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		ENTRADA2					: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		SAIDA   					: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		estender					: IN STD_LOGIC);
	
	END COMPONENT;
	
	COMPONENT Multiplexador IS
		PORT(
		A, B 						: IN std_logic_vector(7 DOWNTO 0);
		S1							: IN std_logic;
		R 							: OUT std_logic_vector(7 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT Registradores IS
		PORT(
		ClockSys					: IN std_logic;
		RegWrite					: IN std_logic;
		RegA						: OUT std_logic_vector (7 downto 0);
		RegB						: OUT std_logic_vector (7 downto 0); 
		Data						: IN std_logic_vector  (7 downto 0); -- Write Back
		ReadReg1					: IN std_logic_vector (0 DOWNTO 0);
		ReadReg2					: IN std_logic_vector (0 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT ULA IS 
		PORT(
		a, b 						: IN std_logic_vector(7 DOWNTO 0);
		ula_control  				: IN std_logic_vector(2 DOWNTO 0);
		ula_result				: OUT std_logic_vector(7 DOWNTO 0);
		zero 						: OUT std_logic);
	END COMPONENT;
	
	COMPONENT MemoriaRAM IS
		PORT(
		entradaDATA 			: IN std_logic_vector(7 DOWNTO 0);
		saidaDATA   			: OUT std_logic_vector(7 DOWNTO 0);
		address     			: IN std_logic_vector(7 DOWNTO 0);
		writememory				: IN STD_LOGIC;
		readmemory 				: IN STD_LOGIC;
		clocksys					: IN STD_LOGIC);
	END COMPONENT;
	
	COMPONENT PortaAND IS
		PORT(
		A, B 	: IN std_logic;
		R 		: OUT std_logic);
	END COMPONENT;
	
	COMPONENT UControle IS
		PORT(
		opcode 					: IN std_logic_vector(2 DOWNTO 0);
		funct 					: IN std_logic_vector (2 downto 0);
		ula_op 					: OUT std_logic_vector(2 DOWNTO 0);
		mem2reg					: OUT std_logic;		
		branch 					: OUT std_logic;
		readmem 					: OUT std_logic;
		writemem 				: OUT std_logic;
		ula2						: OUT std_logic;
		writereg 				: OUT std_logic;
		estender					: OUT std_logic;
		jump 					: OUT std_logic;
		writereg2 				: OUT std_logic);
	END COMPONENT;
	
----------------------------------------------------------------------------------------
-- -- -- -- -- -- -- -- -- -- -- SINAIS DOS COMPONENTES -- -- -- -- -- -- -- -- -- -- -- 
----------------------------------------------------------------------------------------
		 
-- SINAIS PC

	SIGNAL pc_out 				   : std_logic_vector(7 DOWNTO 0);
	SIGNAL in_pc  				   : std_logic_vector(7 DOWNTO 0);
	SIGNAL addpcOUT 			   : std_logic_vector(7 DOWNTO 0);
	SIGNAL addpcOUT2 		   : std_logic_vector(7 DOWNTO 0);
	--OK
	
	
-- SINAIS ROM
	SIGNAL romOUT 			   : std_logic_vector(7 DOWNTO 0);
	
	--OK

--ESTENSOR DE SINAIS
	SIGNAL extensordesinal_out : std_logic_vector(7 DOWNTO 0);
	--OK

-- SINAIS MULTIPLEXADORES  

	SIGNAL muxOUT1 	: std_logic_vector(7 DOWNTO 0);
	SIGNAL muxOUT2 	: std_logic_vector(7 DOWNTO 0);
	SIGNAL muxOUT3 	: std_logic_vector(7 DOWNTO 0);
	SIGNAL muxOUT5 	: std_logic_vector(7 DOWNTO 0);
		--OK
	
	--SINAIS BANCO DE REGISTRADORES    PAREI AQUI
	
	SIGNAL regA_out 			: std_logic_vector(7 DOWNTO 0);
	SIGNAL regB_out 			: std_logic_vector(7 DOWNTO 0);
	  --OK
	
	--SINAIS ULA
	SIGNAL ulaOUT 			: std_logic_vector(7 DOWNTO 0);
	SIGNAL ulazero_out 		: std_logic;
		  --OK

	--SINAIS RAM
	SIGNAL ram_out 			: std_logic_vector(7 DOWNTO 0);
	--   OK
	
	-- SINAIS PORTA AND 
	SIGNAL AAND_out 			: std_logic;
	
	-- SINAIS UNIDADE DE CONTROLE
	SIGNAL branch_out			: std_logic;
	SIGNAL readmemOUT 			: std_logic;		
	SIGNAL writememOUT 				: std_logic;
	SIGNAL ula2OUT 			: std_logic;
	SIGNAL writereg_out		: std_logic;
	SIGNAL mem2regOUT			: std_logic;
	SIGNAL ula_opOUT 			: std_logic_vector(2 DOWNTO 0);
	SIGNAL estender_out		: std_logic;
	SIGNAL jumpOUT 				: std_logic;
	SIGNAL writereg2OUT 			: std_logic;
BEGIN


		  
		  
----------------------------------------------------------------------------------------
-- -- -- -- -- -- -- -- -- -- -- -- -- --  PORT MAPS -- -- -- -- -- -- -- -- -- -- --  
----------------------------------------------------------------------------------------
 -- PC
 Program_Counter : ProgramCounter PORT MAP(
								clocksys  => clock,
								pcin  => in_pc,
								pcout => pc_out
							);
--Somador
							
add1					: SomadorPC	PORT MAP(
								SomaIn => pc_out,
								Soma2 => "00000001",
								SomaOut => addpcOUT
								);
--MemoriaROM				
memory_rom			: MemoriaROM PORT MAP(
						    address => pc_out,
							 saida => romOUT);
--Extensor de sinal
extensordesinal 	: ExtensordeSinalde3para8bits PORT MAP(
							 ENTRADA => romOUT(2 DOWNTO 0),
							 ENTRADA2 => romOUT(3 DOWNTO 0),
							 SAIDA => extensordesinal_out,
							 estender => estender_out);
	
--Registradores				  
registrers 		: Registradores PORT MAP(
									ClockSys => clock,
									RegWrite => writereg_out,
									RegA => regA_out,
									RegB => regB_out,
									Data => muxOUT3,
									ReadReg1 => romOUT(4 DOWNTO 4),
									ReadReg2 => romOUT(3 DOWNTO 3));
--Multiplexadores									
										
	multiplex1 			: Multiplexador PORT MAP(
								A => extensordesinal_out,
								B => addpcOUT,
								S1 => AAND_out,
								R => muxOUT1);
							
	multiplex2 			: Multiplexador PORT MAP(
								A => regB_out,
								B => extensordesinal_out,
								S1 => ula2OUT, 
								R => muxOUT2);
							
	multiplex3 			: Multiplexador PORT MAP(
								A => ram_out,
								B => ulaOUT,
								S1 => mem2regOUT,
								R => muxOUT3);
								
	multiplex4 			:Multiplexador PORT MAP(
								A => "000" & romOUT(4 DOWNTO 0),
								B => muxOUT1,
								S1 => jumpOUT,
								R => in_pc);
							
	multiplex5 			:Multiplexador PORT MAP(
								A => regA_out,
								B => regB_out,
								S1 => writereg2OUT,
								R => muxOUT5);
								
--Unidade de Logica Aritmética							
	UninLA 					:ULA PORT MAP(
							a => regA_out,
							b => muxOUT1,
							ula_control => ula_opOUT,
							ula_result => ulaOUT,
							zero => ulazero_out);
				
--Memoria RAM
	ram_mem 				: MemoriaRAM PORT MAP(
							entradaDATA => muxOUT5,
							address => ulaOUT,
							readmemory => readmemOUT, 
							writememory => writememOUT, 
							clocksys => clock,
							saidaDATA => ram_out);
				
-- Porta AND			  
	porta_and 		:  PortaAND PORT MAP(
							A => branch_out,
							B => ulazero_out,
							R => AAND_out);
-- Unidade de Controle						
	UC 				:  UControle PORT MAP(
							opcode => romOUT(7 DOWNTO 5),
							funct => romOUT(2 DOWNTO 0),
							mem2reg => mem2regOUT, 
							branch => branch_out, 
							readmem => readmemOUT, 
							writemem => writememOUT, 
							ula2 => ula2OUT, 
							writereg => writereg_out,
							ula_op => ula_opOUT,
							estender => estender_out,
							jump => jumpOUT,
							writereg2 => writereg2OUT);
							
							--ok
----------------------------------------------------------------------------------------
-- -- -- -- -- -- -- -- -- -- -- -- --  Trilhas -- -- -- -- -- -- -- -- -- -- -- -- -- 
---------------------------------------------------------------------------------------- 
	out_pc <= in_pc;
	ENOIS <= regA_out;
	QUEVOA <= regB_out;
-- Trilha extensor de sinal	
	out_extensordesinal <= extensordesinal_out;
-- Trilha ROM
	BRUXAO <= romOUT;
	out_opcode <= romOUT(7 DOWNTO 5);
-- Trilha Multiplexadores
	out_mux1 <= in_pc;
	out_mux2 <= muxOUT2;
	out_mux3 <= muxOUT3;
	out_mux4 <= muxOUT5;
-- Trilha UUC
	out_branch <= branch_out;
-- Trilha RAM	
	out_ram <= ram_out;
-- Trilha ULA							
	out_ula_result <= ulaOUT;
	out_zero <= ulazero_out;
	
END behavior;
