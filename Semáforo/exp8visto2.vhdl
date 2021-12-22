-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 18/11/2020

-- ************************************************************************
--      Circuito: exp8visto2, serve para unir o contador ao timeflag:
--   	       	      clock                   Entrada 1 
--   	       	      reset                   Entrada 2 
--   	       	      T60	              Sa�da   1  
--   	       	      T20                     Sa�da   2 
--   	      	      T6                      Sa�da   3 
--   	       	      T5                      Sa�da   4
-- ************************************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity (Entidade)
-- pinos de entrada e sa�da

entity exp8visto2 is
  port( clock : in  STD_LOGIC;
        reset : in  STD_LOGIC;        
        T60   : out STD_LOGIC;
        T20   : out STD_LOGIC;
        T6    : out STD_LOGIC;
        T5    : out STD_LOGIC );
end exp8visto2;

-- Architecture (Arquitetura)
-- implementa��es do projeto

architecture exp8visto2_arch of exp8visto2 is

-- Declara��o do componente contador100
-- Declara��o do componente contador100, referente a sua arquitetura descrita no arquivo contador100.vhdl
component contador100 is
  port( clock   : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        enable  : in  STD_LOGIC;
        load    : in  STD_LOGIC;
        dezload : in  STD_LOGIC_VECTOR(3 downto 0);
        uniload : in  STD_LOGIC_VECTOR(3 downto 0);
        dezena  : out STD_LOGIC_VECTOR(3 downto 0);
        unidade : out STD_LOGIC_VECTOR(3 downto 0) );
end component;

-- Declara��o do componente timeflags
-- Declara��o do componente timeflags, referente a sua arquitetura descrita no arquivo timeflags.vhdl
component timeflags is
  port( dezena  : in STD_LOGIC_VECTOR(3 downto 0);
        unidade : in STD_LOGIC_VECTOR(3 downto 0);
        T60     : out STD_LOGIC;
        T20     : out STD_LOGIC;
        T6      : out STD_LOGIC;
        T5      : out STD_LOGIC );
end component;

-- sinais auxiliares para trocar informa��es entre os componentes
signal dezena_1: std_logic_vector(3 downto 0);
signal unidade_2: std_logic_vector(3 downto 0);
-- sinais definidos por 0000 e 0 porque certos mecanismos do contador
-- ficar�o sem uso, como o load por exemplo
signal barramento_3: std_logic_vector(3 downto 0) := "0000";
signal barramento_4: std_logic_vector(3 downto 0) := "0000";
signal fio_1             : std_logic        := '0';
signal fio_2             : std_logic        := '0';

-- a defini��o inicia por 
begin

-- instancia��o do componente contador100 e timeflags, para gerar os valores de sa�da(T60, T20, T6 e T5) do timeflags
contador2: contador100 port map(clock,reset,fio_1,fio_2,barramento_3,barramento_4,dezena_1,unidade_2);
timeflag1: timeflags   port map(dezena_1,unidade_2,T60,T20,T6,T5);

end exp8visto2_arch;
-- a defini��o termina por end