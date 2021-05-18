//UFRN-DCA
//Aluno: Jean Mario Moreira de Lima

//---ALGORITMO GENETICO---

//1. Funcao de custo que se deseja minimizar w9

function w9 = funcao(x,y)
z=-x.*sin(sqrt(abs(x)))-y.*sin(sqrt(abs(y)));
x=x/250;
y=y/250;
// r: Rosenbrock's function
r=100*(y-x.^2).^2+(1-x).^2;
r1=(y-x.^2).^2+(1-x).^2;
rd=1+r1;
//
x1=25*x;
x2=25*y;
xs =-10:0.1:10;
ys =-10:0.1:10;
a=500;
b=0.1;
c=0.5*%pi;
//
F10=-a*exp(-b*sqrt((x1.^2+x2.^2)/2))-exp((cos(c*x1)+cos(c*x2))/2)+exp(1);
//
[n nx]=size(xs);
[n ny]=size(ys);
for i=1:nx
for j=1:ny
zsh(i,j)=0.5-((sin(sqrt(xs(i)^2+ys(j)^2)))^2-0.5) ./(1+0.1*(xs(i)^2+ys(j)^2))^2;
end
end
//
Fobj=F10.*zsh(1);

w2=z-r1;
w4=sqrt(r.^2+z.^2)+Fobj;
w9 = w2 - w4;

endfunction

//2. NORMALIZACAO

function funNomalizada = normaliza(fun)
maximoFun = max(fun);
funNomalizada = fun - maximoFun;
funNomalizada = (-1)*funNomalizada;
funNomalizada = funNomalizada + 0.1*maximoFun; 
endfunction

//3. POPULACAO

//Cria vetores de valores X e Y que representam a populacao
//Recebe seus valores maximos e minimos possiveis de X e Y e o tamanho
//de populacao desejado

function[X,Y]=geraPop(minX, maxX, minY, maxY, tamanhoPop)
for i=1:1:tamanhoPop
X(i)=minX + rand()*(maxX - minX);
Y(i)=minY + rand()*(maxY - minY);
end
endfunction

//4. CRUZAMENTO
//Realiza o cruzamento entre cromossomos para obter novos individuos

function [novoCromo1, novoCromo2]=cruzamento(cromo1, cromo2,taxaCruzamento, maxBits, maxFract)
//Um valor aleatorio e gerado e verifica-se 
//se seu valor e menor que a taxaCruzamento. 
//Em caso de positivo, acontece o cruzamento. Caso contrario, nao acontece.
valorDeCruzamento = rand()

if (valorDeCruzamento < taxaCruzamento) then
//genesCortados representam a quatidade de genes 
//por cromossomos que serao cortados
//para serem invertidos entre os cromossomos.
genesCortados = floor(rand()*maxBits);

//Converte os cromossomospara binario
bins1 = REAL_TO_BITS(cromo1, maxFract, maxBits)
bins2 = REAL_TO_BITS(cromo2, maxFract, maxBits)

//cortando o cromossomo 1 - X
bins1_parte1 = bins1(1:(maxBits - genesCortados))
bins1_parte2 = bins1((maxBits - genesCortados + 1): maxBits)

//cortando o cromossomo 2 - Y
bins2_parte1 = bins2(1:(maxBits - genesCortados))
bins2_parte2 = bins2((maxBits - genesCortados + 1): maxBits)

//Unindo os cromossomos
novoCroBins1 = [bins1_parte1;bins2_parte2]
novoCroBins2 = [bins2_parte1;bins1_parte2]

//Convertendo para Real
novoCromo1 = BITS_TO_REAL(novoCroBins1, maxFract, maxBits)
novoCromo2 = BITS_TO_REAL(novoCroBins2, maxFract, maxBits)
else
novoCromo1 = cromo1;
novoCromo2 = cromo2;
end

endfunction


//5. MUTACAO

function cromMutante = Mutacao(cromo, taxaMut, maxBits, maxFract)
//Gera taxa aleatoria. Se for menor que a taxa de mutacao 
//utilizada, ocorre a mutacao
taxa = rand();
if taxa < taxaMut then
bitMut =  floor(rand()*(maxBits-1)) + 1;
bin = REAL_TO_BITS(cromo, maxFract, maxBits);
valor = bin(bitMut);
if valor == 0 then
valor = 1;
else
valor = 0;
end
bin(bitMut) = valor;
cromMutante = BITS_TO_REAL(bin, maxFract, maxBits)
else
cromMutante = cromo;
end

if cromMutante>500 then
cromMutante=500;
elseif cromMutante<-500
cromMutante=-500;
end
endfunction

function [minimo] = AlgoritmoGenerico(PopTamanho, MaxGeracao, taxaMut, MutacaoRange, TaxaCross, rangeMinX, rangeMaxX, rangeMinY, rangeMaxY, MaxBits, MaxFract,plotagem)

//Gera Populacao
[X,Y]=geraPop(PopTamanho, rangeMinX, rangeMaxX, rangeMinY, rangeMaxY)
Valores = zeros(PopTamanho,1);

Valores = funcao(X,Y);
ActualMin = min(Valores);
Melhor_Min= ActualMin;  
for k=1:1:MaxGeracao

ValoresAux = normaliza(Valores);//Normaliza a funcao a ser avaliada

Soma = sum(ValoresAux);
if Soma ==0 then
disp(Soma);
clf;
end
Aptidao = ValoresAux/Soma;

tamanho = length(Aptidao);

//Girando a Roleta
for i=1:1:PopTamanho 
seta = rand();
Soma_Aux = (-1)*seta;
Posicao=0;

while Soma_Aux<0
Posicao = Posicao + 1;
Soma_Aux = Soma_Aux + Aptidao(Posicao); 
end
//Montando um vetor para realizar o cruzamento 
cross_Over_X(i) = X(Posicao);
cross_Over_Y(i) = Y(Posicao);
end

novoX = [];
novoY = [];

tamanho = PopTamanho;
tamanho_medio = tamanho/2;

//Realizando o cruzamento
for j=1:1:tamanho_medio
//cruzamento em X
indice_impar = (2*j-1)
indice_par = 2*j;
Primeiro = cross_Over_X(indice_impar);
Segundo = cross_Over_X(indice_par);
[novoX_1,novoX_2] = cruzamento(Primeiro, Segundo, TaxaCross, MaxBits, MaxFract);

//verificando a mutacao nos Filhos de X
X1_Velho = novoX_1;
X2_Velho = novoX_2;
novoX_1 = Mutacao(X1_Velho, taxaMut, MaxBits, MaxFract);
novoX_2 = Mutacao(X2_Velho, taxaMut, MaxBits, MaxFract);


novoX = [novoX novoX_1 novoX_2];

//cruzamento em Y
Primeiro_Y = cross_Over_Y(indice_impar);
Segundo_Y = cross_Over_Y(indice_par);
[novoY_1,novoY_2] = cruzamento(Primeiro_Y, Segundo_Y, TaxaCross , MaxBits, MaxFract);

//verificando a mutacao nos filhos de y
Y1_Velho = novoY_1;
Y2_Velho = novoY_2;
novoY_1 = Mutacao(Y1_Velho, taxaMut, MaxBits, MaxFract);
novoY_2 = Mutacao(Y2_Velho, taxaMut, MaxBits, MaxFract);

novoY = [novoY novoY_1 novoY_2];
end


Valores = funcao(novoX,novoY);
ActualMin = min(Valores);
if ActualMin<Melhor_Min then
Melhor_Min=ActualMin;
end

X = novoX;
Y = novoY;
minimo = Melhor_Min;

ArrayMin(k) = minimo;
Actu_Min_Array(k) = ActualMin;
end
var_Sub = 2*10^2 + 2*10 + plotagem;
subplot(var_Sub);
xtitle("Minimo por Geracao");
k=1:MaxGeracao;
plot(k, ArrayMin,'r',k,Actu_Min_Array, plotagem);
xlabel('Geracao');
ylabel('Funcao Custo');
legend('Minimo Global','Minimo Encontrado');

xgrid();
endfunction


//Funcao que transforma um numero inteiro em um array binario
//trabalha com numeros negativos
function binario = real_to_bin_Int(Real, MaxReal)
if Real<0 then
binario(1)=1;
Real = (-1)*Real;
else 
binario(1)=0;
end

div=Real;
new_Div = div;
i=1;
resto=[];
i=1;

//parte real
while i<MaxReal
resto(MaxReal - i ) = modulo(new_Div , 2)
new_Div = floor(new_Div/2)
i=i+1
end

binario = [binario; resto];

endfunction

//funcao que transforma um numero real fracionario em um array de binario
//deve-se dizer um valor maximo de bits para representacao
function bin_fract = real_to_bin_fract(frac, rep_Max)
Representacao_Maximo = rep_Max;
i=1;
resto = [];
valor=frac;
Representacao=0;

while (Representacao<Representacao_Maximo)
valor=2*valor;
resto(i)=floor(valor);
valor = valor - resto(i);
Representacao = Representacao + 1;
i = i+1;
end

bin_fract = resto;
endfunction

//funcao que transforma um array de binario em numero real
//trabalha com numeros negativos
//trabalha somente com numero inteiro
function realis = bin_to_real_int(binario)
tamanho = length(binario);
new_Real=0;
for i=2:tamanho
Real =  binario(i)*2^(tamanho-i);
new_Real = new_Real + Real;
end

if binario(1)==1 then
new_Real = (-1)*new_Real;
end
realis = new_Real
endfunction

//Funcao que converte numero binario para numero real
//trabalha apenas com a parte fracionario
function realis = bin_to_real_fract(binario)
tamanho = length(binario);
new_Real=0;
for i=1:tamanho
Real =  binario(i)*2^(-i);
new_Real = new_Real + Real;
end

realis = new_Real
endfunction

//funcao que separa a parte inteira da parte fracionaria de um numero
function [inteira, fracionaria] = separador(Real)
if Real>0 then
inteira = floor(Real);
fracionaria = Real - inteira;
else
Real_Aux = abs(Real);
inteira = floor(Real_Aux);
fracionaria = Real_Aux - inteira;
inteira = (-1)*inteira;
end

endfunction

function Binario = REAL_TO_BITS(Real, MaxFract, MaxBits)

[inteiro, fracionario] = separador(Real);

Max_int = MaxBits - MaxFract;
inteiro_binario = real_to_bin_Int(inteiro, Max_int);
fracionario_binario = real_to_bin_fract(fracionario, MaxFract);

Binario = [inteiro_binario; fracionario_binario];
endfunction

function numeroReal = BITS_TO_REAL(Binario, MaxFract, MaxBits)

MaxInteira = MaxBits - MaxFract;
parteInteira = Binario(1:MaxInteira);
parteFracionaria = Binario((MaxInteira+1):MaxBits);

numInteiro = bin_to_real_int(parteInteira);
numFracionario = bin_to_real_fract(parteFracionaria);

if numInteiro<0 then
numeroReal = (-1)*(abs(numInteiro) + numFracionario);
else
numeroReal = numInteiro + numFracionario
end

endfunction

//declarando as variaveis necessarias para o trabalho de OTIMIZACAO DE SISTEMAS
taxaMut = 0.1;    //Taxa de Mutacao
MutacaoRange = 10;

TaxaCross = 0.80;     //Taxa de Cruzamento
MaxGeracao = 20;   //Maximo de Geracoes a serem avaliadas

rangeMaxX=500;     //Valor maximo    para X
rangeMinX=-500;    //Valor minimo para X

rangeMaxY=500;     //Valor maximo para Y
rangeMinY=-500;    //Valor minimo para Y

PopTamanho = 50;    //Tamanho da Populacao

//tamanho das representacoes em binario
MaxFract = 5;
MaxInt = 12;
MaxBits = MaxInt + MaxFract;

for i=1:4
[Resposta(i)] = AlgoritmoGenerico(PopTamanho, MaxGeracao, taxaMut, MutacaoRange, TaxaCross, rangeMinX, rangeMaxX, rangeMinY, rangeMaxY, MaxBits, MaxFract,i); 
end
disp(Resposta);
