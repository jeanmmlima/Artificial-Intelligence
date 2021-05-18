%% Segunda Ordem

entrada_L2_atrasada_grau1 = entrada_L2_atrasada_grau1';
entrada_L2_atrasada_grau2 = entrada_L2_atrasada_grau2';
entrada_V_atrasada_grau1 = entrada_V_atrasada_grau1';
entrada_V_atrasada_grau2 = entrada_V_atrasada_grau2';

%%

tamV_1 = length(entrada_V_atrasada_grau1);
entrada_V = [entrada_V_atrasada_grau1(:,2:tamV_1); entrada_V_atrasada_grau2];

tamL2_1 = length(entrada_L2_atrasada_grau1);
entrada_L2 = [entrada_L2_atrasada_grau1(:,2:tamL2_1); entrada_L2_atrasada_grau2];

tamV_2 = length(entrada_V_atrasada_grau2);
tamL2_2 = length(entrada_L2_atrasada_grau2);

%%

%valida??o
validV_1 = entrada_V_atrasada_grau1(:,2:240000);
validV_2 = entrada_V_atrasada_grau2(:,1:239999);
validL2_1 = entrada_L2_atrasada_grau1(:,2:240000);
validL2_2 = entrada_L2_atrasada_grau2(:,1:239999);

outValidL2 = saida_L2_grau2(1:240000)';

%% treinamento
treinV_1 = entrada_V_atrasada_grau1(240001:tamV_1);
treinV_2 = entrada_V_atrasada_grau2(240000:tamV_2);
treinL2_1 = entrada_L2_atrasada_grau1(240001:tamL2_1);
treinL2_2 = entrada_L2_atrasada_grau2(240000:tamL2_2);

outTreinL2 = saida_L2_grau2(240000:tamL2_2)';



%% Treinamento para estruturas NARX de ordem 1 SEM Normaliza??o

INPUTS1 = [treinV_1; treinV_2; treinL2_1; treinL2_2];
TARGETS1 = outTreinL2;

%% Validacao

tamV_v = length(validV_1);
d = 10;
ordem = 2;
itens = d + ordem;
outsAtrasadas = [];
input = [];
OUTS = [];

outsAtrasadas = [validL2_1(:,2:itens); validL2_2(:,1:itens-1)];

for i=1:tamV_v
    
    input(:,i) = [validV_1(:,i); validV_2(:,i); outsAtrasadas(:,i)];
    OUTS(:,i) = RNA_N2_NN8_NN16(input(:,i));
    p = i/tamV_v * 100;
    TEX = sprintf('Validação: %f%% \n',p);
    disp(TEX);

    outsAtrasadas = [outsAtrasadas'; OUTS(:,i) outsAtrasadas(1,10+i)];
    outsAtrasadas = outsAtrasadas';

end
