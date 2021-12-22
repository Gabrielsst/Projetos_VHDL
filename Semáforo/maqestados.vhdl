-- Universidade de Bras�lia
-- Laborat�rio de Sistemas Digitais
-- Autor: Gabriel Santos Teixeira	Matr�cula: 190087587
-- Data: 18/11/2020

-- **********************************************************
--   Circuito: M�quina de Mealy, implementando um sem�foro:
--   	     clock  	                  Entrada 1 
--   	     ligadesliga  	          Entrada 2 
--   	     sensorA	                  Entrada 3  
--   	     sensorB	                  Entrada 4 
--   	     T60                          Entrada 5
--   	     T20	                  Entrada 6
--   	     T6	                          Entrada 7
--           T5	                          Entrada 8
--   	     resetcounter                 Sa�da   1 
--   	     vetor RYGsemaforoA de 3 bits Sa�da   2
--   	     vetor RYGsemaforoB de 3 bits Sa�da   3 
-- ***********************************************************

-- Package (Pacote)
-- constantes e bibliotecas

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity (Entidade)
-- pinos de entrada e sa�da

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
-- implementa��es do projeto	

architecture maqestados_arch of maqestados is

-- cria��o de um tipo chamado estado, com 8 valores descritos abaixo
  type estado is(GR,YR,RR1,RG,RY,RR2,YY,NN);

-- cria��o de dois sinais do tipo estado que foi criado acima,
-- currentState(estado atual) e nextState(pr�ximo estado)
  signal currentState,nextState : estado;

-- a defini��o inicia por
begin

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
comb_proc: process(currentState, sensorA, sensorB, T60, T20, T6, T5, ligadesliga)
   begin

-- estrutura case, olha para dentro do sinal currentState, e verifica 
-- cada um do que consideramos como os oito estados desta m�quina de estado
     case currentState is 

	when GR => -- estado inicial, sem�foro A est� verde e sem�foro B est� vermelho
	   RYGsemaforoA <= "001"; -- sa�da do sem�foro A, quando o estado � GR
	   RYGsemaforoB <= "100"; -- sa�da do sem�foro B, quando o estado � GR
	   -- if, se ligadesliga = 1, ent�o o sem�foro est� em funcionamento e ir� passar 
	   -- para outra condicional if, para decidir o pr�ximo estado
	   if(ligadesliga = '1') then 
		-- if, se der 60 segundos ou digamos que j� deu 20 segundos e n�o h� mais 
		-- carro no sem�foro A, por�m h� carro esperando no sem�foro B, ent�o o
		-- pr�ximo estado recebe o estado YR e resetcounter recebe 1, pois trocou 
		-- de estado
	   	if((T60 = '1') or ((T20 = '1') and (sensorB = '1') and (sensorA = '0'))) 
			then resetcounter <= '1'; nextState <= YR;
		-- se n�o ocorrer nada, resetcounter = 0, pois n�o trocou de estado e 
		-- permanece no estado atual
	   	else resetcounter <= '0'; nextState <= GR; 
		-- fim da primeira estrutura if interna
	   	end if;
	   -- else, se ligadesliga = 0, o sem�foro entra em estado intermitente,
	   -- resetcounter = 1 porque troca de estado e ele vai para o estado YY
	   else resetcounter <= '1'; nextState <= YY;
	   -- fim da primeira estrutura if externa
	   end if;

	when YR => -- estado YR, sem�foro A est� amarelo e sem�foro B est� vermelho
	   RYGsemaforoA <= "010"; -- sa�da do sem�foro A, quando o estado � YR
	   RYGsemaforoB <= "100"; -- sa�da do sem�foro B, quando o estado � YR
	   -- if, se ligadesliga = 1, ent�o o sem�foro est� em funcionamento e ir� passar 
	   -- para outra condicional if, para decidir o pr�ximo estado
	   if(ligadesliga = '1') then
		-- if, se der 6 segundos ent�o o pr�ximo estado recebe o estado RR1
		-- e resetcounter recebe 1, pois trocou de estado
	   	if(T6 = '1')
			then resetcounter <= '1'; nextState <= RR1;
		-- se n�o ocorrer nada, resetcounter = 0, pois n�o trocou de estado e 
		-- permanece no estado atual
	   	else resetcounter <= '0'; nextState <= YR;
		-- fim da segunda estrutura if interna
	   	end if;
	   -- else, se ligadesliga = 0, o sem�foro entra em estado intermitente,
	   -- resetcounter = 1 porque troca de estado e ele vai para o estado YY
	   else resetcounter <= '1'; nextState <= YY;
	   -- fim da segunda estrutura if externa
	   end if;

	when RR1 => -- estado RR1, sem�foro A est� vermelho e sem�foro B est� vermelho 
	   RYGsemaforoA <= "100"; -- sa�da do sem�foro A, quando o estado � RR1
	   RYGsemaforoB <= "100"; -- sa�da do sem�foro B, quando o estado � RR1
	   -- if, se ligadesliga = 1, ent�o o sem�foro est� em funcionamento e ir� passar 
	   -- para outra condicional if, para decidir o pr�ximo estado
	   if(ligadesliga = '1') then
		-- if, se der 5 segundos ent�o o pr�ximo estado recebe o estado RG
		-- e resetcounter recebe 1, pois trocou de estado
	   	if(T5 = '1')
			then resetcounter <= '1'; nextState <= RG;
		-- se n�o ocorrer nada, resetcounter = 0, pois n�o trocou de estado e 
		-- permanece no estado atual
	   	else resetcounter <= '0'; nextState <= RR1;
		-- fim da terceira estrutura if interna
	   	end if;
	   -- else, se ligadesliga = 0, o sem�foro entra em estado intermitente,
	   -- resetcounter = 1 porque troca de estado e ele vai para o estado YY
	   else resetcounter <= '1'; nextState <= YY;
	   -- fim da terceira estrutura if externa
	   end if;

	when RG => -- estado RG, sem�foro A est� vermelho e sem�foro B est� verde 
	   RYGsemaforoA <= "100"; -- sa�da do sem�foro A, quando o estado � RG
	   RYGsemaforoB <= "001"; -- sa�da do sem�foro B, quando o estado � RG
	   -- if, se ligadesliga = 1, ent�o o sem�foro est� em funcionamento e ir� passar 
	   -- para outra condicional if, para decidir o pr�ximo estado
    	   if(ligadesliga = '1') then
		-- if, se der 60 segundos ou digamos que j� deu 20 segundos e n�o h� mais 
		-- carro no sem�foro B, por�m h� carro esperando no sem�foro A, ent�o o
		-- pr�ximo estado recebe o estado RY e resetcounter recebe 1, pois trocou 
		-- de estado
	   	if((T60 = '1') or ((T20 = '1') and (sensorB = '0') and (sensorA = '1')))
			then resetcounter <= '1'; nextState <= RY;
		-- se n�o ocorrer nada, resetcounter = 0, pois n�o trocou de estado e 
		-- permanece no estado atual
	   	else resetcounter <= '0'; nextState <= RG;
		-- fim da quarta estrutura if interna
	   	end if;
	   -- else, se ligadesliga = 0, o sem�foro entra em estado intermitente,
	   -- resetcounter = 1 porque troca de estado e ele vai para o estado YY
	   else resetcounter <= '1'; nextState <= YY;
	   -- fim da quarta estrutura if externa
	   end if;

	when RY => -- estado RY, sem�foro A est� vermelho e sem�foro B est� amarelo 
	   RYGsemaforoA <= "100"; -- sa�da do sem�foro A, quando o estado � RY
	   RYGsemaforoB <= "010"; -- sa�da do sem�foro B, quando o estado � RY
	   -- if, se ligadesliga = 1, ent�o o sem�foro est� em funcionamento e ir� passar 
	   -- para outra condicional if, para decidir o pr�ximo estado
	   if(ligadesliga = '1') then
		-- if, se der 6 segundos ent�o o pr�ximo estado recebe o estado RR2
		-- e resetcounter recebe 1, pois trocou de estado
	   	if(T6 = '1')
			then resetcounter <= '1'; nextState <= RR2;
		-- se n�o ocorrer nada, resetcounter = 0, pois n�o trocou de estado e 
		-- permanece no estado atual
	  	else resetcounter <= '0'; nextState <= RY;
		-- fim da quinta estrutura if interna
	   	end if;
	   -- else, se ligadesliga = 0, o sem�foro entra em estado intermitente,
	   -- resetcounter = 1 porque troca de estado e ele vai para o estado YY
	   else resetcounter <= '1'; nextState <= YY;
	   -- fim da quinta estrutura if externa
	   end if;

	when RR2 => -- estado RR2, sem�foro A est� vermelho e sem�foro B est� vermelho 
	   RYGsemaforoA <= "100"; -- sa�da do sem�foro A, quando o estado � RR2
	   RYGsemaforoB <= "100"; -- sa�da do sem�foro B, quando o estado � RR2
	   -- if, se ligadesliga = 1, ent�o o sem�foro est� em funcionamento e ir� passar 
	   -- para outra condicional if, para decidir o pr�ximo estado
	   if(ligadesliga = '1') then
		-- if, se der 5 segundos ent�o o pr�ximo estado recebe o estado GR
		-- e resetcounter recebe 1, pois trocou de estado
	   	if(T5 = '1')
			then resetcounter <= '1'; nextState <= GR;
		-- se n�o ocorrer nada, resetcounter = 0, pois n�o trocou de estado e 
		-- permanece no estado atual
	   	else resetcounter <= '0'; nextState <= RR2;
		-- fim da sexta estrutura if interna
	   	end if;
	   -- else, se ligadesliga = 0, o sem�foro entra em estado intermitente,
	   -- resetcounter = 1 porque troca de estado e ele vai para o estado YY
	   else resetcounter <= '1'; nextState <= YY;
	   -- fim da sexta estrutura if externa
	   end if;

	when YY => -- estado YY, estado intermitente, sem�foro A est� amarelo e
		   -- sem�foro B est� amarelo 
	   RYGsemaforoA <= "010"; -- sa�da do sem�foro A, quando o estado � YY
	   RYGsemaforoB <= "010"; -- sa�da do sem�foro B, quando o estado � YY
	   -- if, se ligadesliga = 1, ent�o o sem�foro saiu do estado intermitente
           -- e o pr�ximo estado ser� GR e resetcounter = 1 pois trocou de estado
	   if(ligadesliga = '1') 
		then resetcounter <= '1'; nextState <= GR;
	   -- elsif, se ligadesliga = 0, ent�o o sem�foro permanece em estado intermitente
           -- e o pr�ximo estado ser� NN e resetcounter = 1 pois trocou de estado		
	   elsif(ligadesliga = '0')
		then resetcounter <= '1'; nextState <= NN;
	   -- else, se n�o ocorrer nada, resetcounter = 0, pois n�o trocou de estado e 
	   -- permanece no estado atual
	   else resetcounter <= '0'; nextState <= YY;
	   -- fim da s�tima estrutura if externa
	   end if;

	when NN => -- estado NN, estado intermitente, ambos sem�foros est�o apagados/desligados 
	   RYGsemaforoA <= "000"; -- sa�da do sem�foro A, quando o estado � NN
	   RYGsemaforoB <= "000"; -- sa�da do sem�foro B, quando o estado � NN
	   -- if, se ligadesliga = 1, ent�o o sem�foro saiu do estado intermitente
           -- e o pr�ximo estado ser� GR e resetcounter = 1 pois trocou de estado
	   if(ligadesliga = '1') 
		then resetcounter <= '1'; nextState <= GR;
	   -- else, se ligadesliga = 0, ent�o o sem�foro permanece em estado intermitente
           -- e o pr�ximo estado ser� YY e resetcounter = 1 pois trocou de estado
	   else resetcounter <= '1'; nextState <= YY;
	   -- fim da oitava estrutura if externa
	   end if;

	-- fim da estrutura condicional(case) 
	end case;

-- fim do processo combinacional
end process comb_proc;

end maqestados_arch;
-- a defini��o termina por end