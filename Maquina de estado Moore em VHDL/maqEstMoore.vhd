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

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity (Entidade)
-- pinos de entrada e sa�da

entity MEM is port(
A	      :in  std_logic_vector(1 downto 0);
CLK, RST      :in  std_logic;
R, D25c, D50c :out std_logic );
end MEM;

-- Architecture (Arquitetura)
-- implementa��es do projeto 

architecture MEM_arch of MEM is 

-- cria��o de um tipo chamado estado, com 9 valores descritos abaixo
type estado is(Inicio, c25, c50, c75, c100, c125, d25, d50, d75);

-- cria��o de dois sinais do tipo estado que foi criado acima,
-- CS de currentState(estado atual) e NS de nextState (pr�ximo estado) 
signal CS, NS: estado;

-- a defini��o inicia por 
begin

-- processo s�ncrono, onde a m�quina de estado guarda os valores
-- de estados passados, em outras palavras � a mem�ria da m�quina 
-- de estado
sp: process(CLK, RST)
begin

-- if para reset, quando RST = 1, CS recebe o valor do estado inicial
  if(RST = '1') then 
     CS <= Inicio;
-- elsif, no qual � atribu�do NS � CS, quando o Clock se encontra
-- na borda de subida
  elsif rising_edge(CLK) then
     CS <= NS;
-- final da estrutura if
  end if;

-- final do processo s�ncrono
end process sp;

-- processo combinacional, onde � determinado o que ser� atribu�do 
-- ao estado seguinte(NS), e por consequ�ncia � sa�da, por se tratar 
-- de uma m�quina de estado de Moore
cp: process(CS, A)
begin

-- estrutura case, que olha para dentro do sinal CS, e verifica cada um do
-- que consideramos como os nove estados desta m�quina de estado
case CS is 
  when Inicio => -- estado inicial
    R    <= '0'; 
    D25c <= '0';
    D50c <= '0'; -- valores de sa�da do estado inicial

-- if's que determinam o valor de NS, de acordo com o valor do vetor A 
   if (A = "01") then 
 -- quando A = 01, NS recebe c25, que � quando � colocado 25 centavos na m�quina
       NS <= c25;
    elsif (A="10") then
-- quando A = 10, NS recebe c50, que � quando � colocado 50 centavos na m�quina
       NS <= c50; 
-- quando nada � feito, ou para o caso inicial que n�o houve dep�sito de moeda
-- NS ser� portanto o pr�prio estado inicial
    else 
       NS <= Inicio;
-- fim da primeira estrutura if
    end if;
  when c25 => -- estado c25, quando h� 25 centavos na m�quina
    R    <= '0';
    D25c <= '0';
    D50c <= '0'; -- valores de sa�da do estado c25

-- if's que determinam o valor de NS, de acordo com o valor do vetor A
    if (A = "01") then
       NS <= c50; -- NS recebe 25 centavos, indo para o estado c50
    elsif (A = "10") then
       NS <= c75; -- NS recebe 50 centavos, indo para o estado c75
    elsif (A = "11") then
       NS <= d25; -- NS vai para o estado d25, que devolve 25 centavos, pois o pedido
                  -- foi cancelado
    else 
       NS <= c25; -- se n�o � feito nada, a m�quina permanece com 25 centavos
-- fim da segunda estrutura if
    end if;
  when c50 => -- estado c50, quando h� 50 centavos na m�quina 
    R    <= '0';
    D25c <= '0';
    D50c <= '0'; -- valores de sa�da do estado c50

-- if's que determinam o valor de NS, de acordo com o valor do vetor A
    if (A = "01") then
       NS <= c75;  -- NS recebe 25 centavos, indo para o estado c75
    elsif (A = "10") then
       NS <= c100; -- NS recebe 50 centavos, indo para o estado c100
    elsif (A = "11") then
       NS <= d50;  -- devolve 50 centavos do pedido que foi cancelado
    else 
       NS <= c50; -- nada � feito, m�quina mant�m estado atual
-- fim da terceira estrutura if
    end if;
  when c75 => -- estado c75, h� 75 centavos na m�quina
    R    <= '0';
    D25c <= '0';
    D50c <= '0'; -- valores de sa�da do estado c50

-- if's que determinam o valor de NS, de acordo com o valor do vetor A
    if (A = "01") then
       NS <= c100; -- NS recebe 25 centavos, indo para o estado c100
    elsif (A = "10") then
       NS <= c125; -- NS recebe 50 centavos, indo para o estado c120a
    elsif (A = "11") then
       NS <= d75;  -- devolve 75 centavos do pedido que foi cancelado
    else 
       NS <= c75; -- nada � feito, m�quina mant�m estado atual
-- fim da quarta estrutura if
    end if;  
  when c100 => -- estado c100, a m�quina completa 100 centavos ou 1 real, "fecha a 
               -- compra anterior e inicia uma nova", come�ando do valor inicial ou
               -- se j� houver sido depositado alguma moeda, do respectivo valor de 
               -- tal moeda
    R    <= '1'; -- libera um refrigerante
    D25c <= '0';
    D50c <= '0'; -- valores de sa�da do estado c100

-- if's que determinam o valor de NS, de acordo com o valor do vetor A
    if (A = "01") then
       NS <= c25; -- NS recebe 25 centavos, indo para o estado c25
    elsif (A = "10") then
       NS <= c50; -- NS recebe 50 centavos, indo para o estado c50
    else 
       NS <= Inicio; -- n�o h� o que ser devolvido de um pedido que n�o foi feito
                     -- pois como dito anteriormente, "a m�quina fecha a compra
                     -- anterior e inicia uma nova". Logo, a m�quina tanto para 
                     -- A = 11 quanto A = 00, permanece em seu valor inicial
-- fim da quinta estrutura if
    end if;  
  when c125 => -- estado c125, a m�quina completa 125 centavos ou 1 real e 25 centavos,
               -- "fecha a compra anterior e inicia uma nova", devolvendo os 25 centavos, 
               -- come�ando do valor inicial ou se j� houver sido depositado alguma 
               -- moeda, do respectivo valor de tal moeda
    R    <= '1'; -- libera o refrigerante
    D25c <= '1'; -- devolve os 25 centavos
    D50c <= '0';

-- if's que determinam o valor de NS, de acordo com o valor do vetor A
    if (A = "01") then
       NS <= c25; -- NS recebe 25 centavos, indo para o estado c25
    elsif (A = "10") then
       NS <= c50; -- NS recebe 50 centavos, indo para o estado c50
    else
       NS <= Inicio; -- j� tendo devolvido os 25, e n�o tendo outro valor depositado
                     -- a m�quina tanto em A = 00 quanto A = 11, permanece em seu valor inicial
-- fim da sexta estrutura if
    end if;
  when d25 => -- estado d25, quando � devolvido os 25 centavos em caso de cancelamento do pedido
    R    <= '0';
    D25c <= '1'; -- devolve 25 centavos
    D50c <= '0';

-- if's que determinam o valor de NS, de acordo com o valor do vetor A
    if (A = "01") then
       NS <= c25; -- NS recebe 25 centavos, indo para o estado c25
    elsif (A = "10") then
       NS <= c50; -- NS recebe 50 centavos, indo para o estado c50
    else 
       NS <= Inicio; -- j� tendo devolvido os 25, e n�o tendo outro valor depositado
                     -- a m�quina tanto em A = 00 quanto A = 11, permanece em seu valor inicial
-- fim da s�tima estrutura if
    end if;
  when d50 => -- estado d50, quando � devolvido os 50 centavos em caso de cancelamento do pedido
    R    <= '0';
    D25c <= '0';
    D50c <= '1'; -- devolve 50 centavos

-- if's que determinam o valor de NS, de acordo com o valor do vetor A
    if (A = "01") then
       NS <= c25; -- NS recebe 25 centavos, indo para o estado c25
    elsif (A = "10") then
       NS <= c50; -- NS recebe 50 centavos, indo para o estado c50
    else 
       NS <= Inicio; -- j� tendo devolvido os 50, e n�o tendo outro valor depositado
                     -- a m�quina tanto em A = 00 quanto A = 11, permanece em seu valor inicial
-- fim da oitava estrutura if
    end if;
  when d75 => -- estado d75, quando � devolvido os 75 centavos em caso de cancelamento do pedido
    R    <= '0';
    D25c <= '1'; -- devolve 25 centavos
    D50c <= '1'; -- devolve 50 centavos
    if (A = "01") then
       NS <= c25; -- NS recebe 25 centavos, indo para o estado c25
    elsif (A = "10") then
       NS <= c50; -- NS recebe 50 centavos, indo para o estado c25
    else 
       NS <= Inicio; -- j� tendo devolvido os 75, e n�o tendo outro valor depositado
                     -- a m�quina tanto em A = 00 quanto A = 11, permanece em seu valor inicial
-- fim da nona estrutura if
    end if;

-- para outros casos quaiquer
  when others => 
    R    <= '0';
    D25c <= '0';
    D50c <= '0';
    NS <= Inicio;
  end case;

-- fim do processo combinacional
end process cp; 

end MEM_arch;

-- a defini��o termina por end
