-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 18/11/2020

-- **********************************************************
--       Testbench do Circuito: Contador de M�dulo 100:
--   		clock  	                Entrada 1 
--   		reset   	        Entrada 2 
--   		enable	                Entrada 3  
--   		load	                Entrada 4 
--   		vetor dezload de 4 bits Entrada 5 
--   		vetor uniload de 4 bits Entrada 6
--   		vetor dezena  de 4 bits Sa�da   1 
--   		vetor unidade de 4 bits Sa�da   2 
-- ***********************************************************

-- ENTITY (Entidade)
-- testbench1 uma entidade sem pinos de entrada e sa�da

ENTITY testbench1 IS END;

-- Testbench para contador100.vhdl
-- Valida��o ass�ncrona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_contador100 OF testbench1 IS

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

-- Per�odo de tempo para o clock
constant T: time := 10 ns;

-- sinais auxiliares para a interconex�o ao estimulo: process
signal dezload_1   : std_logic_vector(3 downto 0) := "0000";
signal uniload_1   : std_logic_vector(3 downto 0) := "0000";
signal reset_1,enable_1,load_1 : std_logic;

-- sinal para o clock
signal CLK_1 : std_logic;

-- Inst�ncia do componente contador100 e interconex�o do componente ao estimulo: process
-- e ao clock

Begin

contador1: contador100 PORT MAP(enable => enable_1, load => load_1, reset => reset_1,
clock => CLK_1, dezload => dezload_1, uniload => uniload_1, dezena => open, unidade => open);

clk1: process -- gerador do clock 1
begin 
CLK_1 <= '0', '1' after T/2, '0' after T; wait for T;
end process;

-- Implementa��o do estimulo: process

estimulo: process
begin

-- deixando o contador contar de 0 at� 99
reset_1  <= '0';
load_1   <= '0';
enable_1 <= '0';
wait for 990 ns;

-- testando outros mecanismos do circuito 
uniload_1 <= "0110";
wait for 5 ns;
dezload_1 <= "0010";
wait for 5 ns;
load_1    <= '1';
wait for 10 ns;
load_1    <= '0';
wait for 10 ns;
reset_1   <= '1';
wait for 10 ns;
reset_1   <= '0';
wait for 20 ns;
enable_1  <= '1';
wait for 10 ns;
enable_1  <= '0';

-- espera o processo terminar
wait;

-- termina o processo
end process estimulo;

-- Final do Testbench
end tb_contador100;
