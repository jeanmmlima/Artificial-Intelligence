%CASO1

%1. Coleta de Dados de treinamento e validacao
%2. Associando a saida desejada para cada amostra
 vX1 = (0:0.125:5)';
 VX2 = (0:0.1:4)';
 vValida = [];
 
 for i=1:length(vX1)/10
     vValida = [vValida vX1(i+10)];
 end
 
 vYd = fresadora(vX1);

 %printf('Teste!');
 
%3. Iniciando os vetores de pesos - 1 neuronio na camada oculta
%Pesos na Camada 1
w1(1,1) = 2 * rand - 1; %bias
w1(1,2) = 2 * rand - 1; %entrada 1

%Pesos na Camada 2 (camda de saida)
w2(1,1) = 2 * rand - 1; %bias
w2(1,2) = 2 * rand - 1; %saida 1

%4. Especificando a taxa de aprendizagem(n), precisao requerida (Emin) e o
%numero maximo de epocas (epocasMax)
n = 0.005;
epocaMax = 100000;
erroMax = 0.000001;

%%Treinamento Backpropagation
[w1, w2, erroTrein] = caso1_Backpropagation(n, epocaMax, erroMax, vX1, vYd, w1, w2);

%% Gerando gráfico do erro
t = 1:1:size(erroTrein,2);
plot(t, erroTrein(1,:), 'k.');
grid;
xlabel('epoca');
ylabel('Erro Medio Quadratico - Treinamento');
figure

%%Teste MLP

%fprintf('---------------TesteMLP-----------------');

for k = 1:41
  in1 = vX1(k);
  
  yE = caso1_execMLP(in1, w1, w2);
  
  yEst(k) = yE;
end

for k = 1:41
    in2 = VX2(k);
    yE2 = caso1_execMLP(in2,w1,w2);
    yEst2(k) = yE2;
end

% Gráficos dos dados de treinamento e da estimação.
plot(vX1, vYd, 'k', vX1, yEst, 'b', VX2,yEst2,'m');
grid;
xlabel('x');
ylabel('y : "+" = Valores Originais; "." = Valores Estimados pela MLP');




