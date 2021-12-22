-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 20/10/2020

-- **********************************************************************
--     Circuito: registrador de deslocamento bidirecional de 4 bits:
--		     CLK    		   Entrada 1 
--		     RST   		   Entrada 2 
--		     LD    		   Entrada 3
--		     DIR   		   Entrada 4
--		     L     		   Entrada 5
--		     R     		   Entrada 6
--		     Vetor D de 4 bits     Entrada 7
--		     Vetor Q de 4 bits     Saída 1
-- **********************************************************************

-- ENTITY (Entidade)
-- testbench1 uma entidade sem pinos de entrada e saída

ENTITY testbench1 IS END;

-- Testbench para regs4.vhd
-- Validação assíncrona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_regis OF testbench1 IS

-- Declaração do componente regis
-- Declaração do componente regis, referente a sua arquitetura descrita no arquivo regs4.vhd

component regis is port(
CLK, RST, LD, DIR, L, R    :in  std_logic;
D			   :in  std_logic_vector(3 downto 0);
Q    		      	   :out std_logic_vector(3 downto 0)
);
end component;

-- Período de tempo para o clock
constant V: time := 10 ns;

-- sinais auxiliares para a interconexão ao force: process

signal ENTRADAS : std_logic_vector(4 downto 0) := "00000";
signal CLK_1 	: std_logic;
signal D_1 	: std_logic_vector(3 downto 0) := "0000";

-- Instância do componente regis e interconexão do componente ao force: process
-- e ao clock

Begin

regis1: regis PORT MAP(D => D_1, RST => ENTRADAS(4), LD => ENTRADAS(3), CLK => CLK_1,
DIR => ENTRADAS(2), L => ENTRADAS(1), R => ENTRADAS(0), Q => open);

clk1: process -- gerador do clock 1
begin 
CLK_1 <= '0', '1' after V/2, '0' after V; wait for V;
end process;

-- Implementação do force: process

force: process

-- criação da variável contbin para auxiliar na criação de 32 possibilidades 
-- com o clock
variable contbin : std_logic_vector(4 downto 0);

-- inicio do force: process
begin 

-- setando o contbin como "00000"
contbin := "00000";

-- uso da estrutura for para tornar o processo de encontrar as 32 possibilidades
-- de entrada menos manual
	for i in 1 to 32 loop
		ENTRADAS(0) <= contbin(0);
		ENTRADAS(1) <= contbin(1);
		ENTRADAS(2) <= contbin(2);
		ENTRADAS(3) <= contbin(3);
		ENTRADAS(4) <= contbin(4);
-- usando wait para a função entender que há novos valores e trocá-los.
	wait for 10 ns;

-- para cada loop, o contbin tem o valor 1 somado ao seu vetor
	contbin := contbin + 1;
	
-- fim do loop
	end loop;

-- fim do force: process
end process;

-- Final do Testbench
end tb_regis;
