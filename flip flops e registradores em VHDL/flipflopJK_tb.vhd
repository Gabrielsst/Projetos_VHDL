-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 20/10/2020

-- **********************************************************************
-- 	  Circuito: Flip-Flop JK, gatilhado pela borda de subida:
-- 			     PR     Entrada 1 
-- 			     CLR    Entrada 2 
-- 			     CLK    Entrada 3 
-- 			     J      Entrada 4 
-- 			     K      Entrada 5 
--		     	     Q      Sa�da 1
-- **********************************************************************

-- ENTITY (Entidade)
-- testbench1 uma entidade sem pinos de entrada e sa�da

ENTITY testbench1 IS END;

-- Testbench para flipflopJK.vhd
-- Valida��o ass�ncrona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_flipflopJK OF testbench1 IS

-- Declara��o do componente flipflopJK
-- Declara��o do componente flipflopJK, referente a sua arquitetura descrita no arquivo flipflopJK.vhd

component flipflopJK is port(
PR, CLR, CLK, J, K    :in  std_logic;
Q    		      :out std_logic);
end component;

-- Per�odos de tempos para os clocks
constant T: time := 40 ns; -- per�odo para o clock 3
constant U: time := 20 ns; -- per�odo para o clock 2
constant V: time := 10 ns; -- per�odo para o clock 1

-- sinais auxiliares para a cria��o dos clocks
signal CLK_1, CLK_2, CLK_3 : std_logic;

-- sinais auxiliares para a interconex�o ao processo 
-- de est�mulo
signal PR_1, CLR_1 	   : std_logic;

-- Inst�ncia do componente flipflopJK e interconex�o do componente ao processo 
-- de est�mulo

Begin

flipflopJK1: flipflopJK PORT MAP(PR => PR_1, CLR => CLR_1, CLK => CLK_1,
J => CLK_2, K => CLK_3, Q => open);

clk3: process -- gerador do clock 3
begin 
CLK_3 <= '0', '1' after T/2, '0' after T; wait for T;
end process;

clk2: process -- gerador do clock 2
begin 
CLK_2 <= '0', '1' after U/2, '0' after U; wait for U;
end process;

clk1: process -- gerador do clock 1
begin 
CLK_1 <= '0', '1' after V/2, '0' after V; wait for V;
end process;

-- Implementa��o do processo de est�mulo

estimulo: process

begin

CLR_1 <= '0';
PR_1  <= '1';
wait for 40 ns;
PR_1  <= '0';
wait for 40 ns;
CLR_1 <= '1';
wait;

-- Final do processo de est�mulo
end  process estimulo;

-- Final do Testbench
end tb_flipflopJK;
