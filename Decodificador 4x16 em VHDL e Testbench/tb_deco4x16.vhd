-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 19/09/2020

-- ************************************************
-- 	Testbench para simula��o funcional do 
-- Circuito: Decodificador de 1 entrada com 4 bits:
-- 	     vetor A de 4 bits  Entrada
--           vetor Y de 16 bits Sa�da
-- ************************************************ 

-- ENTITY (Entidade)
-- testbench1  uma entidade sem pinos de entrada e sa�da

ENTITY testbench1 IS END;

-- Testbench para deco4x16.vhd
-- Valida��o ass�ncrona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_deco4x16 OF testbench1 IS 

-- Declara��o do componente deco4x16

-- Declara��o do componente deco4x16, referente a sua arquitetura descrita no arquivo deco4x16.vhd

component deco4x16 port(
A :in  std_logic_vector(3 downto 0);
Y :out  std_logic_vector(15 downto 0)
);
end component;

-- Per�odos de tempo para os clocks

constant T: time := 32  ns; -- per�odo para o clock 4
constant U: time := 16  ns; -- per�odo para o clock 3
constant V: time := 8   ns; -- per�odo para o clock 2
constant X: time := 4   ns; -- per�odo para o clock 1

-- Sinais auxiliares para a cria��o dos clocks

signal clk_1, clk_2, clk_3, clk_4 : std_logic;

-- Inst�ncia do componente deco4x16 e interconex�o do componente ao processo dos clocks

Begin

deco2: deco4x16 PORT MAP (A(0) => clk_1, A(1) => clk_2, A(2) => clk_3, A(3) => clk_4, Y => open);

clk1: process -- gerador do clock 1
begin
clk_1 <= '0','1' after X/2, '0' after X; wait for X; 
end process;

clk2: process -- gerador do clock 2
begin
clk_2 <= '0','1' after V/2, '0' after V; wait for V; 
end process;

clk3: process -- gerador do clock 3
begin
clk_3 <= '0','1' after U/2, '0' after U; wait for U; 
end process;

clk4: process -- gerador do clock 4
begin
clk_4 <= '0', '1' after T/2, '0' after T; wait for T; 
end process;

-- Final do testbench

end tb_deco4x16;