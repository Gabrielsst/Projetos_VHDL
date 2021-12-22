-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 23/09/2020

-- ***********************************************
-- Testbench para simula��o funcional do Circuito:
-- 	  Multiplexador com duas entradas:
-- 	    Vetor S1 de 2 bits Entrada 1
--		            V1 Entrada 2
-- 			    Z1 Sa�da 1
--			    Z2 Sa�da 2
-- *********************************************** 

-- ENTITY (Entidade)
-- testbench1  uma entidade sem pinos de entrada e sa�da 

ENTITY testbench1 IS END;

-- Testbench para somaf.vhd
-- Valida��o ass�ncrona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_soma OF testbench1 IS 

-- Declara��o do componente soma
-- Declara��o do componente soma, referente a sua arquitetura descrita no arquivo somaf.vhd

component soma port(
A, B, C : in  std_logic;
X, Y : out std_logic
);
end component;

-- Per�odo de tempo para o clock 1
constant T: time := 5 ns;

-- Sinais auxiliares para a interconex�o ao
-- processo de est�mulo

signal i_1, i_2 : std_logic;
signal clk_1 : std_logic;

-- Inst�ncia do componente soma e interconex�o do componente ao processo
-- de est�mulo

Begin

soma2: soma PORT MAP (A => i_1, B => i_2, C => clk_1, X => open, Y => open);

-- criar 1 clock para a vari�vel C;

clk1: process -- gerador do clock 1
begin
clk_1 <= '0','1' after T/2, '0' after T; wait for T; 
end process;

-- Implementa��o do processo de est�mulo

estimulo: process
begin
i_1 <= '0'; 
i_2 <= '0';
wait for 5 ns; 
i_2 <= '1';
wait for 5 ns; 
i_1 <= '1';
wait for 5 ns;
i_2 <= '0';
wait;

-- Final do processo de est�mulo

end  process  estimulo;

-- Final do testbench

end tb_soma;
