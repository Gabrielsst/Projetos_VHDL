-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matrícula: 190087587
-- Data: 18/11/2020

-- **********************************************************
--   Circuito: Máquina de Mealy, implementando um semáforo:
--   	     clock  	                  Entrada 1 
--   	     ligadesliga  	          Entrada 2 
--   	     sensorA	                  Entrada 3  
--   	     sensorB	                  Entrada 4 
--   	     T60                          Entrada 5
--   	     T20	                  Entrada 6
--   	     T6	                          Entrada 7
--           T5	                          Entrada 8
--   	     resetcounter                 Saída   1 
--   	     vetor RYGsemaforoA de 3 bits Saída   2
--   	     vetor RYGsemaforoB de 3 bits Saída   3 
-- ***********************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity (Entidade)
-- pinos de entrada e saída

entity maqestados is
  port( clock        : in  STD_LOGIC;
        ligadesliga  : in  STD_LOGIC;
        sensorA      : in  STD_LOGIC;
        sensorB      : in  STD_LOGIC;
        T60          : in  STD_LOGIC;
        T20          : in  STD_LOGIC;
        T6           : in  STD_LOGIC;
        T5           : in  STD_LOGIC;
        resetcounter : out STD_LOGIC;
        RYGsemaforoA : out STD_LOGIC_VECTOR(2 downto 0);
        RYGsemaforoB : out STD_LOGIC_VECTOR(2 downto 0) );
end maqestados;

-- Architecture (Arquitetura)
-- implementações do projeto	

architecture maqestados_arch of maqestados is

-- criação de um tipo chamado estado, com 8 valores descritos abaixo
  type estado is(GR,YR,RR1,RG,RY,RR2,YY,NN);

-- criação de dois sinais do tipo estado que foi criado acima,
-- currentState(estado atual) e nextState(próximo estado)
  signal currentState,nextState : estado;

-- a definição inicia por
begin

-- processo síncrono, funciona como a memória da máquina de estado
sync_proc: process(clock)
   begin

-- if para atribuir nextState ao currentState na borda de subida do clock
     if rising_edge(clock) then 
	currentState <= nextState;
-- final da estrutura if
     end if;

-- final do processo síncrono
end process sync_proc;

-- processo combinacional, onde é feita a lógica de estado seguinte
comb_proc: process(currentState, sensorA, sensorB, T60, T20, T6, T5, ligadesliga)
   begin

-- estrutura case, olha para dentro do sinal currentState, e verifica 
-- cada um do que consideramos como os oito estados desta máquina de estado
     case currentState is 

	when GR => -- estado inicial, semáforo A está verde e semáforo B está vermelho
	   RYGsemaforoA <= "001"; -- saída do semáforo A, quando o estado é GR
	   RYGsemaforoB <= "100"; -- saída do semáforo B, quando o estado é GR
	   -- if, se ligadesliga = 1, então o semáforo está em funcionamento e irá passar 
	   -- para outra condicional if, para decidir o próximo estado
	   if(ligadesliga = '1') then 
		-- if, se der 60 segundos ou digamos que já deu 20 segundos e não há mais 
		-- carro no semáforo A, porém há carro esperando no semáforo B, então o
		-- próximo estado recebe o estado YR e resetcounter recebe 1, pois trocou 
		-- de estado
	   	if((T60 = '1') or ((T20 = '1') and (sensorB = '1') and (sensorA = '0'))) 
			then resetcounter <= '1'; nextState <= YR;
		-- se não ocorrer nada, resetcounter = 0, pois não trocou de estado e 
		-- permanece no estado atual
	   	else resetcounter <= '0'; nextState <= GR; 
		-- fim da primeira estrutura if interna
	   	end if;
	   -- else, se ligadesliga = 0, o semáforo entra em estado intermitente,
	   -- resetcounter = 1 porque troca de estado e ele vai para o estado YY
	   else resetcounter <= '1'; nextState <= YY;
	   -- fim da primeira estrutura if externa
	   end if;

	when YR => -- estado YR, semáforo A está amarelo e semáforo B está vermelho
	   RYGsemaforoA <= "010"; -- saída do semáforo A, quando o estado é YR
	   RYGsemaforoB <= "100"; -- saída do semáforo B, quando o estado é YR
	   -- if, se ligadesliga = 1, então o semáforo está em funcionamento e irá passar 
	   -- para outra condicional if, para decidir o próximo estado
	   if(ligadesliga = '1') then
		-- if, se der 6 segundos então o próximo estado recebe o estado RR1
		-- e resetcounter recebe 1, pois trocou de estado
	   	if(T6 = '1')
			then resetcounter <= '1'; nextState <= RR1;
		-- se não ocorrer nada, resetcounter = 0, pois não trocou de estado e 
		-- permanece no estado atual
	   	else resetcounter <= '0'; nextState <= YR;
		-- fim da segunda estrutura if interna
	   	end if;
	   -- else, se ligadesliga = 0, o semáforo entra em estado intermitente,
	   -- resetcounter = 1 porque troca de estado e ele vai para o estado YY
	   else resetcounter <= '1'; nextState <= YY;
	   -- fim da segunda estrutura if externa
	   end if;

	when RR1 => -- estado RR1, semáforo A está vermelho e semáforo B está vermelho 
	   RYGsemaforoA <= "100"; -- saída do semáforo A, quando o estado é RR1
	   RYGsemaforoB <= "100"; -- saída do semáforo B, quando o estado é RR1
	   -- if, se ligadesliga = 1, então o semáforo está em funcionamento e irá passar 
	   -- para outra condicional if, para decidir o próximo estado
	   if(ligadesliga = '1') then
		-- if, se der 5 segundos então o próximo estado recebe o estado RG
		-- e resetcounter recebe 1, pois trocou de estado
	   	if(T5 = '1')
			then resetcounter <= '1'; nextState <= RG;
		-- se não ocorrer nada, resetcounter = 0, pois não trocou de estado e 
		-- permanece no estado atual
	   	else resetcounter <= '0'; nextState <= RR1;
		-- fim da terceira estrutura if interna
	   	end if;
	   -- else, se ligadesliga = 0, o semáforo entra em estado intermitente,
	   -- resetcounter = 1 porque troca de estado e ele vai para o estado YY
	   else resetcounter <= '1'; nextState <= YY;
	   -- fim da terceira estrutura if externa
	   end if;

	when RG => -- estado RG, semáforo A está vermelho e semáforo B está verde 
	   RYGsemaforoA <= "100"; -- saída do semáforo A, quando o estado é RG
	   RYGsemaforoB <= "001"; -- saída do semáforo B, quando o estado é RG
	   -- if, se ligadesliga = 1, então o semáforo está em funcionamento e irá passar 
	   -- para outra condicional if, para decidir o próximo estado
    	   if(ligadesliga = '1') then
		-- if, se der 60 segundos ou digamos que já deu 20 segundos e não há mais 
		-- carro no semáforo B, porém há carro esperando no semáforo A, então o
		-- próximo estado recebe o estado RY e resetcounter recebe 1, pois trocou 
		-- de estado
	   	if((T60 = '1') or ((T20 = '1') and (sensorB = '0') and (sensorA = '1')))
			then resetcounter <= '1'; nextState <= RY;
		-- se não ocorrer nada, resetcounter = 0, pois não trocou de estado e 
		-- permanece no estado atual
	   	else resetcounter <= '0'; nextState <= RG;
		-- fim da quarta estrutura if interna
	   	end if;
	   -- else, se ligadesliga = 0, o semáforo entra em estado intermitente,
	   -- resetcounter = 1 porque troca de estado e ele vai para o estado YY
	   else resetcounter <= '1'; nextState <= YY;
	   -- fim da quarta estrutura if externa
	   end if;

	when RY => -- estado RY, semáforo A está vermelho e semáforo B está amarelo 
	   RYGsemaforoA <= "100"; -- saída do semáforo A, quando o estado é RY
	   RYGsemaforoB <= "010"; -- saída do semáforo B, quando o estado é RY
	   -- if, se ligadesliga = 1, então o semáforo está em funcionamento e irá passar 
	   -- para outra condicional if, para decidir o próximo estado
	   if(ligadesliga = '1') then
		-- if, se der 6 segundos então o próximo estado recebe o estado RR2
		-- e resetcounter recebe 1, pois trocou de estado
	   	if(T6 = '1')
			then resetcounter <= '1'; nextState <= RR2;
		-- se não ocorrer nada, resetcounter = 0, pois não trocou de estado e 
		-- permanece no estado atual
	  	else resetcounter <= '0'; nextState <= RY;
		-- fim da quinta estrutura if interna
	   	end if;
	   -- else, se ligadesliga = 0, o semáforo entra em estado intermitente,
	   -- resetcounter = 1 porque troca de estado e ele vai para o estado YY
	   else resetcounter <= '1'; nextState <= YY;
	   -- fim da quinta estrutura if externa
	   end if;

	when RR2 => -- estado RR2, semáforo A está vermelho e semáforo B está vermelho 
	   RYGsemaforoA <= "100"; -- saída do semáforo A, quando o estado é RR2
	   RYGsemaforoB <= "100"; -- saída do semáforo B, quando o estado é RR2
	   -- if, se ligadesliga = 1, então o semáforo está em funcionamento e irá passar 
	   -- para outra condicional if, para decidir o próximo estado
	   if(ligadesliga = '1') then
		-- if, se der 5 segundos então o próximo estado recebe o estado GR
		-- e resetcounter recebe 1, pois trocou de estado
	   	if(T5 = '1')
			then resetcounter <= '1'; nextState <= GR;
		-- se não ocorrer nada, resetcounter = 0, pois não trocou de estado e 
		-- permanece no estado atual
	   	else resetcounter <= '0'; nextState <= RR2;
		-- fim da sexta estrutura if interna
	   	end if;
	   -- else, se ligadesliga = 0, o semáforo entra em estado intermitente,
	   -- resetcounter = 1 porque troca de estado e ele vai para o estado YY
	   else resetcounter <= '1'; nextState <= YY;
	   -- fim da sexta estrutura if externa
	   end if;

	when YY => -- estado YY, estado intermitente, semáforo A está amarelo e
		   -- semáforo B está amarelo 
	   RYGsemaforoA <= "010"; -- saída do semáforo A, quando o estado é YY
	   RYGsemaforoB <= "010"; -- saída do semáforo B, quando o estado é YY
	   -- if, se ligadesliga = 1, então o semáforo saiu do estado intermitente
           -- e o próximo estado será GR e resetcounter = 1 pois trocou de estado
	   if(ligadesliga = '1') 
		then resetcounter <= '1'; nextState <= GR;
	   -- elsif, se ligadesliga = 0, então o semáforo permanece em estado intermitente
           -- e o próximo estado será NN e resetcounter = 1 pois trocou de estado		
	   elsif(ligadesliga = '0')
		then resetcounter <= '1'; nextState <= NN;
	   -- else, se não ocorrer nada, resetcounter = 0, pois não trocou de estado e 
	   -- permanece no estado atual
	   else resetcounter <= '0'; nextState <= YY;
	   -- fim da sétima estrutura if externa
	   end if;

	when NN => -- estado NN, estado intermitente, ambos semáforos estão apagados/desligados 
	   RYGsemaforoA <= "000"; -- saída do semáforo A, quando o estado é NN
	   RYGsemaforoB <= "000"; -- saída do semáforo B, quando o estado é NN
	   -- if, se ligadesliga = 1, então o semáforo saiu do estado intermitente
           -- e o próximo estado será GR e resetcounter = 1 pois trocou de estado
	   if(ligadesliga = '1') 
		then resetcounter <= '1'; nextState <= GR;
	   -- else, se ligadesliga = 0, então o semáforo permanece em estado intermitente
           -- e o próximo estado será YY e resetcounter = 1 pois trocou de estado
	   else resetcounter <= '1'; nextState <= YY;
	   -- fim da oitava estrutura if externa
	   end if;

	-- fim da estrutura condicional(case) 
	end case;

-- fim do processo combinacional
end process comb_proc;

end maqestados_arch;
-- a definição termina por end