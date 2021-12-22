-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 23/09/2020

-- ****************************************************
-- 	Circuito: Multiplexador com duas entradas:
-- 	      Vetor S1 de 2 bits Entrada 1
--			      V1 Entrada 2
-- 			      Z1 Sa�da 1
--			      Z2 Sa�da 2
-- ****************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity (Entidade)
-- pinos de entrada e sa�da

entity mux4x1p1 is port(
S1 : in  std_logic_vector(1 downto 0);
V1 : in  std_logic;
Z1 : out std_logic;
Z2 : out std_logic
);
end mux4x1p1;

-- Architecture (Arquitetura)
-- implementa��es do projeto

architecture mux1 of mux4x1p1 is

-- a defini��o inicia por:
begin 

-- Uso de condicional para atribuir a Z1 o valor para o qual a vari�vel S1 � satisfeita;
Z1 <=  '0'      when (S1 = "00") else
       V1       when (S1 = "01") else
       not V1   when (S1 = "10") else
       '1'      when (S1 = "11") else
       '0';

-- Uso de condicional para atribuir a Z2 o valor para o qual a vari�vel S1 � satisfeita;
Z2 <=  '1'     when (S1 = "00") else
       not V1  when (S1 = "01") else
       '0'     when (S1 = "10") else
       V1      when (S1 = "11") else
       '0';

end mux1;

-- a defini��o termina por end.