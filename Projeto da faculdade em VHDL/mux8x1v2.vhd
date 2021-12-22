-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 23/09/2020

-- ****************************************************
-- Circuito: Multiplexador com dois vetores de entrada:
-- 	Vetor S1 de 3 bits de entrada Entrada 1
--	Vetor D1 de 8 bits de entrada Entrada 2
-- 				   Y2 Sa�da
-- ****************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity (Entidade)
-- pinos de entrada e sa�da

entity mux8x1 is port(
S1 :in  std_logic_vector(2 downto 0);
D1 :in  std_logic_vector(7 downto 0);
Y2 :out std_logic
);
end mux8x1;

-- Architecture (Arquitetura)
-- implementa��es do projeto

architecture mux1 of mux8x1 is

-- a defini��o inicia por:
begin 

-- atribuindo D1 a Y2, de acordo com o vetor seletor, neste caso o S1,
-- usando atribui��o condicional.
Y2 <= D1(0) when (S1 = "000") else
      D1(1) when (S1 = "001") else
      D1(2) when (S1 = "010") else
      D1(3) when (S1 = "011") else
      D1(4) when (S1 = "100") else
      D1(5) when (S1 = "101") else
      D1(6) when (S1 = "110") else
      D1(7) when (S1 = "111") else
      '0';

end mux1;

-- a defini��o termina por end
