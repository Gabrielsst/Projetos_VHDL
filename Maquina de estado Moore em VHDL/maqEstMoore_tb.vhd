-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 03/11/2020

-- *********************************************************************
--   Circuito: Máquina de Estado Moore, que implementa o funcionamento 
--      	     de uma máquina de refrigerante:
--		     Vetor A de 2 bits	   Entrada 1 
--		     CLK   		   Entrada 2 
--		     RST    		   Entrada 3
--		     R   		   Saída   1
--		     D25c     		   Saída   2
--		     D50c     		   Saída   3
-- *********************************************************************

-- ENTITY (Entidade)
-- testbench1 uma entidade sem pinos de entrada e saída

ENTITY testbench1 IS END;

-- Testbench para maqEstMoore.vhd
-- Validação assíncrona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_MEM OF testbench1 IS

-- Declaração do componente MEM
-- Declaração do componente MEM, referente a sua arquitetura descrita no arquivo maqEstMoore.vhd

component MEM is port(
A	      :in  std_logic_vector(1 downto 0);
CLK, RST      :in  std_logic;
R, D25c, D50c :out std_logic );
end component;

-- Período de tempo para o clock
constant V: time := 10 ns;

-- sinais auxiliares para a interconexão ao estimulo: process
signal A_1   : std_logic_vector(1 downto 0);
signal RST_1 : std_logic;

-- sinal para o clock
signal CLK_1 : std_logic;

-- Instância do componente MEM e interconexão do componente ao estimulo: process
-- e ao clock

Begin

MEM1: MEM PORT MAP(A => A_1, RST => RST_1, CLK => CLK_1,
R => open, D25c => open, D50c => open);

clk1: process -- gerador do clock 1
begin 
CLK_1 <= '0', '1' after V/2, '0' after V; wait for V;
end process;

-- Implementação do estimulo: process

estimulo: process
begin

-- primeira coluna de teste
RST_1 <= '0';   -- reset = 0, inicialização do reset
A_1   <= "00";  -- A = 00, inicialização de A
wait for 5 ns;
A_1   <= "01";  -- após 5 ns é adicionado 25 centavos a cada subida de clock
wait for 40 ns; -- o wait for 40 ns, é usado para adicionar 4 moedas de 25 centavos

-- segunda coluna de teste
A_1   <= "00";  -- "A" volta para o estado inicial 
wait for 10 ns;
A_1   <= "10";  -- após 10 ns é adicionado 50 centavos a cada subida de clock
wait for 20 ns; -- o wait for 20 ns, é usado para adicionar 2 moedas de 50 centavos

-- terceira coluna de teste
A_1   <= "01";  -- "A" começa no estado c25 ao invés do estado inicial, por ter sido
                -- sido adicionado 25 centavos à máquina, após ela ter saído do estado c100
wait for 10 ns;
A_1   <= "10";  -- após 10 ns é adicionado 50 centavos a cada subida de clock
wait for 20 ns; -- o wait for 20 ns, é usado para adicionar 2 moedas de 50 centavos

-- quarta coluna de teste
A_1   <= "11";  -- já começa com o comando cancelar, como não há moedas, simplesmente fica no 
	        -- estado inicial
wait for 10 ns;
A_1   <= "01";  -- após 10 ns é adicionado 25 centavos a cada subida de clock
wait for 20 ns; -- o wait for 20 ns, é usado para adicionar 2 moedas de 25 centavos
A_1   <= "10";  -- após 20 ns é adicionado 50 centavos a cada subida de clock
wait for 10 ns; -- o wait for 10 ns, é usado para adicionar 1 moedas de 50 centavos

-- quinta coluna de teste
A_1   <= "10";  -- "A" começa no estado c50 ao invés do estado inicial, por ter sido
                -- sido adicionado 50 centavos à máquina, após ela ter saído do estado c100
wait for 10 ns;
A_1   <= "11";  -- é usado o comando cancelar, que devolve os 50 centavos colocados na máquina
wait for 10 ns;
A_1   <= "00";  -- nada acontece, estado atual é mantido
wait for 10 ns;
A_1   <= "10";  -- após 10 ns é adicionado 50 centavos a cada subida de clock
wait for 10 ns; -- o wait for 10 ns, é usado para adicionar 1 moedas de 50 centavos
A_1   <= "01";  -- após 10 ns é adicionado 25 centavos a cada subida de clock
wait for 10 ns; -- o wait for 10 ns, é usado para adicionar 1 moedas de 25 centavos
RST_1 <= '1';   -- RST = 1, volta para o estado inicial
wait for 10 ns;

-- espera o processo terminar
wait;

-- termina o processo
end process estimulo;

-- Final do Testbench
end tb_MEM;
