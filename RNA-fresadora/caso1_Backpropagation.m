function [w1,w2,erroTrein] = caso1_Backpropagation(n, epocaMax, erroMax, vX1, vYd, w1, w2)
%6. Repeticao do treinamento

for epoca = 1:epocaMax
    %6.1 - Propagar e Retropropagar para todas as amostras de treinamento
    for k = 1:length(vX1) %amostras de treinamento
        x1 = vX1(k);
        Yd = vYd(k);
        
        %6.1.1 - Propagacao
        %%Camada Oculta:
         %Potencial de Ativacao
         uN1 = w1(1,1)*1 + w1(1,2)*x1;
         
         %Saida do Neuronio [Sigmoide]
         yN1 = 2 /(1 + exp(-2*uN1)) - 1;
         
         %%Camada de Saida
         uNs = w2(1,1)*1 + w2(1,2)*yN1;
         
         %Saida do Neuronio [linear]
         y = uNs;
         
       %6.1.2 - Retropropagacao
       %%Erro de treinamento - Camada de Saida:
         e = Yd - y;
         E(k) = e;
         %Ajustes dos pesos da camada de saida
         
          %% - Gradiende grad2 local da camada de saida (2)
            %grad2 = e * dF(linear) = e * 1 = e
            grad2 = e;
          %% - Fator de ajuste dos pesos:
            dw2(1,1) = n * grad2; %BIAS
            dw2(1,2) = n * grad2 * yN1;
          %% - Ajustes dos pesos:
            w2(1,1) = w2(1,1) + dw2(1,1);
            w2(1,2) = w2(1,2) + dw2(1,2);
            
         %Ajustes dos pesos da camada oculta
          %%--Gradiente Local da camada 1 (oculta)
           %%-- grad1 = dF(sigmoide) * sum(grad2 * pesos)
           %%-- dF(sigmoide) = 1 - f(x)^2
           sumGrad1 = grad2 * (w2(1,2));
           dFSigmoideN1 = 1 - ((2 /(1 + exp(-2*uN1)) - 1)^2);
           grad1N1 = sumGrad1 * dFSigmoideN1;
           
           %--Fator de ajuste dos pesos
           dw1(1,1) = n * grad1N1; %bias
           dw1(1,2) = n * grad1N1 * x1;
           
           %--Ajuste dos pesos:
           w1(1,1) = w1(1,1) + dw1(1,1);
           w1(1,2) = w1(1,2) + dw1(1,2);
    end 
       %Teste de erro medio minimo
       
       Em = (sum(sum(E.*E)))/2;
       
       if(Em < erroMax)
           break;
       end
       
   % Imprimindo valores do treinamento
      fprintf('Epoca Treinam. = %.0f Erro Médio Quadratico = %g\n\n', epoca, Em);
      erroTrein(epoca) = Em;
      
end
         
       
         
      
        

end

