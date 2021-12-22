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

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE std.textio.ALL;

-- Entity (Entidade)
-- pinos de entrada e saída

entity testbench is port(
S_dut       :in  std_logic_vector(4 downto 0);
S_gm       :in  std_logic_vector(4 downto 0);
A	    :out std_logic_vector(3 downto 0);
B	    :out std_logic_vector(3 downto 0)
);
end testbench;

-- Architecture (Arquitetura)
-- implementações do processo de estímulo e verificação de igualdade 
-- entre dois cicuitos que desempenham a mesma função

ARCHITECTURE tb_arch OF testbench IS

-- o processo de estímulo começa por
begin

-- Implementação do processo de estímulo
process

-- declarando a variável auxiliar, no processo de estímulo
variable contbin : std_logic_vector(7 downto 0);

begin

-- comando que mostra uma string dizendo que o teste foi iniciado
report "Iniciando teste de comparação dos arquivos somador.vhd e somador_gm.vhd" severity NOTE;

-- iniciando a variável com um valor previamente escolhido
contbin := "00000000";

-- usando for para tornar o processo de encontrar os valores dos vetores de 
-- cada entrada menos manual
for i in 1 to 256 loop
A(0) <= contbin(7); 
A(1) <= contbin(6); 
A(2) <= contbin(5); 
A(3) <= contbin(4); 
B(0) <= contbin(3); 
B(1) <= contbin(2); 
B(2) <= contbin(1); 
B(3) <= contbin(0);
-- usando wait para a função entender que há novos valores, e trocá-los.  
wait for 500 ns;

-- comando para comparar duas expressões booleanas, caso a afirmação dê falsa
-- ele passa para o comando report, que diz a linha na qual houve a falha
assert(S_gm = S_dut) report "Falhou: i = " & integer'image(i) severity ERROR;

-- para cada loop, o contbin tem o valor 1 somado ao seu vetor
contbin := contbin + 1;

-- fim do loop
end loop;

-- comando para reportar que o teste foi finalizado
report "Teste finalizado!" severity NOTE;

-- wait para que o processo acabe, e não seja executado em loop infinito
wait;

-- Final do processo de estímulo
end  process;

-- Final do Testbench
end tb_arch;