-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 18/11/2020

-- **********************************************************************
--            Testbench do Circuito: exp8visto, serve para unir 
--                         o contador ao timeflag:                   
--   	       	       clock                 Entrada 1 
--   	       	       reset                 Entrada 2 
--   	       	       T60	             Sa�da   1  
--   	       	       T20                   Sa�da   2 
--   	      	       T6                    Sa�da   3 
--   	       	       T5                    Sa�da   4
-- **********************************************************************

-- ENTITY (Entidade)
-- testbench1 uma entidade sem pinos de entrada e sa�da

ENTITY testbench1 IS END;

-- Testbench para exp8visto2.vhdl
-- Valida��o ass�ncrona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_timeflags OF testbench1 IS

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

-- Per�odo de tempo para o clock
constant T: time := 10 ns;

-- sinais auxiliares para a interconex�o ao estimulo: process
signal reset_1 : std_logic;

-- sinal para o clock
signal CLK_1 : std_logic;

-- Inst�ncia do componente exp8visto2 e interconex�o do componente ao estimulo: process
-- e ao clock

Begin

exp8v2: exp8visto2 PORT MAP(reset => reset_1, clock => CLK_1, T60 => open, T20 => open, T6 => open, T5 => open);

clk1: process -- gerador do clock 1
begin 
CLK_1 <= '0', '1' after T/2, '0' after T; wait for T;
end process;

-- Implementa��o do estimulo: process

estimulo: process
begin

-- testa as 4 sa�das
reset_1 <= '0';
wait for 610 ns;

-- testa o reset
reset_1 <= '1';
wait for 55 ns;
reset_1 <= '0';

-- espera o processo terminar
wait;

-- termina o processo
end process estimulo;

-- Final do Testbench
end tb_timeflags;
