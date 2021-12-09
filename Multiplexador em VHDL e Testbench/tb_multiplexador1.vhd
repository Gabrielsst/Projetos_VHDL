-- Universidade de Brasília 
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 08/09/2020

-- ***********************************************************
-- Testbench para simulação funcional do 
-- Circuito: Multiplexador com 6 bits de entrada e 1 de saída:
--		(Vetor S de 2 bits) Entrada 1 
--		(Vetor D de 4 bits) Entrada 2 
--				 Y  Saída   1 
-- ***********************************************************

-- ENTITY (Entidade)
-- testbench1 uma entidade sem pinos de entrada e saída

ENTITY testbench1 IS END;

-- Testbench para multiplexador1.vhd
-- Validação assícrona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_multiplexador1 OF testbench1 IS

-- Declaração do componente multiplexador1
-- Declaração do componente multiplexador1, referente a sua arquitetura descrita no arquivo multiplexador1.vhd

component multiplexador1 port(

S    :in std_logic_vector(0 to 1);
D    :in std_logic_vector(0 to 3);
Y    :out std_logic
);
end component;

-- Sinais auxiliares para a interconexão ao 
-- processo de estímulo

signal i_1 : std_logic_vector(0 to 1);
signal i_2 : std_logic_vector(0 to 3);

-- Instância do componente multiplexador1 e interconexão do componente do processo 
-- de estímulo

Begin 

multiplexador2: multiplexador1 PORT MAP (S => i_1, D => i_2, Y => open);

-- Implementçao do processo de estímulo

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
----------------------------------------------------------------- Final do 1° conjunto de 16 linhas, no qual S(0) e S(1) é '0'
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
----------------------------------------------------------------- Final do 2° conjunto de 16 linhas, no qual S(0) é '0', e S(1) é '1'
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
----------------------------------------------------------------- Final do 3° conjunto de 16 linhas, no qual S(0) é '1', e S(1) é '1'
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
   
----------------------------------------------------------------- Final do 4° conjunto de 16 linhas, no qual S(0) é '1', e S(1) é '0'
   wait;

-- Final do processo de estímulo
   end PROCESS estimulo;

-- Declaração end para fechar a componente tb_multiplexador1
   end tb_multiplexador1;