-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 18/11/2020

-- **********************************************************
--   		Circuito: Contador de M�dulo 10:
--   		clock  	               Entrada 1 
--   		reset   	       Entrada 2 
--   		enable	               Entrada 3 
--   		rci  		       Entrada 4 
--   		load	               Entrada 5 
--   		Vetor D de 4 bits      Entrada 6 
--   		Vetor Q de 4 bits      Sa�da   1 
--   		rco  		       Sa�da   2 
-- ***********************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity (Entidade)
-- pinos de entrada e sa�da

entity contador10 is
  port( clock  : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        enable : in  STD_LOGIC;
        rci    : in  STD_LOGIC;
        load   : in  STD_LOGIC;
        D      : in  STD_LOGIC_VECTOR(3 downto 0);
        Q      : out STD_LOGIC_VECTOR(3 downto 0);
        rco    : out STD_LOGIC );
end contador10;

-- Architecture (Arquitetura)
-- implementa��es do projeto

architecture contador10_arch of contador10 is

-- cria��o de um tipo chamado estado, com 10 valores descritos abaixo
  type estado is (ST0,ST1,ST2,ST3,ST4,ST5,ST6,ST7,ST8,ST9);

-- cria��o de tres sinais do tipo estado que foi criado acima,
-- currentState(estado atual), nextState(pr�ximo estado) e loadState
-- que carrega os estados correspondentes aos valores da entrada D
  signal currentState, nextState, loadState : estado;

-- a defini��o inicia por
begin

-- condicional que recebe valores da entrada D e carrega o loadState 
-- com o estado correspondente
  with D select
    loadState <= ST0 when "0000",
		 ST1 when "0001",
		 ST2 when "0010",
		 ST3 when "0011",
		 ST4 when "0100",
		 ST5 when "0101",
		 ST6 when "0110",
		 ST7 when "0111",
		 ST8 when "1000",
		 ST9 when "1001",
		 ST0 when others;

-- processo s�ncrono, funciona como a mem�ria da m�quina de estado	
sync_proc: process(clock)
  begin

-- if para atribuir nextState ao currentState na borda de subida do clock
    if rising_edge(clock) then 
      currentState <= nextState;
-- final da estrutura if
    end if;

-- final do processo s�ncrono
end process sync_proc;

-- processo combinacional, onde � feita a l�gica de estado seguinte
comb_proc: process(currentState,reset,enable,rci,load,loadState)
  begin

-- estrutura case, olha para dentro do sinal currentState, e verifica 
-- cada um do que consideramos como os dez estados desta m�quina de estado
    case currentState is
	
	when ST0 =>      -- estado inicial, equivale ao n�mero zero no contador
	  Q   <= "0000"; -- valores de sa�da do estado inicial
	  rco <= '1';    -- valor da sa�da de cascateamento
	  -- if, quando reset = 1, o pr�ximo estado � o inicial
	  if (reset = '1') then nextState <= ST0; 
	  -- elsif, quando load = 1, pr�ximo estado recebe o estado
	  -- corresponte ao valor da entrada D
	  elsif (load = '1') then nextState <= loadState;
	  -- elsif, quando enable = 0 e rci = 0, pr�ximo estado recebe o estado ST1
	  elsif ((enable = '0') and (rci = '0')) then nextState <= ST1;
          -- else, se nada � feito, o pr�ximo estado recebe o estado atual
	  else nextState <= ST0;
          -- fim da primeira estrutura if
	  end if;

	when ST1 =>	 -- estado ST1, equivale ao n�mero 1 no contador
	  Q   <= "0001"; -- valores de sa�da do ST1
	  rco <= '1';	 -- valor da sa�da de cascateamento
	  -- if, quando reset = 1, o pr�ximo estado � o inicial
	  if (reset = '1') then nextState <= ST0;
	  -- elsif, quando load = 1, pr�ximo estado recebe o estado
	  -- corresponte ao valor da entrada D
	  elsif (load = '1') then nextState <= loadState;
	  -- elsif, quando enable = 0 e rci = 0, pr�ximo estado recebe o estado ST2
	  elsif ((enable = '0') and (rci = '0')) then nextState <= ST2;
 	  -- else, se nada � feito, o pr�ximo estado recebe o estado atual
	  else nextState <= ST1;
	  -- fim da segunda estrutura if
	  end if;

	when ST2 =>	 -- estado ST2, equivale ao n�mero 2 no contador
	  Q   <= "0010"; -- valores de sa�da do ST2
	  rco <= '1';	 -- valor da sa�da de cascateamento
	  -- if, quando reset = 1, o pr�ximo estado � o inicial
	  if (reset = '1') then nextState <= ST0;
	  -- elsif, quando load = 1, pr�ximo estado recebe o estado
	  -- corresponte ao valor da entrada D
	  elsif (load = '1') then nextState <= loadState;
	  -- elsif, quando enable = 0 e rci = 0, pr�ximo estado recebe o estado ST3
	  elsif ((enable = '0') and (rci = '0')) then nextState <= ST3;
 	  -- else, se nada � feito, o pr�ximo estado recebe o estado atual
	  else nextState <= ST2;
	  -- fim da terceira estrutura if
	  end if;

	when ST3 =>	 -- estado ST3, equivale ao n�mero 3 no contador
	  Q   <= "0011"; -- valores de sa�da do ST3
	  rco <= '1';	 -- valor da sa�da de cascateamento
	  -- if, quando reset = 1, o pr�ximo estado � o inicial
	  if (reset = '1') then nextState <= ST0;
	  -- elsif, quando load = 1, pr�ximo estado recebe o estado
	  -- corresponte ao valor da entrada D
	  elsif (load = '1') then nextState <= loadState;
	  -- elsif, quando enable = 0 e rci = 0, pr�ximo estado recebe o estado ST4
	  elsif ((enable = '0') and (rci = '0')) then nextState <= ST4;
 	  -- else, se nada � feito, o pr�ximo estado recebe o estado atual
	  else nextState <= ST3;
	  -- fim da quarta estrutura if
	  end if;

	when ST4 =>	 -- estado ST4, equivale ao n�mero 4 no contador
	  Q   <= "0100"; -- valores de sa�da do ST4
	  rco <= '1';	 -- valor da sa�da de cascateamento
	  -- if, quando reset = 1, o pr�ximo estado � o inicial
	  if (reset = '1') then nextState <= ST0;
	  -- elsif, quando load = 1, pr�ximo estado recebe o estado
	  -- corresponte ao valor da entrada D
	  elsif (load = '1') then nextState <= loadState;
	  -- elsif, quando enable = 0 e rci = 0, pr�ximo estado recebe o estado ST5
	  elsif ((enable = '0') and (rci = '0')) then nextState <= ST5;
 	  -- else, se nada � feito, o pr�ximo estado recebe o estado atual
	  else nextState <= ST4;
	  -- fim da quinta estrutura if
	  end if;

	when ST5 =>	 -- estado ST5, equivale ao n�mero 5 no contador
	  Q   <= "0101"; -- valores de sa�da do ST5
	  rco <= '1';	 -- valor da sa�da de cascateamento
	  -- if, quando reset = 1, o pr�ximo estado � o inicial
	  if (reset = '1') then nextState <= ST0;
	  -- elsif, quando load = 1, pr�ximo estado recebe o estado
	  -- corresponte ao valor da entrada D
	  elsif (load = '1') then nextState <= loadState;
	  -- elsif, quando enable = 0 e rci = 0, pr�ximo estado recebe o estado ST6
	  elsif ((enable = '0') and (rci = '0')) then nextState <= ST6;
 	  -- else, se nada � feito, o pr�ximo estado recebe o estado atual
	  else nextState <= ST5;
	  -- fim da sexta estrutura if
	  end if;

	when ST6 =>	 -- estado ST6, equivale ao n�mero 6 no contador
	  Q   <= "0110"; -- valores de sa�da do ST6
	  rco <= '1';	 -- valor da sa�da de cascateamento
	  -- if, quando reset = 1, o pr�ximo estado � o inicial
	  if (reset = '1') then nextState <= ST0;
	  -- elsif, quando load = 1, pr�ximo estado recebe o estado
	  -- corresponte ao valor da entrada D
	  elsif (load = '1') then nextState <= loadState;
	  -- elsif, quando enable = 0 e rci = 0, pr�ximo estado recebe o estado ST7
	  elsif ((enable = '0') and (rci = '0')) then nextState <= ST7;
 	  -- else, se nada � feito, o pr�ximo estado recebe o estado atual
	  else nextState <= ST6;
	  -- fim da s�tima estrutura if
	  end if;

	when ST7 =>	 -- estado ST7, equivale ao n�mero 7 no contador
	  Q   <= "0111"; -- valores de sa�da do ST7
	  rco <= '1';	 -- valor da sa�da de cascateamento
	  -- if, quando reset = 1, o pr�ximo estado � o inicial
	  if (reset = '1') then nextState <= ST0;
	  -- elsif, quando load = 1, pr�ximo estado recebe o estado
	  -- corresponte ao valor da entrada D
	  elsif (load = '1') then nextState <= loadState;
	  -- elsif, quando enable = 0 e rci = 0, pr�ximo estado recebe o estado ST8
	  elsif ((enable = '0') and (rci = '0')) then nextState <= ST8;
 	  -- else, se nada � feito, o pr�ximo estado recebe o estado atual
	  else nextState <= ST7;
	  -- fim da oitava estrutura if
	  end if;

	when ST8 =>	 -- estado ST8, equivale ao n�mero 8 no contador
	  Q   <= "1000"; -- valores de sa�da do ST8
	  rco <= '1';	 -- valor da sa�da de cascateamento
	  -- if, quando reset = 1, o pr�ximo estado � o inicial
	  if (reset = '1') then nextState <= ST0;
	  -- elsif, quando load = 1, pr�ximo estado recebe o estado
	  -- corresponte ao valor da entrada D
	  elsif (load = '1') then nextState <= loadState;
	  -- elsif, quando enable = 0 e rci = 0, pr�ximo estado recebe o estado ST9
	  elsif ((enable = '0') and (rci = '0')) then nextState <= ST9;
 	  -- else, se nada � feito, o pr�ximo estado recebe o estado atual
	  else nextState <= ST8;
	  -- fim da nona estrutura if
	  end if;

	when ST9 =>	 -- estado ST9, equivale ao n�mero 9 no contador
	  Q   <= "1001"; -- valores de sa�da do ST9
	  rco <= '0';	 -- valor da sa�da de cascateamento, quando
	  		 -- � zero liga o pr�ximo contador
	  -- if, quando reset = 1, o pr�ximo estado � o inicial
	  if (reset = '1') then nextState <= ST0;
	  -- elsif, quando load = 1, pr�ximo estado recebe o estado
	  -- corresponte ao valor da entrada D
	  elsif (load = '1') then nextState <= loadState;
	  -- elsif, quando enable = 0 e rci = 0, pr�ximo estado recebe o estado ST0
	  elsif ((enable = '0') and (rci = '0')) then nextState <= ST0;
 	  -- else, se nada � feito, o pr�ximo estado recebe o estado atual
	  else nextState <= ST9;
	  -- fim da d�cima estrutura if
	  end if;

	when others =>	 -- when others para quando ocorrerem situa��es n�o esperadas
	  Q   <= "0000"; -- valores de sa�da do estado inicial
	  rco <= '1';	 -- valor da sa�da de cascateamento
	  -- if, quando reset = 1, o pr�ximo estado � o inicial
	  if (reset = '1') then nextState <= ST0;
	  -- elsif, quando load = 1, pr�ximo estado recebe o estado
	  -- corresponte ao valor da entrada D
	  elsif (load = '1') then nextState <= loadState;
	  -- elsif, quando enable = 0 e rci = 0, pr�ximo estado recebe o estado ST1
	  elsif ((enable = '0') and (rci = '0')) then nextState <= ST1;
 	  -- else, se nada � feito, o pr�ximo estado recebe o estado atual
	  else nextState <= ST0;
	  -- fim da d�cima primeira estrutura if
	  end if;

	-- fim da estrutura condicional(case)
	end case;

-- fim do processo combinacional
end process comb_proc;

end contador10_arch;
-- a defini��o termina por end
