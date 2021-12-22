-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 18/11/2020

-- **********************************************************
--     Testbench do Circuito: exp8visto3, serve para unir 
--                 o exp8visto2 à maqestados:
--   	     clock  	                   Entrada 1 
--   	     ligadesliga  	           Entrada 2 
--   	     sensorA	                   Entrada 3  
--   	     sensorB	                   Entrada 4 
--   	     vetor RYGsemaforoA de 3 bits  Saída   2 
--   	     vetor RYGsemaforoB de 3 bits  Saída   3 
-- ***********************************************************

-- ENTITY (Entidade)
-- testbench1 uma entidade sem pinos de entrada e saída

ENTITY testbench1 IS END;

-- Testbench para exp8visto3.vhdl
-- Validação assíncrona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_semaforos OF testbench1 IS

-- Declaração do componente exp8visto3
-- Declaração do componente exp8visto3, referente a sua arquitetura descrita no arquivo exp8visto3.vhdl

component exp8visto3 is
  port( clock        : in STD_LOGIC;
        ligadesliga  : in STD_LOGIC;        
        sensorA      : in STD_LOGIC;
        sensorB      : in STD_LOGIC;
	RYGsemaforoA : out STD_LOGIC_VECTOR(2 downto 0);
        RYGsemaforoB : out STD_LOGIC_VECTOR(2 downto 0) );
end component;

-- Período de tempo para o clock
constant T: time := 10 ns;

-- sinais auxiliares para a interconexão ao estimulo: process

signal ligadesliga_1, sensorA_1, sensorB_1 : std_logic;

-- sinal para o clock
signal CLK_1 : std_logic;

-- Instância do componente exp8visto3 e interconexão do componente ao estimulo: process
-- e ao clock

Begin

exp8v3: exp8visto3 PORT MAP(ligadesliga => ligadesliga_1, sensorA => sensorA_1,
sensorB => sensorB_1, clock => CLK_1, RYGsemaforoA => open, RYGsemaforoB => open);

clk1: process -- gerador do clock 1
begin 
CLK_1 <= '0', '1' after T/2, '0' after T; wait for T;
end process;

-- Implementação do estimulo: process

estimulo: process
begin

-- rodando sem carro nenhum por todos os estados
ligadesliga_1 <= '1';
sensorA_1     <= '0';
sensorB_1     <= '0';
wait for 1600 ns;

-- alguns testes envolvendo outros mecanismos e o 
-- uso dos sensores dos carros
ligadesliga_1 <='0';
wait for 50 ns;
ligadesliga_1 <='1';
wait for 10 ns;
sensorB_1 <= '1';
wait for 220 ns;
sensorA_1 <= '1';
wait for 20 ns;
sensorB_1 <= '0';
wait for 355 ns;
sensorA_1 <= '0';
wait for 10 ns;
sensorB_1 <= '1'; 

-- espera o processo terminar
wait;

-- termina o processo
end process estimulo;

-- Final do Testbench
end tb_semaforos;
