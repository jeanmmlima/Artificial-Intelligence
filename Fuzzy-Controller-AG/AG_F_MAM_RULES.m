%% Algoritmo Gen?tico para Otimiza??o de um Controlador Fuzzy mamdani
%
%-------------------------------------------------------------------------%
% Otimiza funções de pertinencia e regras
%-------------------------------------------------------------------------%

% Parametros da planta
L0 = [0;0];
a1 = 0.178;
a2 = a1+500e-5;
A1 = 15.518;
%A2 = A1 + 3e-5;
A2 = A1 + 3e-5;
Km = 4.6;
g = 981;
%%
% Leitura dos parametros do Controlador Fuzzy
Fuzzy = readfis('Fuzzy');
NumIn = getfis(Fuzzy,'NumInputs');
for i = 1:NumIn
    NumMFsIn(i) = getfis(Fuzzy, 'input', i, 'NumMFs');
    RangeIn(i,:) = getfis(Fuzzy, 'input', i, 'Range');
end
NumOut = getfis(Fuzzy,'NumOutputs');
for i = 1:NumOut
    NumMFsOut(i) = getfis(Fuzzy, 'output', i, 'NumMFs');
    RangeOut(i,:) = getfis(Fuzzy, 'output', i, 'Range');
    %RangeOut(i,:) = [-2.5 2.5];
end
limites = [RangeIn' RangeOut']';
NumRules = length(Fuzzy.rule);
NumBinForRule = 3;

% Declara??o dos parametros da popula??o
disp(' ')
disp('Para inicializa??o da popula??o, temos duas op??es:')
disp(' ')
disp('     1 -> Inicializa um nova popula??o aleatoriamente;')
disp('     2 -> Continua a otimiza??o a partir de uma popula??o salva em arquivo;')
disp('        Nesse caso, precisa existir um arquivo chamado ultima_populacao.mat')
disp(' ')
initpop = -2;
while(initpop < 1 | initpop > 2)
    initpop = input('Qual sua op??o de inicializa??o? (1 ou 2) ');
end
if initpop == 1
    disp(' ')
    numind = input('Entre com a quantidade de indiv?duos ');
end
disp(' ')
maxger = input('Entre com o n?mero m?ximo de gera??es ');
percentmut = -2; 
while(percentmut < 0 | percentmut > 10)
    disp(' ')
    pmut = input('Entre com a probabilidade percentual de um gene sofrer mutacao [0% - 10%] ');
    percentmut = pmut / 100;
end
disp(' ')
alfa1 = input('Entre com o valor de alpha1 ');
disp(' ')
alfa2 = input('Entre com o valor de alpha2 ');
disp(' ')
alfa3 = input('Entre com o valor de alpha3 ');
disp(' ')
%a = input('Entre com o valor de a ');
%disp(' ')
%b = input('Entre com o valor de b ');
%disp(' ')
pause(.1)
% Primeira Gera??o
ger = 1;
tamparin = [9 9];
tamparout = 15;
tamparules = 9;
%tamparout = 21;
if initpop == 1
    disp(['Inicializando AG. Criando gera??o: ' num2str(ger) ' de ' num2str(maxger) '  . . . . . .'])
    disp(' ')
    for ind = 1:numind
        for i = 1:NumIn
            PMFIn(i,:,ind) = sort(RangeIn(i,1) + (RangeIn(i,2)-RangeIn(i,1)).*rand(1,tamparin(i)));
        end
        for i = 1:NumOut
            PMFOut(i,:,ind) = sort(RangeOut(i,1) + (RangeOut(i,2)-RangeOut(i,1)).*rand(1,tamparout));
        end
        Rules(1,:,ind) = reshape(dec2bin(round((NumMFsOut-1)*rand(1,9)+1),3)',[1,27]);
        for i=1:27
            Rules_int(1,i,ind) = bin2dec(Rules(1,i,ind));
        end
        cromossomo(ind,:,ger) = [PMFIn(1,:,ind) PMFIn(2,:,ind) PMFOut(1,:,ind) Rules_int(1,:,ind)];
    end
    tamcromo = length(cromossomo(1,:,1));
else
    disp(['Inicializando AG. Carregando gera??o: ' num2str(ger) ' de ' num2str(maxger) '  . . . . . .'])
    disp(' ')
    load ultima_populacao;
    cromossomo(:,:,ger) = ultpop;
    [numind tamcromo] = size(ultpop);
    clear ultpop;
end

%%%% FORCANDO CROMOSSOMO %%%%%

%ind_pos = round((ind-1)*rand)+1;
in1 = [-1.329 6.651 10.63 14.63 15 15.3 19.37 24.6 33.9]; 
in2 = [-3.062 5.778 11.11 14.62 15 15.42 18.89 25.3 35.18];
%RANGE 0 a 6 (Simulada) para planta real VALORES MUDAM (Range 0 a 4)
out1 = [-4.052 0.746 1.58 1.191 1.691 2.191 1.9 2.4 2.9 2.324 2.824 3.324 3.07 3.31 8.053];
in1 = sort(in1);
in2 = sort(in2);
out1 = sort(out1);
rules = [1 0 0 1 0 1 1 0 1 0 0 1 0 1 1 1 0 1 0 0 1 0 0 1 0 1 0];
cromossomo(1,:,ger) = [in1 in2 out1 rules];
%%%% %%%%%%

for ind = 1:numind
    for i = 1:NumIn
        for j = 1:NumMFsIn(i)
            p1 = (i-1)*tamparin(1,i) + (3*j-3); p2 = p1 + 2; p3 = p1 + 4;
            if j == 1
                Fuzzy = setfis(Fuzzy,'input',i,'mf',j,'params',[1*-1000 cromossomo(ind,p2,ger) cromossomo(ind,p3,ger)]);
            elseif j == NumMFsIn(i)
                Fuzzy = setfis(Fuzzy,'input',i,'mf',j,'params',[cromossomo(ind,p1,ger) cromossomo(ind,p2,ger) RangeIn(i,2)*1000]);
            else 
                Fuzzy = setfis(Fuzzy,'input',i,'mf',j,'params',[cromossomo(ind,p1,ger) cromossomo(ind,p2,ger) cromossomo(ind,p3,ger)]);
            end
        end
    end
    for i = 1:NumOut
        for j = 1:NumMFsOut(i)
           % p1 = sum(tamparin)+j; p2 = p1+14; %p2=p1+5 %p3 = p1+10;
            %Fuzzy = setfis(Fuzzy,'output',i,'mf',j,'params',[cromossomo(ind,p1,ger)*a cromossomo(ind,p2,ger)*b 0]);%cromossomo(ind,p3,ger)]);
            %Fuzzy = setfis(Fuzzy,'output',i,'mf',j,'params',[cromossomo(ind,p2,ger)*b cromossomo(ind,p1,ger)*a 0]);%cromossomo(ind,p3,ger)]);
            p1 = sum(tamparin)+(i-1)*tamparin(1,i) + (3*j-3); p2 = p1 + 2; p3 = p1 + 4;
            if j == 1
                Fuzzy = setfis(Fuzzy,'output',i,'mf',j,'params',[1*-1000 cromossomo(ind,p2,ger) cromossomo(ind,p3,ger)]);
            elseif j == NumMFsOut(i)
                Fuzzy = setfis(Fuzzy,'output',i,'mf',j,'params',[cromossomo(ind,p1,ger) cromossomo(ind,p2,ger) RangeOut(i,2)*1000]);
            else 
                Fuzzy = setfis(Fuzzy,'output',i,'mf',j,'params',[cromossomo(ind,p1,ger) cromossomo(ind,p2,ger) cromossomo(ind,p3,ger)]);
            end
        end
    end
    
    for i = 1:NumRules
        p1 = 34+3*(i-1);
        Fuzzy.rule(1,i).consequent = bin2dec(dec2bin([cromossomo(ind,p1,ger) cromossomo(ind,p1+1,ger) cromossomo(ind,p1+2,ger)])');
    end
    

    sim('TankFuzzy');
    IG(ind,ger) = goodhart(Vp(:,2),Niveis(:,2),Niveis(:,3),alfa1,alfa2,alfa3);
    disp(['Gera??o: ' num2str(ger) ', Indiv?duo: ' num2str(ind) ' ==> ?ndice de Goodhart: ' num2str(IG(ind,ger))])
    adap(ind,ger) = 1/IG(ind,ger);
end

adaprel(:,ger) = adap(:,ger)/sum(adap(:,ger));
[melhoradap(ger),posmelhor(ger)] = max(adap(:,ger));
melhorind(ger,:) = cromossomo(posmelhor(ger),:,ger);
mediapop(ger) = sum(adap(:,ger))/numind;
mediapopigual = 0; mesmo = 0;
while (mediapopigual <= 400 & mesmo <= 800 & ger < maxger)
    disp(' ')
    disp(['Rodando AG. Criando gera??o: ' num2str(ger+1) ' de ' num2str(maxger) '  . . . . . . . .'])
    disp(' ')
    for i = 1:numind
        rol(i,ger) = sum(adaprel(1:i,ger));
    end
    for ind = 1:2:2*floor(numind/2)
        bola(ind:ind+1,ger) = rand(1,2);
        poscrosflag = 0;
        while poscrosflag == 0
            poscros(ind,ger) = round(rand(1) * (tamcromo - 2) + 1);
            if poscros(ind,ger) == tamparin(1) || poscros(ind,ger) >= sum(tamparin)
                poscrosflag = 1;
            elseif cromossomo(roleta(rol(:,ger),bola(ind,ger)),poscros(ind,ger),ger) < cromossomo(roleta(rol(:,ger),bola(ind+1,ger)),poscros(ind,ger)+1,ger) && cromossomo(roleta(rol(:,ger),bola(ind+1,ger)),poscros(ind,ger),ger) < cromossomo(roleta(rol(:,ger),bola(ind,ger)),poscros(ind,ger)+1,ger)
                poscrosflag = 1;
            end
        end
        cromossomo(ind,:,ger+1) = [cromossomo(roleta(rol(:,ger),bola(ind,ger)),1:poscros(ind,ger),ger) cromossomo(roleta(rol(:,ger),bola(ind+1,ger)),poscros(ind,ger)+1:tamcromo,ger)];
        cromossomo(ind,:,ger+1) = mutacao2(cromossomo(ind,:,ger+1),percentmut,limites);
        cromossomo(ind+1,:,ger+1) = [cromossomo(roleta(rol(:,ger),bola(ind+1,ger)),1:poscros(ind,ger),ger) cromossomo(roleta(rol(:,ger),bola(ind,ger)),poscros(ind,ger)+1:tamcromo,ger)];
        cromossomo(ind+1,:,ger+1) = mutacao2(cromossomo(ind+1,:,ger+1),percentmut,limites);
    end
    if round(numind/2) == numind/2
        indclone = round(rand(1) * (numind - 1) + 1);
        cromossomo(indclone,:,ger+1) = melhorind(ger,:);
    else
        cromossomo(numind,:,ger+1) = melhorind(ger,:);
    end
    for ind = 1:numind
        cromossomo(ind,19:33,ger+1) = sort(cromossomo(ind,19:33,ger+1));
        for i = 1:NumIn
            for j = 1:NumMFsIn(i)
                p1 = (i-1)*tamparin(i) + (3*j-3); p2 = p1 + 2; p3 = p1 + 4;
                if j == 1
                    Fuzzy = setfis(Fuzzy,'input',i,'mf',j,'params',[1*-1000 cromossomo(ind,p2,ger+1) cromossomo(ind,p3,ger+1)]);
                elseif j == NumMFsIn(i)
                    Fuzzy = setfis(Fuzzy,'input',i,'mf',j,'params',[cromossomo(ind,p1,ger+1) cromossomo(ind,p2,ger+1) RangeIn(i,2)*1000]);
                else
                    Fuzzy = setfis(Fuzzy,'input',i,'mf',j,'params',[cromossomo(ind,p1,ger+1) cromossomo(ind,p2,ger+1) cromossomo(ind,p3,ger+1)]);
                end
            end
        end
        for i = 1:NumOut
            for j = 1:NumMFsOut(i)
                %p1 = sum(tamparin)+j; p2 = p1+14; %p2 = p1+5; %p3 = p1+10;
                %Fuzzy = setfis(Fuzzy,'output',i,'mf',j,'params',[cromossomo(ind,p2,ger+1)*b cromossomo(ind,p1,ger+1)*a 0]);%cromossomo(ind,p3,ger+1)]);
                p1 = sum(tamparin)+(i-1)*tamparin(1,i) + (3*j-3); p2 = p1 + 2; p3 = p1 + 4;
                if j == 1
                    Fuzzy = setfis(Fuzzy,'output',i,'mf',j,'params',[1*-1000 cromossomo(ind,p2,ger+1) cromossomo(ind,p3,ger+1)]);
                elseif j == NumMFsOut(i)
                    Fuzzy = setfis(Fuzzy,'output',i,'mf',j,'params',[cromossomo(ind,p1,ger+1) cromossomo(ind,p2,ger+1) RangeOut(i,2)*1000]);
                else 
                    Fuzzy = setfis(Fuzzy,'output',i,'mf',j,'params',[cromossomo(ind,p1,ger+1) cromossomo(ind,p2,ger+1) cromossomo(ind,p3,ger+1)]);
                end
            end
        end
        for i = 1:NumRules
            p1 = 34+3*(i-1);
            Fuzzy.rule(1,i).consequent = bin2dec(dec2bin([cromossomo(ind,p1,ger) cromossomo(ind,p1+1,ger) cromossomo(ind,p1+2,ger)])');
        end
        sim('TankFuzzy');
        IG(ind,ger+1) = goodhart(Vp(:,2),Niveis(:,2),Niveis(:,3),alfa1,alfa2,alfa3);
        disp(['Gera??o: ' num2str(ger+1) ', Indiv?duo: ' num2str(ind) ' ==> ?ndice de Goodhart: ' num2str(IG(ind,ger+1))])
        adap(ind,ger+1) = 1/IG(ind,ger+1);
    end
    adaprel(:,ger+1) = adap(:,ger+1)/sum(adap(:,ger+1));
    [melhoradap(ger+1),posmelhor(ger+1)] = max(adap(:,ger+1));
    melhorind(ger+1,:) = cromossomo(posmelhor(ger+1),:,ger+1);
    mediapop(ger+1) = sum(adap(:,ger+1))/numind;
    if mediapop(ger+1) == mediapop(ger)
        mediapopigual = mediapopigual + 1;      
    else
        mediapopigual = 0;
    end
    if melhorind(ger) == melhorind(ger+1)
        mesmo = mesmo + 1;
    else
        mesmo = 0;
    end
    ger = ger + 1;
end
v_min_IG = min(IG);
[menor_IG pos_menor_IG] = min(v_min_IG);
Fuzzy_otimo = Fuzzy;
for i = 1:NumIn
    for j = 1:NumMFsIn(i)
        p1 = (i-1)*tamparin(1,i) + (3*j-3); p2 = p1 + 2; p3 = p1 + 4;
        if j == 1
            Fuzzy_otimo = setfis(Fuzzy_otimo,'input',i,'mf',j,'params',[1*-1000 melhorind(pos_menor_IG,p2) melhorind(pos_menor_IG,p3)]);
        elseif j == NumMFsIn(i)
            Fuzzy_otimo = setfis(Fuzzy_otimo,'input',i,'mf',j,'params',[melhorind(pos_menor_IG,p1) melhorind(pos_menor_IG,p2) RangeIn(i,2)*1000]);
        else
            Fuzzy_otimo = setfis(Fuzzy_otimo,'input',i,'mf',j,'params',[melhorind(pos_menor_IG,p1) melhorind(pos_menor_IG,p2) melhorind(pos_menor_IG,p3)]);
        end
    end
end
for i = 1:NumOut
    for j = 1:NumMFsOut(i)
        %p1 = sum(tamparin)+j; p2 = p1+14; %p3 = p1+10; %p2 = p1+5;
        %Fuzzy_otimo = setfis(Fuzzy_otimo,'output',i,'mf',j,'params',[melhorind(pos_menor_IG,p2)*b melhorind(pos_menor_IG,p1)*a 0]);%melhorind(pos_menor_IG,p3)]);
        p1 = sum(tamparin)+(i-1)*tamparin(1,i) + (3*j-3); p2 = p1 + 2; p3 = p1 + 4;
        if j == 1
            Fuzzy_otimo = setfis(Fuzzy_otimo,'output',i,'mf',j,'params',[1*-1000 melhorind(pos_menor_IG,p2) melhorind(pos_menor_IG,p3)]);
        elseif j == NumMFsOut(i)
            Fuzzy_otimo = setfis(Fuzzy_otimo,'output',i,'mf',j,'params',[melhorind(pos_menor_IG,p1) melhorind(pos_menor_IG,p2) RangeOut(i,2)*1000]);
        else 
            Fuzzy_otimo = setfis(Fuzzy_otimo,'output',i,'mf',j,'params',[melhorind(pos_menor_IG,p1) melhorind(pos_menor_IG,p2) melhorind(pos_menor_IG,p3)]);
        end
    end
end
for i = 1:NumRules
    p1 = 34+3*(i-1);
    Fuzzy_otimo.rule(1,i).consequent = bin2dec(dec2bin([melhorind(pos_menor_IG,p1) melhorind(pos_menor_IG,p1+1) melhorind(pos_menor_IG,p1+2)])');
end

nome = ['Fuzzy' '_otimo_' datestr(now,'DD_mmm_yyyy_HH') 'h' datestr(now,'MM') 'min'];
writefis(Fuzzy_otimo,nome);
ultpop = cromossomo(:,:,ger);           % ?ltima popula??o gerada pelo AG
save ultima_populacao ultpop
%==========================================================================================================
%plots


Fuzzy=Fuzzy_otimo;
sim('TankFuzzy');

figure;set(1,'NumberTitle','off','Resize','off','MenuBar','none','Position',[5 435 515 338])
set(1,'Name','Melhor Indiv?duo: Fun??es de Pertin?ncia da 1? Entrada')
figure(1);plotmf(Fuzzy,'input',1);
title('Fun??es de Pertin?ncia da 1? Entrada')

figure;set(2,'NumberTitle','off','Resize','off','MenuBar','none','Position',[520 435 515 338])
set(2,'Name','Melhor Indiv?duo: Fun??es de Pertin?ncia da 2? Entrada')
figure(2);plotmf(Fuzzy,'input',2);
title('Fun??es de Pertin?ncia da 2? Entrada')

figure;set(3,'NumberTitle','off','Resize','off','MenuBar','none','Position',[5 67 515 338])
set(3,'Name','Melhor Indiv?duo: Fun??es de Pertin?ncia da Sa?da')
figure(3);plotmf(Fuzzy,'output',1);
title('Fun??es de Pertin?ncia da Sa?da')

figure;set(4,'NumberTitle','off','MenuBar','none','Position',[520 67 515 338])
set(4,'Name','Resposta do Sistema com o Melhor Indiv?duo')
%figure(3);plot(Niveis1(:,1),Niveis1(:,2),'k-.',Niveis1(:,1),Niveis(:,3),'b',Niveis(:,1),Niveis(:,2),'r','linewidth',2);
figure(4);plot(Niveis(:,1),Niveis(:,2),'k-.',Niveis(:,1),Niveis(:,3),'b',Niveis(:,1),Niveis(:,2),'r','linewidth',2);

%grid;axis([0 1500 0 25]);
%grid;axis([0 600 0 30]);
grid;axis([0 800 0 30]);
title('Resposta do Sistema');xlabel('Tempo(s)');ylabel('N?vel(cm)')

%% EMQ do Fuzzy Mamdani SEM otimizacao  = 30.4568
figure(5)
plot(Niveis(:,1),100*abs((Niveis(:,2)-Niveis(:,3))./Niveis(:,2)))
EMQ=(sum((Niveis(:,2)-Niveis(:,3)).^2))/length(Niveis(:,2))

%grid;axis([0 1500 0 25]);
%grid;axis([0 600 0 30]);
grid;axis([0 800 0 30]);
title('Erro M?dio Percentual %');xlabel('Tempo(s)');