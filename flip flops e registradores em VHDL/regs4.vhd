-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 20/10/2020

-- **********************************************************************
--     Circuito: registrador de deslocamento bidirecional de 4 bits:
--		     CLK    		   Entrada 1 
--		     RST   		   Entrada 2 
--		     LD    		   Entrada 3
--		     DIR   		   Entrada 4
--		     L     		   Entrada 5
--		     R     		   Entrada 6
--		     Vetor D de 4 bits     Entrada 7
--		     Vetor Q de 4 bits     Saída 1
-- **********************************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity (Entidade)
-- pinos de entrada e saída

entity regis is port(
CLK, RST, LD, DIR, L, R    :in  std_logic;
D			   :in  std_logic_vector(3 downto 0);
Q    		      	   :out std_logic_vector(3 downto 0)
);
end regis;

-- Architecture (Arquitetura)
-- implementações do projeto 

architecture regis_arch of regis is 

-- sinal intermediário para auxiliar no funcionamento do circuito
-- dentro da estrutura process 
signal Qbuf : std_logic_vector(3 downto 0) := "0000";

-- a definição inicia por 
begin

-- é atribuída a Q o valor de Qbuf, já que o Q não pode ser lido,
-- mas o Qbuf sim
Q <= Qbuf;

-- inicia a estrutura process, com CLK na lista de sensibilidade
process (CLK)
begin 

-- condicional if, onde Qbuf recebe "0000" se RST for 1
if(RST = '1') then 
	Qbuf <= "0000"; 
-- condicional elsif, onde Qbuf recebe D se LD for 1
elsif(LD = '1') then
	Qbuf <= D;
-- condicional elsif, na qual se CLK estiver na borda de subida, então haverão 
-- mais condicionais a serem checadas
elsif rising_edge(CLK) then
-- condicional if, onde se DIR for 0, Qbuf recebe Qbuf(2), Qbuf(1), Qbuf(0) e L,
-- ou seja, possui um bit deslocado à esquerda
	if(DIR = '0') then
		Qbuf <= Qbuf(2) & Qbuf(1) & Qbuf(0) & L;
-- condicional elsif, onde se DIR for 1, Qbuf recebe R, Qbuf(3), Qbuf(2) e Qbuf(1),
-- ou seja, possui um bit deslocado à direita
	elsif(DIR = '1') then
		Qbuf <= R & Qbuf(3) & Qbuf(2) & Qbuf(1);
-- caso nenhuma delas seja satisfeita, Qbuf manterá o sinal no qual se encontra 
	else Qbuf <= Qbuf; -- opcional
-- término da primeira condicional if
	end if;
-- término da segunda condicional if
end if;

-- término da estrutura process
end process;

end regis_arch;

-- a definição termina por end
