-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 19/09/2020

-- ***********************************************
-- Testbench para simulação funcional do Circuito:
--   Multiplexador com dois vetores de entrada:
--     Vetor S de 3 bits de entrada Entrada 1
--     Vetor D de 8 bits de entrada Entrada 2
-- 				  Y Saída
-- *********************************************** 

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

ARCHITECTURE tb_mux8x1 OF testbench1 IS 

-- Declaração do componente mux8x1
-- Declaração do componente mux8x1, referente a sua arquitetura descrita no arquivo mux8x1.vhd

component mux8x1 port(
S :in  std_logic_vector(2 downto 0);
D :in  std_logic_vector(7 downto 0);
Y :out std_logic
);
end component;

-- Período de tempo para os clocks

constant T: time := 512 ns; -- período para o clk 8
constant U: time := 256 ns; -- período para o clk 7
constant V: time := 128 ns; -- período para o clk 6
constant X: time := 64  ns; -- período para o clk 5
constant Z: time := 32  ns; -- período para o clk 4
constant R: time := 16  ns; -- período para o clk 3
constant P: time := 8   ns; -- período para o clk 2
constant Q: time := 4   ns; -- período para o clk 1

-- Sinais auxiliares para a interconexão ao
-- processo de estímulo

signal i_1 : std_logic_vector(2 downto 0);
signal clk_1, clk_2, clk_3, clk_4, clk_5, clk_6, clk_7, clk_8 : std_logic;

-- Instância do componente mux8x1 e interconexão do componente ao processo
-- de estímulo

Begin

mux2: mux8x1 PORT MAP (S => i_1, D(0) => clk_1, D(1) => clk_2, D(2) => clk_3, D(3) => clk_4, 
D(4) => clk_5, D(5) => clk_6, D(6) => clk_7, D(7) => clk_8, Y => open);

-- criar 8 formas de ondas periódicas - períodos 4, 8, 16, 32, 64, 128, 256, 512. 

clk1: process -- gerador do clock 1
begin
clk_1 <= '0','1' after Q/2, '0' after Q; wait for Q; 
end process;

clk2: process -- gerador do clock 2
begin
clk_2 <= '0','1' after P/2, '0' after P; wait for P; 
end process;

clk3: process -- gerador do clock 3
begin 
clk_3 <= '0','1' after R/2, '0' after R; wait for R; 
end process;

clk4: process -- gerador do clock 4
begin
clk_4 <= '0','1' after Z/2, '0' after Z; wait for Z; 
end process;

clk5: process -- gerador do clock 5
begin
clk_5 <= '0','1' after X/2, '0' after X; wait for X; 
end process;

clk6: process -- gerador do clock 6
begin
clk_6 <= '0','1' after V/2, '0' after V; wait for V; 
end process;

clk7: process -- gerador do clock 7
begin
clk_7 <= '0','1' after U/2, '0' after U; wait for U; 
end process;

clk8: process -- gerador do clock 8
begin
clk_8 <= '0', '1' after T/2, '0' after T; wait for T; 
end process;

-- Implementação do processo de estímulo

estimulo: process
begin
i_1(0) <= '0'; 
i_1(1) <= '0';
i_1(2) <= '0';
wait for 512 ns; 
i_1(0) <= '1';
wait for 512 ns; 
i_1(1) <= '1';
wait for 512 ns;
i_1(0) <= '0';
wait for 512 ns;
i_1(2) <= '1';
wait for 512 ns;
i_1(0) <= '1';
wait for 512 ns;
i_1(1) <= '0';
wait for 512 ns;
i_1(0) <= '0';
wait;

-- Final do processo de estímulo

end  process  estimulo;

-- Final do testbench

end tb_mux8x1;
