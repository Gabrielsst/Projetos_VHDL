-- Universidade de Bras�lia 
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 08/09/2020

-- ***********************************************************
-- Testbench para simula��o funcional do 
-- Circuito: Multiplexador com 6 bits de entrada e 1 de sa�da:
--		(Vetor S de 2 bits) Entrada 1 
--		(Vetor D de 4 bits) Entrada 2 
--				 Y  Sa�da   1 
-- ***********************************************************

-- ENTITY (Entidade)
-- testbench1 uma entidade sem pinos de entrada e sa�da

ENTITY testbench1 IS END;

-- Testbench para multiplexador1.vhd
-- Valida��o ass�crona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_multiplexador1 OF testbench1 IS

-- Declara��o do componente multiplexador1
-- Declara��o do componente multiplexador1, referente a sua arquitetura descrita no arquivo multiplexador1.vhd

component multiplexador1 port(

S    :in std_logic_vector(0 to 1);
D    :in std_logic_vector(0 to 3);
Y    :out std_logic
);
end component;

-- Sinais auxiliares para a interconex�o ao 
-- processo de est�mulo

signal i_1 : std_logic_vector(0 to 1);
signal i_2 : std_logic_vector(0 to 3);

-- Inst�ncia do componente multiplexador1 e interconex�o do componente do processo 
-- de est�mulo

Begin 

multiplexador2: multiplexador1 PORT MAP (S => i_1, D => i_2, Y => open);

-- Implement�ao do processo de est�mulo

estimulo: PROCESS
begin 

   wait for 5 ns; i_1(0) <= '0'; i_1(1) <= '0';

   i_2(0) <= '0'; i_2(1) <= '0'; i_2(2) <= '0'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '0'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns;
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '0'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '0'; i_2(2) <= '0'; i_2(3) <= '0';

   wait for 5 ns; i_1(1) <= '1';
----------------------------------------------------------------- Final do 1� conjunto de 16 linhas, no qual S(0) e S(1) � '0'
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '0'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns;
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '0'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '0'; i_2(2) <= '0'; i_2(3) <= '0';

   wait for 5 ns; i_1(0) <= '1';
----------------------------------------------------------------- Final do 2� conjunto de 16 linhas, no qual S(0) � '0', e S(1) � '1'
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '0'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns;
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '0'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '0'; i_2(2) <= '0'; i_2(3) <= '0';
   
   wait for 5 ns; i_1(1) <= '0';
----------------------------------------------------------------- Final do 3� conjunto de 16 linhas, no qual S(0) � '1', e S(1) � '1'
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '0'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns;
   i_2(0) <= '1'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '1'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '0';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '0'; i_2(2) <= '1'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '0'; i_2(2) <= '0'; i_2(3) <= '1';
   wait for 5 ns; 
   i_2(0) <= '0'; i_2(1) <= '0'; i_2(2) <= '0'; i_2(3) <= '0';
   
----------------------------------------------------------------- Final do 4� conjunto de 16 linhas, no qual S(0) � '1', e S(1) � '0'
   wait;

-- Final do processo de est�mulo
   end PROCESS estimulo;

-- Declara��o end para fechar a componente tb_multiplexador1
   end tb_multiplexador1;