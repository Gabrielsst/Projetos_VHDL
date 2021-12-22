-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 23/09/2020

-- ************************************************
-- Circuito: Decodificador de 1 entrada com 4 bits:
-- 	     vetor A1 de 4 bits  Entrada
--           vetor Y1 de 16 bits Saída
-- ************************************************ 

-- Package (Pacote)
-- constantes e bibliotecas 

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity (Entidade)
-- pinos de entrada e saída

entity deco4x16 is port(
A1 : in  std_logic_vector(3 downto 0);
Y1 : out std_logic_vector(15 downto 0)
);
end deco4x16;

-- Architecture (Arquitetura)
-- implementações do projeto

architecture deco1 of deco4x16 is 

-- a definição inicia por 
begin

-- Atribuindo valores ao vetor Y1, usando como seletor neste caso o A1, por 
-- meio de atribuição seletiva 

with A1 select 
Y1 <= "0000000000000001" when "0000",
      "0000000000000010" when "0001",
      "0000000000000100" when "0010",
      "0000000000001000" when "0011",
      "0000000000010000" when "0100",
      "0000000000100000" when "0101",
      "0000000001000000" when "0110",
      "0000000010000000" when "0111",
      "0000000100000000" when "1000",
      "0000001000000000" when "1001",
      "0000010000000000" when "1010",
      "0000100000000000" when "1011",
      "0001000000000000" when "1100",     
      "0010000000000000" when "1101",
      "0100000000000000" when "1110",
      "1000000000000000" when "1111",
      "0000000000000000" when others;
end deco1;

-- a definição termina por end
