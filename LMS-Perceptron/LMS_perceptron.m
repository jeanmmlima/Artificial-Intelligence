clc
close all
clear all

N=input('length of sequence N = (5): ');
t=[1:N];
w0=0.001;  phi=0.1;

%% 1. FONTE DE SINAL 
d=sin(0.075*pi*[1:N]); 

%PLOTS 331

h5=figure(5);
set(h5,'position',[100 70 1200 600]);
subplot(331),plot(t,d,'LineWidth',2),ylabel('Amplitude','fontweight','b'),...
xlabel('tempo','fontweight','b');
title('Sinal da Fonte','fontweight','b');
grid on;
%% 2. FONTE DE RUÍDO

%RUÍDO DE ENTRADA NO SENSOR 1 (v1) E NO SENSOR 2 (v2)%%%%%%%%%%%%%%%%%%%%%%
v1(1)=0; v2(1)=0;
for i=2:N
    v=rand;
    v1(i)=-0.5*v1(i-1)+v;
    v2(i)= 0.8*v2(i-1)+v;
end
 
subplot(334),plot(t,v1,'LineWidth',2),ylabel('Amplitude','fontweight','b'),...
xlabel('tempo','fontweight','b');
title('Ruído captado pelo sensor 1','fontweight','b');
grid on;
subplot(335),plot(t,v2,'LineWidth',2),ylabel('Amplitude','fontweight','b'),...
xlabel('tempo','fontweight','b');
title('Ruído captado pelo sensor 2','fontweight','b');
grid on;

%% 3. SINAL DE SAÍDA DO SENSOR 1 E DO SENSOR 2
for i=2:N
    x(i)=d(i)+v1(i);
    y(i)=v2(i);
end
subplot(337),plot(t,x,'LineWidth',2),ylabel('Amplitude','fontweight','b'),...
xlabel('tempo','fontweight','b');
title('Sinal de saída sensor 1','fontweight','b');
grid on;
subplot(338),plot(t,y,'LineWidth',2),ylabel('Amplitude','fontweight','b'),...
xlabel('tempo','fontweight','b');
title('Sinal de saída do sensor 2','fontweight','b');
grid on;

 
 %% 4. ALGORITMO LMS - FILTRO - 5 ENTRADAS
 
 % Inicializando os pesos
 w = [2*rand-1; 2*rand-1; 2*rand-1; 2*rand-1; 2*rand-1; 2*rand-1; 2*rand-1];
 % Taxa de Aprendizagem
 eta = 0.01;
 
 for i=6:N
     %ENTRADA DA REDE PERCEPTRON
     inputs = [-1 v2(i) v2(i-1) v2(i-2) v2(i-3) v2(i-4) v2(i-5)];
     
     yd(i) = sum(inputs*w);
     %Erro representa o sinal com a anulação do ruído v1 causada pela
     %subtração de yd - saída da rede
     e(i) = x(i) - yd(i);
     
     %Atualização dos pesos
     w = w+(eta*inputs*e(i))';
 end
 
 %% 5. PLOTS
 
figure(1)
plot(d,'r')
hold on, plot(x,'g-.')
hold on, plot(e,'b')
ylabel('Amplitude','fontweight','b');
xlabel('tempo','fontweight','b');
legend('Fonte de Sinal s(n)','Sinal com Ruído s(n)+v1(n)','Sinal com Ruído Cancelado')
grid on

%% TREINAMENTO DE MLP

for i=1:N-6
    inputData(:,i) = [-1 v2(i+5) v2(i+4) v2(i+3) v2(i+2) v2(i+1) v2(i)];
end

targetData = v1(1:1:994);
%% PLOTS 2

figure(2)
subplot(311),plot(RNA_1_7_outputs,'r')
hold on, plot(v1,'g-.')
grid on

d_ = d(1:1:994);
x_ = x(1:1:994);

figure(3),title('Respostas das Melhores Redes')
subplot(211),plot(d_,'r')
hold on, plot(x_,'g-.')
hold on, plot(x_ - RNA_1_7_outputs,'b')
ylabel('Amplitude','fontweight','b');
xlabel('tempo','fontweight','b');
legend('Fonte de Sinal s(n)','Sinal com Ruído s(n)+v1(n)','Sinal com Ruído Cancelado')
grid on

subplot(212),plot(d_,'r')
hold on, plot(x_,'g-.')
hold on, plot(x_ - RNA_2_14_21_outputs,'b')
ylabel('Amplitude','fontweight','b');
xlabel('tempo','fontweight','b');
legend('Fonte de Sinal s(n)','Sinal com Ruído s(n)+v1(n)','Sinal com Ruído Cancelado')
grid on


%% EMS 

   ems_rna_1_7 = sum((x_-RNA_1_7_outputs).^2)/(N-6);
   ems_rna_1_10 = sum((x_-RNA_1_10_outputs).^2)/(N-6);
   ems_rna_1_14 = sum((x_-RNA_1_14_outputs).^2)/(N-6);
   ems_rna_1_28 = sum((x_-RNA_1_28_outputs).^2)/(N-6);
   
   ems_rna_2_7_14 = sum((x_-RNA_2_7_14_outputs).^2)/(N-6);
   ems_rna_2_14_7 = sum((x_-RNA_2_14_7_outputs).^2)/(N-6);
   ems_rna_2_14_21 = sum((x_-RNA_2_14_21_outputs).^2)/(N-6);
   
   
figure(4)
stem(1,ems_rna_1_7,'r','LineWidth',12),hold on
stem(1.5,ems_rna_1_10,'b','LineWidth',12),hold on
stem(2,ems_rna_1_14,'g','LineWidth',12),hold on
stem(2.5,ems_rna_1_28,'cyan','LineWidth',12),hold on
stem(3,ems_rna_2_7_14,'magenta','LineWidth',12),hold on
stem(3.5,ems_rna_2_14_7,'yellow','LineWidth',12),hold on
stem(4,ems_rna_2_14_21,'black','LineWidth',12),hold on
ylabel('EMS absoluto','fontweight','b');
xlabel('Arquiteturas','fontweight','b');
legend('1 CO e 7 Neurônios','1 CO e 10 Neurônios','1 CO e 14 Neurônios','1 CO e 28 Neurônios','2 CO e 7 e 14 Neurônios','2 CO e 14 e 7 Neurônios','2 CO e 14 e 21 Neurônios');
grid on

