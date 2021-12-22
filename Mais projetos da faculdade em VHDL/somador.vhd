-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 06/10/2020

-- ***********************************************************************
-- Circuito: Somador Completo com 2 vetores de entrada e 1 vetor de saída:
--		      Vetor A de 4 bits     Entrada 1 
--		      Vetor B de 4 bits     Entrada 2
--		      Vetor S de 5 bits     Saída 1
-- ***********************************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity (Entidade)
-- pinos de entrada e saída

entity somador_dut is port(
A    :in  std_logic_vector(3 downto 0);
B    :in  std_logic_vector(3 downto 0);
S    :out std_logic_vector(4 downto 0)
);
end somador_dut;

-- Architecture (Arquitetura)
-- implementações do projeto 

architecture soma of somador_dut is 

-- Criação de sinais intermediários para auxíliar 
-- na implementação do funcionamento do circuito 

signal S1, S2, S3, S4 		      : std_logic; 
signal Cin, Cout, Cout1, Cout2, Cout3 : std_logic;

-- a definição inicia por 
begin

-- O Cin ou "Carry in", recebe zero inicialmente
Cin <= '0';

-- A função S1 é um somador completo, com funcionamento similar ao de um somador parcial
S1 <= A(0) xor B(0) xor Cin  ;

-- As funções adiante recebem o Cout, pois é o "vai um" das anteriores
S2 <= A(1) xor B(1) xor Cout ;
S3 <= A(2) xor B(2) xor Cout1;
S4 <= A(3) xor B(3) xor Cout2;

-- As funções Cout abaixo, servem para encontrar o "vai um" de cada função acima
Cout  <= (A(0) and B(0)) or (A(0) and Cin  ) or (B(0) and Cin  );
Cout1 <= (A(1) and B(1)) or (A(1) and Cout ) or (B(1) and Cout );
Cout2 <= (A(2) and B(2)) or (A(2) and Cout1) or (B(2) and Cout1);
Cout3 <= (A(3) and B(3)) or (A(3) and Cout2) or (B(3) and Cout2);

-- Aqui as funções Cout3, S4, S3, S2 e S1 são concatenadas e levadas para a saída da entidade
S <= Cout3 & S4 & S3 & S2 & S1;

end soma;

-- a definição termina por end