-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 20/10/2020

-- **********************************************************************
-- 	  Circuito: Flip-Flop JK, gatilhado pela borda de subida:
-- 			     PR     Entrada 1 
-- 			     CLR    Entrada 2 
-- 			     CLK    Entrada 3 
-- 			     J      Entrada 4 
-- 			     K      Entrada 5 
--		     	     Q      Sa�da 1
-- **********************************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity (Entidade)
-- pinos de entrada e sa�da

entity flipflopJK is port(
PR, CLR, CLK, J, K    :in  std_logic;
Q    		      :out std_logic);
end flipflopJK;

-- Architecture (Arquitetura)
-- implementa��es do projeto 

architecture flipflopJK_arch of flipflopJK is 

-- sinais intermedi�rios para auxiliar no funcionamento do circuito 
-- dentro da estrutura process
signal Qbuf : std_logic := '0';
signal JK : std_logic_vector(1 downto 0);

-- a defini��o inicia por 
begin

-- � atribuida a JK, a concatena��o das vari�veis J e K
JK <= J & K;
-- � atribu�da a Q o valor de Qbuf, j� que o Q n�o pode ser lido,
-- mas o Qbuf sim
Q <= Qbuf;

-- inicia a estrutura process, com PR, CLR e CLK na lista de sensibilidade
process (PR, CLR, CLK)
begin 

-- condicional if, onde Qbuf recebe 1 se PR for igual � 1
if(PR = '1') then 
	Qbuf <= '1'; 
-- condicional elsif, parte da estrutura if, onde Qbuf recebe 0 
-- se CLR for igual � 1
elsif(CLR = '1') then
	Qbuf <= '0';
-- condicional elsif, na qual se CLK estiver na borda de subida, ent�o haver�o 
-- mais condicionais a serem checadas
elsif rising_edge(CLK) then
-- condicional if, onde se JK for 01, Qbuf recebe 0
	if(JK = "01") then
		Qbuf <= '0';
-- condicional elsif, onde se JK for 10, Qbuf recebe 1
	elsif(JK = "10") then
		Qbuf <= '1';
-- condicional elsif, onde se JK for 11, Qbuf recebe Qbuf invertido
	elsif(JK = "11") then
		Qbuf <= not (Qbuf); 
-- caso nenhuma delas seja satisfeita, Qbuf manter� o sinal no qual se encontra
	else Qbuf <= Qbuf; -- opcional
-- t�rmino da primeira condicional if
	end if;
-- t�rmino da segunda condicional if
end if;

-- t�rmino da estrutura process
end process;

end flipflopJK_arch;

-- a defini��o termina por end
