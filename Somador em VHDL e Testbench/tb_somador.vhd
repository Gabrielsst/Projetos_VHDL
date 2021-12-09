-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 07/09/2020

-- **************************************************************
-- Circuito: Somador Completo com 3 bits de entrada e 2 de saída:
--			    A    Entrada 1 
--			    B    Entrada 2
--			    Cin  Entrada 3
--			    S    Saída   1
--			    Cout Saída   2
-- **************************************************************

-- ENTITY (Entidade)
-- testbench1 uma entidade sem pinos de entrada e saída

ENTITY testbench1 IS END;

-- Testbench para somador.vhd
-- Validação assíncrona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_somador OF testbench1 IS

-- Declaração do componente somador

-- Declaração do componente somador, referente a sua arquitetura descrita no arquivo somador.vhd

component somador

port(
A    :in std_logic;
B    :in std_logic;
Cin  :in std_logic;
S    :out std_logic;
Cout :out std_logic
);
end component;

-- Sinais auxiliares para a interconexão ao
-- processo de estímulo

signal i_1 : std_logic;
signal i_2 : std_logic;
signal i_3 : std_logic;

-- Instância do componente somador e interconexão do componente ao processo
-- de estímulo

Begin

somador1: somador PORT MAP (A => i_1, B => i_2, Cin => i_3, S => open, Cout => open);

-- Implementação do processo de estímulo

estimulo: PROCESS

begin

wait for 5 ns; i_1 <= '0'; i_2 <= '0'; i_3 <= '0';
wait for 5 ns; i_1 <= '1';
wait for 5 ns; i_2 <= '1';
wait for 5 ns; i_1 <= '0';
wait for 5 ns; i_3 <= '1';
wait for 5 ns; i_1 <= '1';
wait for 5 ns; i_2 <= '0';
wait for 5 ns; i_1 <= '0';
wait;
end PROCESS estimulo;
end tb_somador;
