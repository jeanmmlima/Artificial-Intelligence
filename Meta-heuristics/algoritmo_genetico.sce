//Algoritmo Genetico

//Maximo da funcao sen (x)
//x - pessoa - vetor de bits (4 genes)
//Ex
//[0 0 0 0] -> x = 0
//[0 0 1 0] -> x = 2

//-- gerar populacao (4 pessoas ou cromossomos)
//-- funcao de aptidao [0 a 100], logo f'(x) = 50*(sen(x) + 1)


//p1 = [1 0 0 1] -> x = 9 -> sen(x) = 0.41 -> f'(x) = 70.61
//p2 = [0 0 1 1] -> x = 3 -> sen(x) = 0.14 -> f'(x) = 57.06
//p3 = [1 0 1 0] -> x = 10 -> sen(x) = -0.54 -> f'(x) = 22.80
//p4 = [0 1 0 1] -> x = 5 -> sen(x) = -0.96 -> f'(x) = 2.09

//aptidao total = 152,52

//taxas de aptidao:
//1 - 70.61/152.52 = 0.463 (calcular pra todos os outros)
//2 - 57.06/152.52 = 0.374

//reproducao (roleta)
//Porcentagens em um grafico de pizza. Sorteia-se um numero entre zero e 1, e se por exemplo esse numero cair entre 0 e 0.463, p1 eh eleita. caindo entre 0.463 e 0.837, p2 sera eleita e assim sucessivamente

//Numero aleatorio para os genes de crossover (rand para o numero de genes)

//-------------

//ALEATORIOS

//rand(x) --> numero aleatorio entre 0 e X.

//ceil(x) --> arredonda x

//-------------


//-------------

//Declarando funcao sin x
function val=funcao(x)
    val = sin(x);
endfunction

function grafico()
    x = intNeg:0.1:intPos;
    y = funcao(x);
    plot(x,y);
endfunction

intNeg = -10;
intPos = 10;
//grafico();

//--------------
//Converte vetor de binario em seu inteiro correspondente

function dec = binarioToDecimal(binario)
    aux = '';
    for (i=1:1:nGens)
        if(binario(i) == 1) then
            aux = aux + '1';
        else
            aux = aux + '0';
        end
    end
    dec = bin2dec(aux);
        
endfunction

//---------------
//Funcao de normalizacao - Distribuir os valores LINEARMENTE 

function x = normalizar(decimal,minval,maxval,nGens)
    interval = maxval - minval;
    x = minval + (interval) * decimal / (2^(nGens)-1);
endfunction


//---------------
//Apitdao

function val = aptidao(dec,minval,maxval,nGens)
    normalizado = normalizar(dec,minval,maxval,nGens);
    val = funcao(normalizado);
    val = 50 * (val+1);
endfunction

//Gera um vetor com os valores de aptidao para cada individuo

function APT = gerarVetorAPT(Populacao,minval,maxval,nGens)
    for(i=1:1:nGens)
        APT(i) = aptidao(binarioToDecimal(Populacao(i,:)),minval,maxval,nGens);
    end
endfunction

//Gera a aptidao total da populacao

function apt_total = getAptidaoTotal(APT, nGens)
    apt_total = 0;
    for(i=1:1:nGens)
        apt_total = apt_total + APT(i);
    end
endfunction

//Gera a taxa de aptidao para cada individuo

function TAXA_APT_2 = getTaxaAptidao(APT,nGens)
    aptTotal = getAptidaoTotal(APT,nGens);
    for(i=1:1:nGens)
        TAXA_APT_2(i) = APT(i)/aptTotal;
    end
endfunction

function TAXA_APT = getIntervaloDeTaxas(TAXA_APT_2,nGens)
    for(i=1:1:nGens)
        if i ==1 then
            TAXA_APT(i) = TAXA_APT_2(i);
        else
        TAXA_APT(i) = TAXA_APT_2(i)+TAXA_APT(i-1);
        end
     end
endfunction

//---------------

//Roleta


//Seleciona um reprodutor de acordo com a apatidao

function PAI = selecionaPai(Populacao,TAXA_APT,nGens)
    roleta = rand(1);
    for(i=1:1:nGens)
        if (i == 1) then
            if (roleta >= 0 & roleta < TAXA_APT(i)) then
                PAI = Populacao(i,:);
                i = 7;
            end
       // elseif (i == nGens) then
         //   if (roleta >= TAXA_APT(i) & roleta < 1) then
           //     PAI = Populacao(i,:);
             //   i = 7;
            //end
        else
            if (roleta >= TAXA_APT(i-1) & roleta < TAXA_APT(i)) then
                PAI = Populacao(i,:);
                i = 7;
            end
        end
    end
endfunction

//Monta a matriz de pais
function PAIS = selecionaPais(Populacao,TAXA_APT,nGens)
    for(i=1:2:nGens)
        PAIS(i,:) = selecionaPai(Populacao,TAXA_APT,nGens);
        PAIS(i+1,:) = selecionaPai(Populacao,TAXA_APT,nGens);
        while(PAIS(i,:) == PAIS(i+1,:))
            PAIS(i+1,:) = selecionaPai(Populacao,TAXA_APT,nGens);
        end
     end
endfunction

//Gera os Filhos
function FILHOS = cruzaPais(PAIS, nGens)
    for(i=1:2:nGens/2)
        crossover = ceil(rand(nGens) * nGens);
        for(j=crossover:1:nGens)
            aux = PAIS(i,j);
            PAIS(i,j) = PAIS(i+1,j);
            PAIS(i+1,j) = aux;
        end
     end
     FILHOS = PAIS;
endfunction


//Mutacao dos filhos

function FILHOS_M = mutaFilhos(FILHOS,nGens,chanceMutacao)
    for(i=1:1:nGens)
        if chanceMutacao > rand(1) then
            gene = ceil(rand(nGens) * nGens);
            if (FILHOS(i,gene) == 1) then
                FILHOS(i,gene) = 0;
            else
                FILHOS(i,gene) = 1;
            end
        end
     end
     FILHOS_M = FILHOS;
endfunction


function I = getMaisAdaptado(Populacao,APT,nGens)
    maiorApt = max(APT);
    for(i=1:1:nGens)
        if(maiorApt == APT(i)) then
            I = Populacao(i,:);
            i = nGens;
        end
    end
endfunction

//---------------

//1. Gerar Populacao

//1.1 Gerando os filhos por genes desejados!

function filhoGerado = gerarFilho(nGens)
    for (i=1:1:nGens)
        if(rand(1) > porcentagemGenetica) then
            //$ eh o ultimo indice do vetor. Ou seja, o proximo gene
            //sera adicionado na ultima posicao do vetor filho
            filhoGerado(1,$+1) = 1;
        else
            filhoGerado(1,$+1) = 0;
        end
    end
endfunction

//1.2 Gerando a populacao

function P = gerarPopulacao(nGens)
    for(i=1:1:nGens)
        P(i,:) = gerarFilho(nGens);
    end
endfunction

//Valores podem variar
porcentagemGenetica = 0.5;
nGens = 6;
chanceMutacao = 0.01;
nGeracoes = 6;

//------------------

//ALGORITMO GENETICO


function R = algoritmoGenetico(f,nGens,porcentGenetica,chanceMutacao,nGeracoes)
    minval = 0;
    maxval = %pi;
    P = gerarPopulacao(nGens);
    printf("Geracao: "+string(1));
    disp(P);
    vetorApt = gerarVetorAPT(P,minval,maxval,nGens);
    printf("Individuo mais adaptado da Geracao "+string(1));
    MAIS_ADAPTADO = getMaisAdaptado(P,vetorApt,nGens)
    disp(MAIS_ADAPTADO);
    printf("Aptidao: "+string(max(vetorApt)));
    printf("\n");
    adaptidao = max(vetorApt);
    for(i=2:1:nGens)    
     taxaApt = getTaxaAptidao(vetorApt,nGens);
     intervalosDeTaxas = getIntervaloDeTaxas(taxaApt,nGens);
     SELECIONADOS = selecionaPais(P,intervalosDeTaxas,nGens);
     FILHOS = cruzaPais(SELECIONADOS,nGens);
     FILHOS = mutaFilhos(FILHOS,nGens,chanceMutacao);
     P = FILHOS;
     printf("Geracao: "+string(i));
     disp(P);
     vetorApt = gerarVetorAPT(P,minval,maxval,nGens);
     printf("Individuo mais adaptado da Geracao "+string(i));
     disp(getMaisAdaptado(P,vetorApt,nGens));
     MAIS_ADAPTADO = getMaisAdaptado(P,vetorApt,nGens);
     R = MAIS_ADAPTADO;
     printf("Aptidao: "+string(max(vetorApt)));
     printf("\n");
     aux = max(vetorApt);
     if(aux > adaptidao) then
         adaptidao = aux;
     end
    end
    printf("Melhor Adaptidao: "+string(adaptidao));
    printf("\n");
endfunction













