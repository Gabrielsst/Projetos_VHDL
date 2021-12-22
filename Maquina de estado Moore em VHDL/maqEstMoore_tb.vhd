-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 03/11/2020

-- *********************************************************************
--   Circuito: M�quina de Estado Moore, que implementa o funcionamento 
--      	     de uma m�quina de refrigerante:
--		     Vetor A de 2 bits	   Entrada 1 
--		     CLK   		   Entrada 2 
--		     RST    		   Entrada 3
--		     R   		   Sa�da   1
--		     D25c     		   Sa�da   2
--		     D50c     		   Sa�da   3
-- *********************************************************************

-- ENTITY (Entidade)
-- testbench1 uma entidade sem pinos de entrada e sa�da

ENTITY testbench1 IS END;

-- Testbench para maqEstMoore.vhd
-- Valida��o ass�ncrona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_MEM OF testbench1 IS

-- Declara��o do componente MEM
-- Declara��o do componente MEM, referente a sua arquitetura descrita no arquivo maqEstMoore.vhd

component MEM is port(
A	      :in  std_logic_vector(1 downto 0);
CLK, RST      :in  std_logic;
R, D25c, D50c :out std_logic );
end component;

-- Per�odo de tempo para o clock
constant V: time := 10 ns;

-- sinais auxiliares para a interconex�o ao estimulo: process
signal A_1   : std_logic_vector(1 downto 0);
signal RST_1 : std_logic;

-- sinal para o clock
signal CLK_1 : std_logic;

-- Inst�ncia do componente MEM e interconex�o do componente ao estimulo: process
-- e ao clock

Begin

MEM1: MEM PORT MAP(A => A_1, RST => RST_1, CLK => CLK_1,
R => open, D25c => open, D50c => open);

clk1: process -- gerador do clock 1
begin 
CLK_1 <= '0', '1' after V/2, '0' after V; wait for V;
end process;

-- Implementa��o do estimulo: process

estimulo: process
begin

-- primeira coluna de teste
RST_1 <= '0';   -- reset = 0, inicializa��o do reset
A_1   <= "00";  -- A = 00, inicializa��o de A
wait for 5 ns;
A_1   <= "01";  -- ap�s 5 ns � adicionado 25 centavos a cada subida de clock
wait for 40 ns; -- o wait for 40 ns, � usado para adicionar 4 moedas de 25 centavos

-- segunda coluna de teste
A_1   <= "00";  -- "A" volta para o estado inicial 
wait for 10 ns;
A_1   <= "10";  -- ap�s 10 ns � adicionado 50 centavos a cada subida de clock
wait for 20 ns; -- o wait for 20 ns, � usado para adicionar 2 moedas de 50 centavos

-- terceira coluna de teste
A_1   <= "01";  -- "A" come�a no estado c25 ao inv�s do estado inicial, por ter sido
                -- sido adicionado 25 centavos � m�quina, ap�s ela ter sa�do do estado c100
wait for 10 ns;
A_1   <= "10";  -- ap�s 10 ns � adicionado 50 centavos a cada subida de clock
wait for 20 ns; -- o wait for 20 ns, � usado para adicionar 2 moedas de 50 centavos

-- quarta coluna de teste
A_1   <= "11";  -- j� come�a com o comando cancelar, como n�o h� moedas, simplesmente fica no 
	        -- estado inicial
wait for 10 ns;
A_1   <= "01";  -- ap�s 10 ns � adicionado 25 centavos a cada subida de clock
wait for 20 ns; -- o wait for 20 ns, � usado para adicionar 2 moedas de 25 centavos
A_1   <= "10";  -- ap�s 20 ns � adicionado 50 centavos a cada subida de clock
wait for 10 ns; -- o wait for 10 ns, � usado para adicionar 1 moedas de 50 centavos

-- quinta coluna de teste
A_1   <= "10";  -- "A" come�a no estado c50 ao inv�s do estado inicial, por ter sido
                -- sido adicionado 50 centavos � m�quina, ap�s ela ter sa�do do estado c100
wait for 10 ns;
A_1   <= "11";  -- � usado o comando cancelar, que devolve os 50 centavos colocados na m�quina
wait for 10 ns;
A_1   <= "00";  -- nada acontece, estado atual � mantido
wait for 10 ns;
A_1   <= "10";  -- ap�s 10 ns � adicionado 50 centavos a cada subida de clock
wait for 10 ns; -- o wait for 10 ns, � usado para adicionar 1 moedas de 50 centavos
A_1   <= "01";  -- ap�s 10 ns � adicionado 25 centavos a cada subida de clock
wait for 10 ns; -- o wait for 10 ns, � usado para adicionar 1 moedas de 25 centavos
RST_1 <= '1';   -- RST = 1, volta para o estado inicial
wait for 10 ns;

-- espera o processo terminar
wait;

-- termina o processo
end process estimulo;

-- Final do Testbench
end tb_MEM;
