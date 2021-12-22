-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 06/10/2020

-- **************************************************************
-- 	    Testbench do Circuito: Somador Completo com 
-- 	     2 vetores de entrada e 2 vetores de saída:
--		  Vetor S_dut de 5 bits Entrada 1 
--		  Vetor S_gm  de 5 bits Entrada 1 
--		  Vetor A     de 4 bits Saída 1 
--		  Vetor B     de 4 bits Saída 1
-- **************************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity (Entidade)
-- sem pinos de entrada e saída, pois vai fazer a junção entre as componentes 
-- com o testbench

entity main is 
end main;

-- Architecture (Arquitetura)
-- implementações do projeto

architecture main_arch of main is

-- Declaração do componente somador_dut
-- Declaração do componente somador_dut, referente a sua arquitetura descrita no arquivo somador.vhd
component somador_dut is port(
A    :in  std_logic_vector(3 downto 0);
B    :in  std_logic_vector(3 downto 0);
S    :out std_logic_vector(4 downto 0)
);
end component;

-- Declaração do componente somador_gm
-- Declaração do componente somador_gm, referente a sua arquitetura descrita no arquivo somador_gm.vhd
component somador_gm is port(
A    :in  std_logic_vector(3 downto 0);
B    :in  std_logic_vector(3 downto 0);
S    :out std_logic_vector(4 downto 0)
);
end component;

-- Declaração do componente testbench
-- Declaração do componente testbench, referente a sua arquitetura descrita no arquivo tb_somador_main.vhd
component testbench is port(
S_dut       :in  std_logic_vector(4 downto 0);
S_gm       :in  std_logic_vector(4 downto 0);
A	    :out std_logic_vector(3 downto 0);
B	    :out std_logic_vector(3 downto 0)
);
end component;

-- Sinais auxiliares para a interconexão
-- entre os componentes

signal fio_dut : std_logic_vector(4 downto 0);
signal fio_gm  : std_logic_vector(4 downto 0);
signal A       : std_logic_vector(3 downto 0);
signal B       : std_logic_vector(3 downto 0);

begin 

-- Instância do componente somador_dut e interconexão do componente à 
-- arquitetura da entidade main
dut: somador_dut port map(A, B, fio_dut);

-- Instância do componente somador_gm e interconexão do componente à 
-- arquitetura da entidade main
gm : somador_gm  port map(A, B, fio_gm );

-- Instância do componente testbench e interconexão do componente à 
-- arquitetura da entidade main
tb : testbench   port map(fio_dut, fio_gm, A, B); 

end main_arch;

-- a definição termina por end
