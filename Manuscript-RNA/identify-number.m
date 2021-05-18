%%LISTA 3 - RNA - 2017.1
% Jean Mário

% QUESTÃO 4
%Matrizes 5 x 7

A = [ 0 0 0 0 0 0 0 ;...
      0 0 1 1 1 0 0 ;...
      0 0 0 0 0 0 0 ;...
      0 0 1 1 1 0 0 ;...
      0 0 1 1 1 0 0 ];
  
E = [ 0 0 0 0 0 0 0 ;...
      0 0 1 1 1 1 1 ;...
      0 0 0 0 0 0 0 ;...
      0 0 1 1 1 1 1 ;...
      0 0 0 0 0 0 0 ];
  
 I = [1 1 0 0 0 1 1 ;...
      1 1 0 0 0 1 1 ;...
      1 1 0 0 0 1 1 ;...
      1 1 0 0 0 1 1 ;...
      1 1 0 0 0 1 1 ];
  
 O = [0 0 0 0 0 0 0 ;...
      0 0 1 1 1 0 0 ;...
      0 0 1 1 1 0 0 ;...
      0 0 1 1 1 0 0 ;...
      0 0 0 0 0 0 0 ];
  
 U = [0 0 1 1 1 0 0 ;...
      0 0 1 1 1 0 0 ;...
      0 0 1 1 1 0 0 ;...
      0 0 1 1 1 0 0 ;...
      0 0 0 0 0 0 0 ];

%%
%plot das letras
figure(1),
subplot(2,3,1);imshow(A);
subplot(2,3,2);imshow(E);
subplot(2,3,3);imshow(I);
subplot(2,3,4);imshow(O);
subplot(2,3,5);imshow(U);

%vetorizando matrizes
A_v = reshape(A',35,1);
E_v = reshape(E',35,1);
I_v = reshape(I',35,1);
O_v = reshape(O',35,1);
U_v = reshape(U',35,1);

%% ruído nas vogais

nivelRuido = 0.15;
%A
A_nv = setNoise2Vogal(A_v,nivelRuido);
A_n = vect2Mat(A_nv);
%E
E_nv = setNoise2Vogal(E_v,nivelRuido);
E_n = vect2Mat(E_nv);
%I
I_nv = setNoise2Vogal(I_v,nivelRuido);
I_n = vect2Mat(I_nv);
%O
O_nv = setNoise2Vogal(O_v,nivelRuido);
O_n = vect2Mat(O_nv);
%U
U_nv = setNoise2Vogal(U_v,nivelRuido);
U_n = vect2Mat(U_nv);

%plot das letras com ruído
figure(2),
subplot(2,3,1);imshow(A_n);
subplot(2,3,2);imshow(E_n);
subplot(2,3,3);imshow(I_n);
subplot(2,3,4);imshow(O_n);
subplot(2,3,5);imshow(U_n);        
        
%% Treinamento
P = [A_nv'; E_nv'; I_nv'; O_nv'; U_nv']';
T = [A_nv'; E_nv'; I_nv'; O_nv'; U_nv']';
net = newp([0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;...
            0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;...
            0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1], 35);

pesoInicial = net.IW{1,1};
net = train(net,P,T);
pesoFinal = net.IW{1,1};

%% Validacao

y = sim(net,A_v);
A_y = vect2Mat(y);

y = sim(net,E_v);
E_y = vect2Mat(y);

y = sim(net,I_v);
I_y = vect2Mat(y);

y = sim(net,O_v);
O_y = vect2Mat(y);

y = sim(net,U_v);
U_y = vect2Mat(y);

figure(3),
subplot(3,4,1);imshow(A);
subplot(3,4,2);imshow(A_y);
subplot(3,4,3);imshow(E);
subplot(3,4,4);imshow(E_y);
subplot(3,4,5);imshow(I);
subplot(3,4,6);imshow(I_y);
subplot(3,4,7);imshow(O);
subplot(3,4,8);imshow(O_y);
subplot(3,4,9);imshow(U);
k=10;
subplot(3,4,k);imshow(U_y);

%% validacao com outras vogais ruidosas

nivelRuido = 0.1;
%A
A_nv = setNoise2Vogal(A_v,nivelRuido);
A_n = vect2Mat(A_nv);
%E
E_nv = setNoise2Vogal(E_v,nivelRuido);
E_n = vect2Mat(E_nv);
%I
I_nv = setNoise2Vogal(I_v,nivelRuido);
I_n = vect2Mat(I_nv);
%O
O_nv = setNoise2Vogal(O_v,nivelRuido);
O_n = vect2Mat(O_nv);
%U
U_nv = setNoise2Vogal(U_v,nivelRuido);
U_n = vect2Mat(U_nv);

%plot das letras com ruído
figure(2),
subplot(2,3,1);imshow(A_n);
subplot(2,3,2);imshow(E_n);
subplot(2,3,3);imshow(I_n);
subplot(2,3,4);imshow(O_n);
subplot(2,3,5);imshow(U_n);        
        
%% Validacao - 2

y = sim(net,A_nv);
A_y = vect2Mat(y);

y = sim(net,E_nv);
E_y = vect2Mat(y);

y = sim(net,I_nv);
I_y = vect2Mat(y);

y = sim(net,O_nv);
O_y = vect2Mat(y);

y = sim(net,U_nv);
U_y = vect2Mat(y);

figure(3),
subplot(3,4,1);imshow(A_n);
subplot(3,4,2);imshow(A_y);
subplot(3,4,3);imshow(E_n);
subplot(3,4,4);imshow(E_y);
subplot(3,4,5);imshow(I_n);
subplot(3,4,6);imshow(I_y);
subplot(3,4,7);imshow(O_n);
subplot(3,4,8);imshow(O_y);
subplot(3,4,9);imshow(U_n);
k=10;
subplot(3,4,k);imshow(U_y);




