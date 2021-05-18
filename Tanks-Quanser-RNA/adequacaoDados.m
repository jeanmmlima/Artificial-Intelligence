

%% ajuste de dados ANTIGOS
dif_samples = 10;
tamDados = (length(data_V))/dif_samples;

new_data_V = [data_V(1)];
new_data_L2 = [data_L2(1)];

for i=1:tamDados-1
    new_data_V(:,i+1) = [data_V(:,i*dif_samples)];
    new_data_L2(:,i+1) = [data_L2(:,i*dif_samples)];
end

V = new_data_V;
L2 = new_data_L2;

%% 
porcentagem2valid = 0.2;
tamDados = length(V);
minPosValid = 40000;
tamValid = round(porcentagem2valid * tamDados);

treinV = V(1:minPosValid);
treinV = [treinV; V(minPosValid+tamValid+1:tamDados)];
validV = V(minPosValid+1:minPosValid+tamValid);

treinL2 = L2(1:minPosValid);
treinL2 = [treinL2; L2(minPosValid+tamValid+1:tamDados)];
validL2 = L2(minPosValid+1:minPosValid+tamValid);

treinL2 = treinL2';
treinV = treinV';
validL2 = validL2';
validV = validV';


