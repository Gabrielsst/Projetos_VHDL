-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 06/10/2020

-- ***********************************************************************
-- 		Testbench do Circuito: Somador Completo com 
-- 		  2 vetores de entrada e 1 vetor de saída:
--		      Vetor A de 4 bits     Entrada 1 
--		      Vetor B de 4 bits     Entrada 2
--		      Vetor S de 5 bits     Saída 1
-- ***********************************************************************

-- ENTITY (Entidade)
-- testbench1 uma entidade sem pinos de entrada e saída

ENTITY testbench1 IS END;

-- Testbench para somador.vhd
-- Validação assíncrona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_somador_gm OF testbench1 IS

-- Declaração do componente somador_gm
-- Declaração do componente somador_gm, referente a sua arquitetura descrita no arquivo somador_gm.vhd

component somador_gm is port(
A    :in  std_logic_vector(3 downto 0);
B    :in  std_logic_vector(3 downto 0);
S    :out std_logic_vector(4 downto 0)
);
end component;

-- sinais auxiliares para a interconexão ao processo 
-- de estímulo

signal i_1 : std_logic_vector(3 downto 0);
signal i_2 : std_logic_vector(3 downto 0);

-- Instância do componente somador_dut e interconexão do componente ao processo 
-- de estímulo

Begin

somador1: somador_gm PORT MAP (A => i_1, B => i_2 , S => open);

-- Implementação do processo de estímulo

estimulo: process

-- declarando a variável auxiliar, no processo de estímulo
variable contbin : std_logic_vector(7 downto 0);

begin

-- iniciando a variável com um valor previamente escolhido
contbin := "00000000";

-- usando for para tornar o processo de encontrar os valores dos vetores de 
-- cada entrada menos manual
for i in 1 to 256 loop
i_1(0) <= contbin(7); 
i_1(1) <= contbin(6); 
i_1(2) <= contbin(5); 
i_1(3) <= contbin(4); 
i_2(0) <= contbin(3); 
i_2(1) <= contbin(2); 
i_2(2) <= contbin(1); 
i_2(3) <= contbin(0);
-- usando wait para a função entender que há novos valores, e trocá-los.  
wait for 500 ns;

-- para cada loop, o contbin tem o valor 1 somado ao seu vetor
contbin := contbin + 1;

-- fim do loop
end loop;

-- wait para que o processo acabe, e não seja executado em loop infinito
wait;

-- Final do processo de estímulo
end  process estimulo;

-- Final do Testbench
end tb_somador_gm;
