-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 19/09/2020

-- ************************************************
-- 	Testbench para simulação funcional do 
-- Circuito: Decodificador de 1 entrada com 4 bits:
-- 	     vetor A de 4 bits  Entrada
--           vetor Y de 16 bits Saída
-- ************************************************ 

-- ENTITY (Entidade)
-- testbench1  uma entidade sem pinos de entrada e saída

ENTITY testbench1 IS END;

-- Testbench para deco4x16.vhd
-- Validação assíncrona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_deco4x16 OF testbench1 IS 

-- Declaração do componente deco4x16

-- Declaração do componente deco4x16, referente a sua arquitetura descrita no arquivo deco4x16.vhd

component deco4x16 port(
A :in  std_logic_vector(3 downto 0);
Y :out  std_logic_vector(15 downto 0)
);
end component;

-- Períodos de tempo para os clocks

constant T: time := 32  ns; -- período para o clock 4
constant U: time := 16  ns; -- período para o clock 3
constant V: time := 8   ns; -- período para o clock 2
constant X: time := 4   ns; -- período para o clock 1

-- Sinais auxiliares para a criação dos clocks

signal clk_1, clk_2, clk_3, clk_4 : std_logic;

-- Instância do componente deco4x16 e interconexão do componente ao processo dos clocks

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