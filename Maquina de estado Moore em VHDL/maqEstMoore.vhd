-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 03/11/2020

-- *********************************************************************
--   Circuito: Máquina de Estado Moore, que implementa o funcionamento 
--      	     de uma máquina de refrigerante:
--		     Vetor A de 2 bits	   Entrada 1 
--		     CLK   		   Entrada 2 
--		     RST    		   Entrada 3
--		     R   		   Saída   1
--		     D25c     		   Saída   2
--		     D50c     		   Saída   3
-- *********************************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity (Entidade)
-- pinos de entrada e saída

entity MEM is port(
A	      :in  std_logic_vector(1 downto 0);
CLK, RST      :in  std_logic;
R, D25c, D50c :out std_logic );
end MEM;

-- Architecture (Arquitetura)
-- implementações do projeto 

architecture MEM_arch of MEM is 

-- criação de um tipo chamado estado, com 9 valores descritos abaixo
type estado is(Inicio, c25, c50, c75, c100, c125, d25, d50, d75);

-- criação de dois sinais do tipo estado que foi criado acima,
-- CS de currentState(estado atual) e NS de nextState (próximo estado) 
signal CS, NS: estado;

-- a definição inicia por 
begin

-- processo síncrono, onde a máquina de estado guarda os valores
-- de estados passados, em outras palavras é a memória da máquina 
-- de estado
sp: process(CLK, RST)
begin

-- if para reset, quando RST = 1, CS recebe o valor do estado inicial
  if(RST = '1') then 
     CS <= Inicio;
-- elsif, no qual é atribuído NS à CS, quando o Clock se encontra
-- na borda de subida
  elsif rising_edge(CLK) then
     CS <= NS;
-- final da estrutura if
  end if;

-- final do processo síncrono
end process sp;

-- processo combinacional, onde é determinado o que será atribuído 
-- ao estado seguinte(NS), e por consequência à saída, por se tratar 
-- de uma máquina de estado de Moore
cp: process(CS, A)
begin

-- estrutura case, que olha para dentro do sinal CS, e verifica cada um do
-- que consideramos como os nove estados desta máquina de estado
case CS is 
  when Inicio => -- estado inicial
    R    <= '0'; 
    D25c <= '0';
    D50c <= '0'; -- valores de saída do estado inicial

-- if's que determinam o valor de NS, de acordo com o valor do vetor A 
   if (A = "01") then 
 -- quando A = 01, NS recebe c25, que é quando é colocado 25 centavos na máquina
       NS <= c25;
    elsif (A="10") then
-- quando A = 10, NS recebe c50, que é quando é colocado 50 centavos na máquina
       NS <= c50; 
-- quando nada é feito, ou para o caso inicial que não houve depósito de moeda
-- NS será portanto o próprio estado inicial
    else 
       NS <= Inicio;
-- fim da primeira estrutura if
    end if;
  when c25 => -- estado c25, quando há 25 centavos na máquina
    R    <= '0';
    D25c <= '0';
    D50c <= '0'; -- valores de saída do estado c25

-- if's que determinam o valor de NS, de acordo com o valor do vetor A
    if (A = "01") then
       NS <= c50; -- NS recebe 25 centavos, indo para o estado c50
    elsif (A = "10") then
       NS <= c75; -- NS recebe 50 centavos, indo para o estado c75
    elsif (A = "11") then
       NS <= d25; -- NS vai para o estado d25, que devolve 25 centavos, pois o pedido
                  -- foi cancelado
    else 
       NS <= c25; -- se não é feito nada, a máquina permanece com 25 centavos
-- fim da segunda estrutura if
    end if;
  when c50 => -- estado c50, quando há 50 centavos na máquina 
    R    <= '0';
    D25c <= '0';
    D50c <= '0'; -- valores de saída do estado c50

-- if's que determinam o valor de NS, de acordo com o valor do vetor A
    if (A = "01") then
       NS <= c75;  -- NS recebe 25 centavos, indo para o estado c75
    elsif (A = "10") then
       NS <= c100; -- NS recebe 50 centavos, indo para o estado c100
    elsif (A = "11") then
       NS <= d50;  -- devolve 50 centavos do pedido que foi cancelado
    else 
       NS <= c50; -- nada é feito, máquina mantém estado atual
-- fim da terceira estrutura if
    end if;
  when c75 => -- estado c75, há 75 centavos na máquina
    R    <= '0';
    D25c <= '0';
    D50c <= '0'; -- valores de saída do estado c50

-- if's que determinam o valor de NS, de acordo com o valor do vetor A
    if (A = "01") then
       NS <= c100; -- NS recebe 25 centavos, indo para o estado c100
    elsif (A = "10") then
       NS <= c125; -- NS recebe 50 centavos, indo para o estado c120a
    elsif (A = "11") then
       NS <= d75;  -- devolve 75 centavos do pedido que foi cancelado
    else 
       NS <= c75; -- nada é feito, máquina mantém estado atual
-- fim da quarta estrutura if
    end if;  
  when c100 => -- estado c100, a máquina completa 100 centavos ou 1 real, "fecha a 
               -- compra anterior e inicia uma nova", começando do valor inicial ou
               -- se já houver sido depositado alguma moeda, do respectivo valor de 
               -- tal moeda
    R    <= '1'; -- libera um refrigerante
    D25c <= '0';
    D50c <= '0'; -- valores de saída do estado c100

-- if's que determinam o valor de NS, de acordo com o valor do vetor A
    if (A = "01") then
       NS <= c25; -- NS recebe 25 centavos, indo para o estado c25
    elsif (A = "10") then
       NS <= c50; -- NS recebe 50 centavos, indo para o estado c50
    else 
       NS <= Inicio; -- não há o que ser devolvido de um pedido que não foi feito
                     -- pois como dito anteriormente, "a máquina fecha a compra
                     -- anterior e inicia uma nova". Logo, a máquina tanto para 
                     -- A = 11 quanto A = 00, permanece em seu valor inicial
-- fim da quinta estrutura if
    end if;  
  when c125 => -- estado c125, a máquina completa 125 centavos ou 1 real e 25 centavos,
               -- "fecha a compra anterior e inicia uma nova", devolvendo os 25 centavos, 
               -- começando do valor inicial ou se já houver sido depositado alguma 
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
       NS <= Inicio; -- já tendo devolvido os 25, e não tendo outro valor depositado
                     -- a máquina tanto em A = 00 quanto A = 11, permanece em seu valor inicial
-- fim da sexta estrutura if
    end if;
  when d25 => -- estado d25, quando é devolvido os 25 centavos em caso de cancelamento do pedido
    R    <= '0';
    D25c <= '1'; -- devolve 25 centavos
    D50c <= '0';

-- if's que determinam o valor de NS, de acordo com o valor do vetor A
    if (A = "01") then
       NS <= c25; -- NS recebe 25 centavos, indo para o estado c25
    elsif (A = "10") then
       NS <= c50; -- NS recebe 50 centavos, indo para o estado c50
    else 
       NS <= Inicio; -- já tendo devolvido os 25, e não tendo outro valor depositado
                     -- a máquina tanto em A = 00 quanto A = 11, permanece em seu valor inicial
-- fim da sétima estrutura if
    end if;
  when d50 => -- estado d50, quando é devolvido os 50 centavos em caso de cancelamento do pedido
    R    <= '0';
    D25c <= '0';
    D50c <= '1'; -- devolve 50 centavos

-- if's que determinam o valor de NS, de acordo com o valor do vetor A
    if (A = "01") then
       NS <= c25; -- NS recebe 25 centavos, indo para o estado c25
    elsif (A = "10") then
       NS <= c50; -- NS recebe 50 centavos, indo para o estado c50
    else 
       NS <= Inicio; -- já tendo devolvido os 50, e não tendo outro valor depositado
                     -- a máquina tanto em A = 00 quanto A = 11, permanece em seu valor inicial
-- fim da oitava estrutura if
    end if;
  when d75 => -- estado d75, quando é devolvido os 75 centavos em caso de cancelamento do pedido
    R    <= '0';
    D25c <= '1'; -- devolve 25 centavos
    D50c <= '1'; -- devolve 50 centavos
    if (A = "01") then
       NS <= c25; -- NS recebe 25 centavos, indo para o estado c25
    elsif (A = "10") then
       NS <= c50; -- NS recebe 50 centavos, indo para o estado c25
    else 
       NS <= Inicio; -- já tendo devolvido os 75, e não tendo outro valor depositado
                     -- a máquina tanto em A = 00 quanto A = 11, permanece em seu valor inicial
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

-- a definição termina por end
