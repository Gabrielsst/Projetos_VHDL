-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 06/10/2020

-- ***********************************************************************
-- Circuito: Somador Completo com 2 vetores de entrada e 1 vetor de sa�da:
--		      Vetor A de 4 bits     Entrada 1 
--		      Vetor B de 4 bits     Entrada 2
--		      Vetor S de 5 bits     Sa�da 1
-- ***********************************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

-- Entity (Entidade)
-- pinos de entrada e sa�da

entity somador_gm is port(
A    :in  std_logic_vector(3 downto 0);
B    :in  std_logic_vector(3 downto 0);
S    :out std_logic_vector(4 downto 0)
);
end somador_gm;

-- Architecture (Arquitetura)
-- implementa��es do projeto 

architecture soma of somador_gm is 

-- a defini��o inicia por 
begin

-- a fun��o recebe a soma dos vetores A e B, com zeros concatenados aos dois 
-- para que n�o ocorra overflow
S <= ('0' & unsigned(A)) + ('0' & unsigned(B));

end soma;

-- a defini��o termina por end
