function [yEst] = caso1_execMLP(in1, w1, w2)

  %% Camada oculta
    %--Potencial de ativação
    uN1 = w1(1,1)*1 + w1(1,2)*in1;
  
    %--Sinal de saída do neuronio [Função de ativação sigmóide]
    yN1 = 2/(1 + exp(-2*uN1)) - 1;
  
  %% Camada de saída
    %--Potencial de ativação
    uNs = w2(1,1)*1 + w2(1,2)*yN1;
  
    %--Sinal de saída do neurônio [Função de ativação linear]
    yEst = uNs;

end

