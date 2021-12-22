-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 06/10/2020

-- ***********************************************************************
-- 		Testbench do Circuito: Somador Completo com 
-- 		  2 vetores de entrada e 1 vetor de sa�da:
--		      Vetor A de 4 bits     Entrada 1 
--		      Vetor B de 4 bits     Entrada 2
--		      Vetor S de 5 bits     Sa�da 1
-- ***********************************************************************

-- ENTITY (Entidade)
-- testbench1 uma entidade sem pinos de entrada e sa�da

ENTITY testbench1 IS END;

-- Testbench para somador.vhd
-- Valida��o ass�ncrona

-- Package (Pacote)
-- constantes e bibliotecas

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE std.textio.ALL;

ARCHITECTURE tb_somador_gm OF testbench1 IS

-- Declara��o do componente somador_gm
-- Declara��o do componente somador_gm, referente a sua arquitetura descrita no arquivo somador_gm.vhd

component somador_gm is port(
A    :in  std_logic_vector(3 downto 0);
B    :in  std_logic_vector(3 downto 0);
S    :out std_logic_vector(4 downto 0)
);
end component;

-- sinais auxiliares para a interconex�o ao processo 
-- de est�mulo

signal i_1 : std_logic_vector(3 downto 0);
signal i_2 : std_logic_vector(3 downto 0);

-- Inst�ncia do componente somador_dut e interconex�o do componente ao processo 
-- de est�mulo

Begin

somador1: somador_gm PORT MAP (A => i_1, B => i_2 , S => open);

-- Implementa��o do processo de est�mulo

estimulo: process

-- declarando a vari�vel auxiliar, no processo de est�mulo
variable contbin : std_logic_vector(7 downto 0);

begin

-- iniciando a vari�vel com um valor previamente escolhido
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
-- usando wait para a fun��o entender que h� novos valores, e troc�-los.  
wait for 500 ns;

-- para cada loop, o contbin tem o valor 1 somado ao seu vetor
contbin := contbin + 1;

-- fim do loop
end loop;

-- wait para que o processo acabe, e n�o seja executado em loop infinito
wait;

-- Final do processo de est�mulo
end  process estimulo;

-- Final do Testbench
end tb_somador_gm;
