-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 18/11/2020

-- **********************************************************
--   	     Circuito: exp8visto3, serve para unir o 
--                  exp8visto2 � maqestados:
--   	     clock  	                   Entrada 1 
--   	     ligadesliga  	           Entrada 2 
--   	     sensorA	                   Entrada 3  
--   	     sensorB	                   Entrada 4 
--   	     vetor RYGsemaforoA de 3 bits  Sa�da   2 
--   	     vetor RYGsemaforoB de 3 bits  Sa�da   3 
-- ***********************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity (Entidade)
-- pinos de entrada e sa�da

entity exp8visto3 is
  port( clock        : in STD_LOGIC;
        ligadesliga  : in STD_LOGIC;        
        sensorA      : in STD_LOGIC;
        sensorB      : in STD_LOGIC;
	RYGsemaforoA : out STD_LOGIC_VECTOR(2 downto 0);
        RYGsemaforoB : out STD_LOGIC_VECTOR(2 downto 0) );
end exp8visto3;

-- Architecture (Arquitetura)
-- implementa��es do projeto	

architecture exp8visto3_arch of exp8visto3 is

-- Declara��o do componente exp8visto2
-- Declara��o do componente exp8visto2, referente a sua arquitetura descrita no arquivo exp8visto2.vhdl
component exp8visto2 is
  port( clock : in  STD_LOGIC;
        reset : in  STD_LOGIC;        
        T60   : out STD_LOGIC;
        T20   : out STD_LOGIC;
        T6    : out STD_LOGIC;
        T5    : out STD_LOGIC );
end component;

-- Declara��o do componente maqestados
-- Declara��o do componente maqestados, referente a sua arquitetura descrita no arquivo maqestados.vhdl
component maqestados is
  port( clock        : in  STD_LOGIC;
        ligadesliga  : in  STD_LOGIC;
        sensorA      : in  STD_LOGIC;
        sensorB      : in  STD_LOGIC;
        T60          : in  STD_LOGIC;
        T20          : in  STD_LOGIC;
        T6           : in  STD_LOGIC;
        T5           : in  STD_LOGIC;
        resetcounter : out STD_LOGIC;
        RYGsemaforoA : out STD_LOGIC_VECTOR(2 downto 0);
        RYGsemaforoB : out STD_LOGIC_VECTOR(2 downto 0) );
end component;

-- sinais auxiliares para trocar informa��es entre os componentes
signal fio_1, T60_1, T20_1, T6_1, T5_1 : std_logic;

-- a defini��o inicia por
begin

-- instancia��o do componente exp8visto2 e maqestados, para gerar os valores 
-- de sa�da(RYGsemaforoA e RYGsemaforoB) da maqestados
exp8vis2   : exp8visto2 port map(clock,  fio_1, T60_1, T20_1, T6_1, T5_1);
-- o resetcounter da m�quina de estados entra na entrada reset do exp8visto2
-- essa liga��o � feita por meio do sinal fio_1
maqestados1: maqestados port map(clock, ligadesliga, sensorA, sensorB, T60_1,
T20_1, T6_1, T5_1, fio_1, RYGsemaforoA, RYGsemaforoB);

end exp8visto3_arch;
-- a defini��o termina por end
