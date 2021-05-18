%%UFRN - CT - DCA
%%JEAN


%% 0. Sepra??o dos conjuntos

tamV = length(entrada_V_atrasada_grau1);
tamL2 = length(entrada_L2_atrasada_grau1);

%valida??o
validV = entrada_V_atrasada_grau1(1:240000,:)';
validL2 = entrada_L2_atrasada_grau1(1:240000,:)';
outValidL2 = saida_L2_grau1(1:240000)';

%treinamento
treinV = entrada_V_atrasada_grau1(240001:tamV)';
treinL2 = entrada_L2_atrasada_grau1(240001:tamL2)';
outTreinL2 = saida_L2_grau1(240001:tamL2)';



%% Treinamento para estruturas NARX de ordem 1 SEM Normaliza??o

INPUTS1 = [treinV; treinL2];
TARGETS1 = outTreinL2;

%% Valida??o

%OUTS1_RNA1_N1_NN4 = validaRedes(RNA_N1_NN,validV,validL2,1);

tamV_v = length(validV);
d = 10;
ordem = 1;
itens = d + ordem;
outsAtrasadas = [];
input = [];
OUTS = [];

outsAtrasadas = [outsAtrasadas validL2(:,1:itens)];

for i=1:tamV_v
    
    input(:,i) = [validV(:,i); outsAtrasadas(:,i)];
    OUTS(:,i) = RNA_N1_NN20(input(:,i));
    p = i/tamV_v * 100;
    TEX = sprintf('Validação: %f%% \n',p);
    disp(TEX);
    
    outsAtrasadas = [outsAtrasadas OUTS(:,i)];

end






