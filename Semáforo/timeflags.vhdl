-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 18/11/2020

-- **********************************************************
--   	  Circuito: Timeflags, sistema de temporiza��o
--                 do controle de sem�foros:
--   	       vetor dezena  de 4 bits Entrada 1 
--   	       vetor unidade de 4 bits Entrada 2 
--   	       T60	               Sa�da   1  
--   	       T20                     Sa�da   2 
--   	       T6                      Sa�da   3 
--   	       T5                      Sa�da   4
-- ***********************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity (Entidade)
-- pinos de entrada e sa�da

entity timeflags is
  port( dezena  : in STD_LOGIC_VECTOR(3 downto 0);
        unidade : in STD_LOGIC_VECTOR(3 downto 0);
        T60     : out STD_LOGIC;
        T20     : out STD_LOGIC;
        T6      : out STD_LOGIC;
        T5      : out STD_LOGIC );
end timeflags;

-- Architecture (Arquitetura)
-- implementa��es do projeto

architecture timeflags_arch of timeflags is

-- a defini��o inicia por 
begin

-- T5 recebe 1 quando unidade for maior ou igual que 0101(5) 
-- ou quando dezena for maior ou igual que 0001(1)  
T5  <= '1' when ((unidade >= "0101") or (dezena >= "0001")) else '0'; 
-- T6 recebe 1 quando unidade for maior ou igual que 0110(6) 
-- ou quando dezena for maior ou igual que 0001(1)
T6  <= '1' when ((unidade >= "0110") or (dezena >= "0001")) else '0';
-- T20 recebe 1 quando dezena for maior ou igual que 0010(2) 
T20 <= '1' when (dezena  >= "0010") else '0';
-- T60 recebe 1 quando dezena for maior ou igual que 0110(6) 
T60 <= '1' when (dezena  >= "0110") else '0';

end timeflags_arch;
-- a defini��o termina por end
