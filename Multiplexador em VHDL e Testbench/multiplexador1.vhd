-- Universidade de Bras�lia 
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 08/09/2020

-- ***********************************************************
-- Circuito: Multiplexador com 6 bits de entrada e 1 de sa�da:
--		(Vetor S de 2 bits) Entrada 1 
--		(Vetor D de 4 bits) Entrada 2 
--				 Y  Sa�da   1 
-- ***********************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity (Entidade)
-- pinos de entrada e sa�da 

entity multiplexador1 is port(
S    :in std_logic_vector(0 to 1);
D    :in std_logic_vector(0 to 3);
Y    :out std_logic
);
end multiplexador1;

-- Architecture (Arquitetura)
-- implementa��es do projeto

architecture multi of multiplexador1 is 

-- a defini��o inicia por 
begin 

-- Y = f(S(0 to 1),D(0 to 3))
Y <= (D(0) and (not S(1)) and (not S(0))) or 
     (D(1) and (not S(1)) and (S(0))) or 
     (D(2) and S(1) and (not S(0))) or 
     (D(3) and S(1) and S(0));

end multi;

-- a defini��o termina por end