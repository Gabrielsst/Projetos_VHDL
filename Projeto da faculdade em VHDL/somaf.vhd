-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 23/09/2020

-- ****************************************************
-- 	Circuito: Multiplexador com duas entradas:
-- 	      Vetor S1 de 2 bits Entrada 1
--			      V1 Entrada 2
-- 			      Z1 Saída 1
--			      Z2 Saída 2
-- ****************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity (Entidade)
-- pinos de entrada e saída

entity soma is port(
A, B, C : in  std_logic;
X, Y : out std_logic
);
end soma;

-- Architecture (Arquitetura)
-- implementações do projeto

architecture soma_arch of soma is

-- Declaração de signal auxiliar à função da arquitetura da entidade sistema.
SIGNAL sel : std_logic_vector (1 downto 0);

-- Declaração do componente mux4x1p1
-- Declaração do componente mux4x1p1, referente a sua arquitetura descrita no arquivo soma.vhd
component mux4x1p1 is port(
S1 : in  std_logic_vector(1 downto 0);
V1 : in  std_logic;
Z1 : out std_logic;
Z2 : out std_logic
);
end component;

-- a definição inicia por:
begin 
-- Uso de sinal auxiliar, para concatenar duas variáveis individuais em um vetor.
sel <= A & B;

-- Instância do componente mux4x1p1 e interconexão do componente à arquitetura
-- da entidade soma
S1: mux4x1p1 port map(sel, C, X, Y);

end soma_arch;

-- a definição termina por end.
