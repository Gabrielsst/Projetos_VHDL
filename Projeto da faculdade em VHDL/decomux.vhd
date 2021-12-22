-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 23/09/2020

-- ************************************************************
-- Circuito: Multiplexador com componentes, 1 decodificador4x16 
-- 	 e 1 multiplexador 8x1, de 7 entradas e 1 saída:
-- 			  A Entrada 1
--			  B Entrada 2
-- 			  C Entrada 3
--			  D Entrada 4
-- 			  E Entrada 5
--			  F Entrada 6
-- 			  G Entrada 7
-- 			  S Saída
-- *************************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity (Entidade)
-- pinos de entrada e saída

entity sistema is port(
A, B, C, D, E, F, G : in  std_logic;
		  S : out std_logic
);
end sistema;

-- Architecture (Arquitetura)
-- implementações do projeto

architecture sistema_arch of sistema is

-- Declaração do componente deco4x16
-- Declaração do componente deco4x16, referente a sua arquitetura descrita no arquivo deco4x16v2.vhd
component deco4x16 is port(
A1 : in  std_logic_vector(3 downto 0);
Y1 : out std_logic_vector(15 downto 0)
);
end component;

-- Declaração do componente mux8x1
-- Declaração do componente mux8x1, referente a sua arquitetura descrita no arquivo mux8x1v2.vhd
component mux8x1 is port(
S1 :in  std_logic_vector(2 downto 0);
D1 :in  std_logic_vector(7 downto 0);
Y2 :out std_logic
);
end component;

-- Sinais auxiliares para a interconexão à
-- arquitetura da entidade sistema
signal sel 	   : std_logic_vector(2  downto 0);
signal var         : std_logic_vector(3  downto 0);
signal barramento1 : std_logic_vector(15 downto 0);
signal barramento2 : std_logic_vector(7  downto 0);

begin 

-- Concatenação de variáveis para criação de dois vetores, 
-- o var de 4 bits e o sel de 3 bits
var <= A & B & C & D;
sel <= E & F & G;

-- Instância do componente deco4x16 e interconexão do componente à 
-- arquitetura da entidade sistema
R1: deco4x16 port map(var, barramento1);

-- Prenchendo a variável barramento2, que será enviada para o mux,
-- Utilizando valores pré definidos e valores gerados pelo  
-- decodificador, que se encontram na variável barramento1.
barramento2(0) <= '0';
barramento2(1) <= barramento1(0) or barramento1(15);
barramento2(2) <= barramento1(7);
barramento2(3) <= '1';
barramento2(4) <= barramento1(9) or barramento1(15);
barramento2(5) <= '0';
barramento2(6) <= barramento1(10) or barramento1(11);
barramento2(7) <= '1';

-- Instância do componente mux8x1 e interconexão do componente à 
-- arquitetura da entidade sistema
R2: mux8x1 port map(sel, barramento2, S);

end sistema_arch;

-- a definição termina por end
