%SCRIPT PARA AQUISIÇÃO DOS DADOS NA PLANTA REAL
clear all
clc

nome_modelo = 'Tanques.slx';
simulation_Time = 12000;
%num_sim = 10;

data_V=[];
data_L2=[];


set_param(nome_modelo,'SimulationCommand','start')
pause(simulation_Time)
set_param(nome_modelo,'SimulationCommand','stop')

sim(nome_modelo,simulation_Time);

data_L2 = DadoScope(:,2);
data_V = DadoScope(:,3);

data_L2_norm = data_L2./max(data_L2);
data_V_norm = data_V./max(data_V);
%% aplicando atrasos grau X
numero_grau = 1;
saida_L2 = data_L2(numero_grau+1:end,1)

entrada_L2_atrasada(1:end-numero_grau,1)
entrada_V_atrasada(1:end-numero_grau,1)
