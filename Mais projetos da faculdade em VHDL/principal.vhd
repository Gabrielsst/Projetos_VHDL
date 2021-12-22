-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 06/10/2020

-- **************************************************************
-- 	    Testbench do Circuito: Somador Completo com 
-- 	     2 vetores de entrada e 2 vetores de sa�da:
--		  Vetor S_dut de 5 bits Entrada 1 
--		  Vetor S_gm  de 5 bits Entrada 1 
--		  Vetor A     de 4 bits Sa�da 1 
--		  Vetor B     de 4 bits Sa�da 1
-- **************************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity (Entidade)
-- sem pinos de entrada e sa�da, pois vai fazer a jun��o entre as componentes 
-- com o testbench

entity main is 
end main;

-- Architecture (Arquitetura)
-- implementa��es do projeto

architecture main_arch of main is

-- Declara��o do componente somador_dut
-- Declara��o do componente somador_dut, referente a sua arquitetura descrita no arquivo somador.vhd
component somador_dut is port(
A    :in  std_logic_vector(3 downto 0);
B    :in  std_logic_vector(3 downto 0);
S    :out std_logic_vector(4 downto 0)
);
end component;

-- Declara��o do componente somador_gm
-- Declara��o do componente somador_gm, referente a sua arquitetura descrita no arquivo somador_gm.vhd
component somador_gm is port(
A    :in  std_logic_vector(3 downto 0);
B    :in  std_logic_vector(3 downto 0);
S    :out std_logic_vector(4 downto 0)
);
end component;

-- Declara��o do componente testbench
-- Declara��o do componente testbench, referente a sua arquitetura descrita no arquivo tb_somador_main.vhd
component testbench is port(
S_dut       :in  std_logic_vector(4 downto 0);
S_gm       :in  std_logic_vector(4 downto 0);
A	    :out std_logic_vector(3 downto 0);
B	    :out std_logic_vector(3 downto 0)
);
end component;

-- Sinais auxiliares para a interconex�o
-- entre os componentes

signal fio_dut : std_logic_vector(4 downto 0);
signal fio_gm  : std_logic_vector(4 downto 0);
signal A       : std_logic_vector(3 downto 0);
signal B       : std_logic_vector(3 downto 0);

begin 

-- Inst�ncia do componente somador_dut e interconex�o do componente � 
-- arquitetura da entidade main
dut: somador_dut port map(A, B, fio_dut);

-- Inst�ncia do componente somador_gm e interconex�o do componente � 
-- arquitetura da entidade main
gm : somador_gm  port map(A, B, fio_gm );

-- Inst�ncia do componente testbench e interconex�o do componente � 
-- arquitetura da entidade main
tb : testbench   port map(fio_dut, fio_gm, A, B); 

end main_arch;

-- a defini��o termina por end
