%%LISTA 3 - RNA - 2017.1
% Jean Mário

%% 0. Obtendo dados de entrada e saída

%treinamento
step = 0.01;
n = -2*pi:step:2*pi;
x = funcQuest4(n);
len = length(x);

figure(1),
plot(x)
grid on 

%% Tratando os dados

% ORDEM NARX - 1
ordem = 1;
% QUANTIDADE DE PASSOS A PREVER
passo = 1;
n_1_1 = n(1:len-passo);
x_1_1 = x(1:len-passo);

inputs_1 = [n_1_1; x_1_1];
targets_1 = x(1+passo:len);

% QUANTIDADE DE PASSOS A PREVER
passo = 2;
n_1_2 = n(1:len-passo);
x_1_2 = x(1:len-passo);
x_n_2 = x(passo:len-passo+1);

inputs_2 = [n_1_2; x_1_2; x_n_2];

x_2_n = x_n_2;
x_2_n_1 = x(passo+1:len);

targets_2 = [x_2_n; x_2_n_1];

% QUANTIDADE DE PASSOS A PREVER
passo = 3;
n_1_3 = n(1:len-passo);
x_1_3 = x(1:len-passo);
x_n_3 = x(passo-1:len-passo+1);
x_n1_3 = x(passo:len-passo+2);

inputs_3 = [n_1_3; x_1_3; x_n_3; x_n1_3];

x_3_n = x_n_3;
x_3_n1 = x_n1_3;
x_3_n2 = x(passo+1:len);

targets_3 = [x_3_n; x_3_n1; x_3_n2];
%% TREINAMENTO DAS REDES PASSO 1

figure(2)
subplot(131),plot(targets_1,'r'),hold on
plot(rna_4_1_outputs,'b')
subplot(132),plot(targets_1,'r'),hold on
plot(rna_8_1_outputs,'b')
subplot(133),plot(targets_1,'r'),hold on
plot(rna_12_1_outputs,'b')


%% TREINAMENTO DAS REDES PASSO 2

figure(2)
subplot(441),plot(targets_2(1,:),'r'),hold on
plot(rna_3_2_outputs(1,:),'b')
subplot(442),plot(targets_2(1,:),'r'),hold on
plot(rna_3_2_outputs(2,:),'b')


%% VALIDAÇÃO DAS REDES

step_validacao = 0.03;
n_validacao = -pi:step_validacao:pi;
x_validacao = funcQuest4(n_validacao);
len_validacao = length(x_validacao);

figure(3),
subplot(211),plot(n_validacao)
subplot(212),plot(x_validacao)
%%
% ORDEM NARX - 1
ordem = 1;
% QUANTIDADE DE PASSOS A PREVER
passo = 1;
n_1_1_v = n_validacao(1:len_validacao-passo);
x_1_1_v = funcQuest4(-pi);

inputs_1_v = [];
outputs_1_v = [];
for i=1:length(n_1_1_v)
    inputs_1_v(:,i) = [n_1_1_v(i); x_1_1_v];
    outputs_1_v(i) = rna_4_1(inputs_1_v(i));
    x_1_1_v = outputs_1_v(i);
end

x_validacao = x_validacao(1:len_validacao-passo);
 
figure(4),
subplot(331),
plot(outputs_1_v,'r'), hold on
plot(x_validacao,'b')

inputs_2_v = [];
outputs_2_v = [];
x_1_1_v = funcQuest4(-pi);
for i=1:length(n_1_1_v)
    inputs_2_v(:,i) = [n_1_1_v(i); x_1_1_v];
    outputs_2_v(i) = rna_8_1(inputs_2_v(i));
    x_1_1_v = outputs_2_v(i);
end

 
subplot(332),
plot(outputs_2_v,'r'), hold on
plot(x_validacao,'b')

inputs_3_v = [];
outputs_3_v = [];
x_1_1_v = funcQuest4(-pi);
for i=1:length(n_1_1_v)
    inputs_3_v(:,i) = [n_1_1_v(i); x_1_1_v];
    outputs_3_v(i) = rna_12_1(inputs_3_v(i));
    x_1_1_v = outputs_3_v(i);
end
 
subplot(333),
plot(outputs_3_v,'r'), hold on
plot(x_validacao,'b')

inputs_4_v = [];
outputs_4_v = [];
x_1_1_v = funcQuest4(-pi);
for i=1:length(n_1_1_v)
    inputs_4_v(:,i) = [n_1_1_v(i); x_1_1_v];
    outputs_4_v(i) = rna_20_1(inputs_4_v(i));
    x_1_1_v = outputs_4_v(i);
end
 
subplot(334),
plot(outputs_4_v,'r'), hold on
plot(x_validacao,'b')

inputs_5_v = [];
outputs_5_v = [];
x_1_1_v = funcQuest4(-pi);
for i=1:length(n_1_1_v)
    inputs_5_v(:,i) = [n_1_1_v(i); x_1_1_v];
    outputs_5_v(i) = rna_24_1(inputs_5_v(i));
    x_1_1_v = outputs_5_v(i);
end
 
subplot(335),
plot(outputs_5_v,'r'), hold on
plot(x_validacao,'b')
%% VALIDAÇÃO DAS REDES - PASSO 2

% ORDEM NARX - 1
ordem = 1;
% QUANTIDADE DE PASSOS A PREVER
passo = 2;
n_1_2_v = n_validacao(1:len_validacao-passo);
x_1_2_validacao = x_validacao(1:len_validacao-passo);
x_n_2_validacao = x_validacao(passo:len_validacao-passo+1);

x_1_2_v = x_validacao(1);
x_n_2_v = x_validacao(2);

inputs_1_v = [];
outputs_1_v = [];
for i=1:length(n_1_2_v)
    inputs_1_v(:,i) = [n_1_2_v(i); x_1_2_v; x_n_2_v];
    outputs_1_v(:,i) = rna_9_2(inputs_1_v(i));
    x_1_2_v = outputs_1_v(1,i);
    x_n_2_v = outputs_1_v(2,i);
end
 


inputs_2_v = [];
outputs_2_v = [];
for i=1:length(n_1_2_v)
    inputs_2_v(:,i) = [n_1_2_v(i); x_1_2_v; x_n_2_v];
    outputs_2_v(:,i) = rna_12_2(inputs_2_v(i));
    x_1_2_v = outputs_2_v(1,i);
    x_n_2_v = outputs_2_v(2,i);
end

inputs_3_v = [];
outputs_3_v = [];
for i=1:length(n_1_2_v)
    inputs_3_v(:,i) = [n_1_2_v(i); x_1_2_v; x_n_2_v];
    outputs_3_v(:,i) = rna_21_2(inputs_3_v(i));
    x_1_2_v = outputs_3_v(1,i);
    x_n_2_v = outputs_3_v(2,i);
end

inputs_4_v = [];
outputs_4_v = [];
for i=1:length(n_1_2_v)
    inputs_4_v(:,i) = [n_1_2_v(i); x_1_2_v; x_n_2_v];
    outputs_4_v(:,i) = rna_24_2(inputs_4_v(i));
    x_1_2_v = outputs_4_v(1,i);
    x_n_2_v = outputs_4_v(2,i);
end


figure(6),
subplot(441),
plot(outputs_1_v(1,:),'r'), hold on
plot(x_1_2_validacao,'b')
subplot(442),
plot(outputs_1_v(2,:),'r'), hold on
plot(x_n_2_validacao,'b');
subplot(443),
plot(outputs_2_v(1,:),'r'), hold on
plot(x_1_2_validacao,'b')
subplot(444),
plot(outputs_2_v(2,:),'r'), hold on
plot(x_n_2_validacao,'b');
subplot(445),
plot(outputs_3_v(1,:),'r'), hold on
plot(x_1_2_validacao,'b')
subplot(446),
plot(outputs_3_v(2,:),'r'), hold on
plot(x_n_2_validacao,'b');
subplot(447),
plot(outputs_4_v(1,:),'r'), hold on
plot(x_1_2_validacao,'b')
subplot(448),
plot(outputs_4_v(2,:),'r'), hold on
plot(x_n_2_validacao,'b');

%% EMS 

   %ems_rna_1_6 = sum((x_1_2_validacao-outputs_1_v(1,:)).^2)/(len_validacao);
     % + sum((x_n_2_validacao-outputs_1_v(1,:)).^2)/(len_validacao))/2 ;
  
  ems_rna_1_12 = (sum((x_1_2_validacao-outputs_2_v(1,:)).^2)/(len_validacao)...
      + sum((x_n_2_validacao-outputs_2_v(1,:)).^2)/(len_validacao))/2 ;
  
  ems_rna_1_21 = (sum((x_1_2_validacao-outputs_3_v(1,:)).^2)/(len_validacao)...
      + sum((x_n_2_validacao-outputs_3_v(1,:)).^2)/(len_validacao))/2 ;
  
  ems_rna_1_24 = (sum((x_1_2_validacao-outputs_4_v(1,:)).^2)/(len_validacao)...
      + sum((x_n_2_validacao-outputs_4_v(1,:)).^2)/(len_validacao))/2 ;
  
figure(7),
stem(1,ems_rna_1_12,'r','LineWidth',12),hold on
stem(1.5,ems_rna_1_12,'b','LineWidth',12),hold on
stem(2,ems_rna_1_21,'g','LineWidth',12),hold on
stem(2.5,ems_rna_1_24,'cyan','LineWidth',12),hold on
ylabel('EMS absoluto','fontweight','b');
xlabel('Arquiteturas','fontweight','b');
legend('1 CO e 9 Neurônios','1 CO e 12 Neurônios','1 CO e 21 Neurônios','1 CO e 24 Neurônios');
grid on
%% EMS - PASSO 1

   %ems_rna_1_6 = sum((x_1_2_validacao-outputs_1_v(1,:)).^2)/(len_validacao);
     % + sum((x_n_2_validacao-outputs_1_v(1,:)).^2)/(len_validacao))/2 ;
  
  ems_rna_1_4 = (sum((x_validacao-outputs_1_v(1,:)).^2)/(len_validacao));
  
  ems_rna_1_8 = (sum((x_validacao-outputs_2_v(1,:)).^2)/(len_validacao));
  
  ems_rna_1_12 = (sum((x_validacao-outputs_3_v(1,:)).^2)/(len_validacao));
  
  ems_rna_1_20 = (sum((x_validacao-outputs_4_v(1,:)).^2)/(len_validacao));
  
  ems_rna_1_24 = (sum((x_validacao-outputs_5_v(1,:)).^2)/(len_validacao));
  
figure(7),
stem(1,ems_rna_1_4,'r','LineWidth',12),hold on
stem(1.5,ems_rna_1_8,'b','LineWidth',12),hold on
stem(2,ems_rna_1_12,'g','LineWidth',12),hold on
stem(2.5,ems_rna_1_20,'cyan','LineWidth',12),hold on
stem(3,ems_rna_1_24,'magenta','LineWidth',12),hold on
ylabel('EMS absoluto','fontweight','b');
xlabel('Arquiteturas','fontweight','b');
legend('1 CO e 4 Neurônios','1 CO e 8 Neurônios','1 CO e 12 Neurônios','1 CO e 20 Neurônios','1 CO e 24 Neurônios');
grid on
  

%% VALIDACAO PASSO 3
%%QUANTIDADE DE PASSOS A PREVER

passo = 3;
n_1_3_v = n_validacao(1:len_validacao-passo);
x_1_3_validacao = x_validacao(1:len_validacao-passo);
x_n_3_validacao = x_validacao(passo-1:len_validacao-passo+1);
x_n1_3_validacao = x_validacao(passo:len_validacao-passo+2);


x_1_3_v = -10;
x_n_3_v = x_validacao(2);
x_n1_3_v = x_validacao(3);

inputs_1_v = [];
outputs_1_v = [];
for i=1:length(n_1_3_v)
    inputs_1_v(:,i) = [n_1_3_v(i); x_1_3_v; x_n_3_v; x_n1_3_v];
    outputs_1_v(:,i) = rna_16_20_3(inputs_1_v(i));
    x_1_3_v = outputs_1_v(1,i);
    x_n_3_v = outputs_1_v(2,i);
    x_n1_3_v = outputs_1_v(3,i);
end

x_1_3_v = -10;
x_n_3_v = x_validacao(2);
x_n1_3_v = x_validacao(3);
inputs_2_v = [];
outputs_2_v = [];
for i=1:length(n_1_3_v)
    inputs_2_v(:,i) = [n_1_3_v(i); x_1_3_v; x_n_3_v; x_n1_3_v];
    outputs_2_v(:,i) = rna_20_3(inputs_2_v(i));
    x_1_3_v = outputs_2_v(1,i);
    x_n_3_v = outputs_2_v(2,i);
    x_n1_3_v = outputs_2_v(3,i);
end

x_1_3_v = -10;
x_n_3_v = x_validacao(2);
x_n1_3_v = x_validacao(3);
inputs_3_v = [];
outputs_3_v = [];
for i=1:length(n_1_3_v)
    inputs_3_v(:,i) = [n_1_3_v(i); x_1_3_v; x_n_3_v; x_n1_3_v];
    outputs_3_v(:,i) = rna_28_3(inputs_3_v(i));
    x_1_3_v = outputs_3_v(1,i);
    x_n_3_v = outputs_3_v(2,i);
    x_n1_3_v = outputs_3_v(3,i);
end

figure(9),
subplot(431),
plot(outputs_1_v(1,:),'r'), hold on
plot(x_1_3_validacao,'b')
subplot(432),
plot(outputs_1_v(2,:),'r'), hold on
plot(x_n_3_validacao,'b');
subplot(433),
plot(outputs_1_v(3,:),'r'), hold on
plot(x_n1_3_validacao,'b')
subplot(434),
plot(outputs_2_v(1,:),'r'), hold on
plot(x_1_3_validacao,'b')
subplot(435),
plot(outputs_2_v(2,:),'r'), hold on
plot(x_n_3_validacao,'b');
subplot(436),
plot(outputs_2_v(3,:),'r'), hold on
plot(x_n1_3_validacao,'b')
subplot(437),
plot(outputs_3_v(1,:),'r'), hold on
plot(x_1_3_validacao,'b')
subplot(438),
plot(outputs_3_v(2,:),'r'), hold on
plot(x_n_3_validacao,'b');
subplot(439),
plot(outputs_3_v(3,:),'r'), hold on
plot(x_n1_3_validacao,'b')






