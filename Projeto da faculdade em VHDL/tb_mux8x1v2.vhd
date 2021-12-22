-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 23/09/2020

-- **************************************************
--   Testbench para simulação funcional do Circuito:
-- Multiplexador com componentes, 1 decodificador4x16  
--   e 1 multiplexador 8x1, de 7 entradas e 1 saída:
-- 			A Entrada 1
--			B Entrada 2
-- 			C Entrada 3
--			D Entrada 4
-- 			E Entrada 5
--			F Entrada 6
-- 			G Entrada 7
-- 			S Saída
-- *************************************************** 

-- ENTITY (Entidade)
-- testbench1  uma entidade sem pinos de entrada e saída 

ENTITY testbench1 IS END;

-- Testbench para mux8x1.vhd
-- Validação assíncrona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_sistema OF testbench1 IS 

-- Declaração do componente sistema
-- Declaração do componente sistema, referente a sua arquitetura descrita no arquivo decomux.vhd

component sistema port(
A, B, C, D, E, F, G : in  std_logic;
		  S : out std_logic
);
end component;

-- Período de tempo para os clocks

constant T: time := 40 ns; -- período para o clk 1
constant U: time := 20 ns; -- período para o clk 2
constant V: time := 10 ns; -- período para o clk 3
constant X: time := 5  ns; -- período para o clk 4

-- Sinais auxiliares para a interconexão ao
-- processo de estímulo

signal i_1, i_2, i_3 : std_logic;
signal clk_1, clk_2, clk_3, clk_4 : std_logic;

-- Instância do componente sistema e interconexão do componente ao processo
-- de estímulo

Begin

sistema2: sistema PORT MAP (E => i_3, F => i_2, G => i_1, A => clk_1,
B => clk_2, C => clk_3, D => clk_4, S => open);

-- criar 4 formas de ondas periódicas - períodos 5, 10, 20, 40. 

clk1: process -- gerador do clock 1
begin
clk_1 <= '0','1' after T/2, '0' after T; wait for T; 
end process;

clk2: process -- gerador do clock 2
begin
clk_2 <= '0','1' after U/2, '0' after U; wait for U; 
end process;

clk3: process -- gerador do clock 3
begin 
clk_3 <= '0','1' after V/2, '0' after V; wait for V; 
end process;

clk4: process -- gerador do clock 4
begin
clk_4 <= '0','1' after X/2, '0' after X; wait for X; 
end process;

-- Implementação do processo de estímulo

estimulo: process
begin
i_1 <= '0'; 
i_2 <= '0';
i_3 <= '0';
wait for 40 ns; 
i_1 <= '1';
wait for 40 ns; 
i_2 <= '1';
wait for 40 ns;
i_1 <= '0';
wait for 40 ns;
i_3 <= '1';
wait for 40 ns;
i_1 <= '1';
wait for 40 ns;
i_2 <= '0';
wait for 40 ns;
i_1 <= '0';
wait;

-- Final do processo de estímulo

end  process  estimulo;

-- Final do testbench

end tb_sistema;
