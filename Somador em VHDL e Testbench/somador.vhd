-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 07/09/2020

-- **************************************************************
-- Circuito: Somador Completo com 3 bits de entrada e 2 de sa�da:
--			    A    Entrada 1 
--			    B    Entrada 2
--			    Cin  Entrada 3
--			    S    Sa�da   1
--			    Cout Sa�da   2
-- **************************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity (Entidade)
-- pinos de entrada e sa�da

entity somador is port(
A    :in  std_logic;
B    :in  std_logic;
Cin  :in  std_logic;
S    :out std_logic;
Cout :out std_logic
);
end somador;

-- Architecture (Arquitetura)
-- implementa��es do projeto 

architecture soma of somador is 

-- a defini��o inicia por 
begin

-- S = f(A,B,Cin)

S <= A xor B xor Cin;

-- Cout = f(A,B,Cin)

Cout <= (A and B) or (A and Cin) or (B and Cin);

end soma;

-- a defini��o termina por end