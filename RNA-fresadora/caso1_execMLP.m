function [yEst] = caso1_execMLP(in1, w1, w2)

  %% Camada oculta
    %--Potencial de ativa��o
    uN1 = w1(1,1)*1 + w1(1,2)*in1;
  
    %--Sinal de sa�da do neuronio [Fun��o de ativa��o sigm�ide]
    yN1 = 2/(1 + exp(-2*uN1)) - 1;
  
  %% Camada de sa�da
    %--Potencial de ativa��o
    uNs = w2(1,1)*1 + w2(1,2)*yN1;
  
    %--Sinal de sa�da do neur�nio [Fun��o de ativa��o linear]
    yEst = uNs;

end

