-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 18/11/2020

-- **********************************************************
--   		Circuito: Contador de Módulo 100:
--   		clock  	                Entrada 1 
--   		reset   	        Entrada 2 
--   		enable	                Entrada 3  
--   		load	                Entrada 4 
--   		vetor dezload de 4 bits Entrada 5 
--   		vetor uniload de 4 bits Entrada 6
--   		vetor dezena  de 4 bits Saída   1 
--   		vetor unidade de 4 bits Saída   2 
-- ***********************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity (Entidade)
-- pinos de entrada e saída

entity contador100 is
  port( clock   : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        enable  : in  STD_LOGIC;
        load    : in  STD_LOGIC;
        dezload : in  STD_LOGIC_VECTOR(3 downto 0);
        uniload : in  STD_LOGIC_VECTOR(3 downto 0);
        dezena  : out STD_LOGIC_VECTOR(3 downto 0);
        unidade : out STD_LOGIC_VECTOR(3 downto 0) );
end contador100;

-- Architecture (Arquitetura)
-- implementações do projeto	

architecture contador100_arch of contador100 is

-- Declaração do componente contador10
-- Declaração do componente contador10, referente a sua arquitetura descrita no arquivo contador10.vhdl
component contador10 is
  port( clock  : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        enable : in  STD_LOGIC;
        rci    : in  STD_LOGIC;
        load   : in  STD_LOGIC;
        D      : in  STD_LOGIC_VECTOR(3 downto 0);
        Q      : out STD_LOGIC_VECTOR(3 downto 0);
        rco    : out STD_LOGIC );
end component;

-- sinais auxiliares para trocar informações entre os componentes
-- fio_1 é o rci do primeiro contador setado como 0, para que o mesmo 
-- funcione
signal fio_1       : std_logic := '0';
signal fio_2,fio_3 : std_logic;

-- a definição inicia por
begin

-- instanciação do componente contador10, para gerar unidade e dezena do contador100
uni: contador10 port map(clock,reset,enable,fio_1,load,uniload,unidade,fio_2);
dez: contador10 port map(clock,reset,enable,fio_2,load,dezload,dezena,fio_3);

end contador100_arch;
-- a definição termina por end