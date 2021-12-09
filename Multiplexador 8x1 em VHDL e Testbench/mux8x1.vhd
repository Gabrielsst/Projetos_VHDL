-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 19/09/2020

-- ****************************************************
-- Circuito: Multiplexador com dois vetores de entrada:
-- 	Vetor S de 3 bits de entrada Entrada 1
--	Vetor D de 8 bits de entrada Entrada 2
-- 				   Y Saída
-- ****************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity (Entidade)
-- pinos de entrada e saída

entity mux8x1 is port(
S :in  std_logic_vector(2 downto 0);
D :in  std_logic_vector(7 downto 0);
Y :out std_logic
);
end mux8x1;

-- Architecture (Arquitetura)
-- implementações do projeto

architecture mux1 of mux8x1 is

-- a definição inicia por:
begin 

-- atribuindo D a Y, de acordo com o vetor seletor, neste caso o S,
-- usando atribuição condicional.
Y <= D(0) when (S = "000") else
     D(1) when (S = "001") else
     D(2) when (S = "010") else
     D(3) when (S = "011") else
     D(4) when (S = "100") else
     D(5) when (S = "101") else
     D(6) when (S = "110") else
     D(7) when (S = "111") else
     '0';

end mux1;

-- a definição termina por end