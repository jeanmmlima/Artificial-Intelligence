//UFRN-DCA-OTIMIZACAO
//Aluno: Jean Mario M Lima

//---- P S O  -------

//1. FUNCAO A SER OTIMIZADA

function w9=ValoresFuncoes(x, y)
z=-x.*sin(sqrt(abs(x)))-y.*sin(sqrt(abs(y)));
x=x/250;
y=y/250;
// r: Rosenbrock's function
r=100*(y-x.^2).^2+(1-x).^2;
r1=(y-x.^2).^2+(1-x).^2;
rd=1+r1;
//
x1=25*x;
x2=25*y;
xs =-10:0.1:10;
ys =-10:0.1:10;
a=500;
b=0.1;
c=0.5*%pi;
//
F10=-a*exp(-b*sqrt((x1.^2+x2.^2)/2))-exp((cos(c*x1)+cos(c*x2))/2)+exp(1);
//
[n nx]=size(xs);
[n ny]=size(ys);
for i=1:nx
for j=1:ny
zsh(i,j)=0.5-((sin(sqrt(xs(i)^2+ys(j)^2)))^2-0.5) ./(1+0.1*(xs(i)^2+ys(j)^2))^2;
end
end
//
Fobj=F10.*zsh(1);

w2=z-r1;
w4=sqrt(r.^2+z.^2)+Fobj;
w9 = w2 - w4;
endfunction

//2. INICIA ENXAME
function [enxame]=startSwarm(linhas, colunas, vMIN, vMAX)
enxame = zeros(linhas,colunas);
for i = 1: linhas
for j = 1: colunas
enxame(i,j) = rand(1,1) * ( vMAX(j)-vMIN(j) ) + vMIN(j);
end
end
endfunction


//3. FUNCAO PSO
function [bestX,valorFunc]=pso(xmin,xmax,populacao,iterations)
N_PAR=2;
N = populacao;
N_GER = iterations;
param_c1 = 1.5;
param_c2 = 1.5;
v=zeros(N,N_PAR);
X_MAX = xmax;
X_MIN = xmin;
wmax=0.9;
wmin=0.4;
for i=1:N_GER
//     W(i)=wmax-((wmax-wmin)/N_GER)*i;
W(i) = 1;
end
vmin=-(max(xmax)-min(xmin))/(N*5);
vmax=(max(xmax)-min(xmin))/(N*5);

gMelhor = zeros(1,N_PAR);


gMelhorValor = 1000000;

gaux = ones(N,1);

bestX=zeros(N,N_PAR);
ValorMelhor=zeros(N,1);

valorFunc = zeros(N,1);
nger=1;

x=startSwarm(N, N_PAR, X_MIN, X_MAX);

for j=1:N

valorFunc(j)=ValoresFuncoes(x(j,1),x(j,2));
ValorMelhor(j)=valorFunc(j);
end


[a,b]=min(valorFunc);


gMelhor=x(b,:);
gMelhorValor = valorFunc(b);

bestX = x;

while(nger<=N_GER)
i=1;

numRandomico1 = rand (N, N_PAR);
numRandomico2 = rand (N, N_PAR);

v = W(nger).*v + numRandomico1.*(param_c1.*(bestX-x)) + numRandomico2.*(param_c2.*(gaux*gMelhor-x));

v = ( (v <= vmin).*vmin ) + ( (v > vmin).*v );
v = ( (v >= vmax).*vmax ) + ( (v < vmax).*v );

x = x+v;

for j = 1:N,
for k = 1:N_PAR,
if x(j,k) < X_MIN(k)
x(j,k) = X_MIN(k);
elseif x(j,k) > X_MAX(k)
x(j,k) = X_MAX(k);
end
end
end

while(i<=N)
if(i==N)
for j=1:N

valorFunc(j)=ValoresFuncoes(x(j,1),x(j,2));
if valorFunc(j) < ValorMelhor(j)
ValorMelhor(j) = valorFunc(j);
bestX(j,:) = x(j,:);
end
end

[a,b]=min(valorFunc);
if (valorFunc(b) < gMelhorValor)
gMelhor=x(b,:);
gMelhorValor = valorFunc(b);
end


end
i=i+1;
end
nger=nger+1;
end
scf(2);
clf(2);
xtitle("Minimo por Geracao");
plot(x(:,1),'x');
plot(x(:,2),'o');
legend('Minimo Global','Posicoes Encontradas');
xgrid();
xpause(50000);
bestX=gMelhor;
Valor=gMelhorValor;
endfunction

//4. TESTE

[melhorX,fit]= pso([-500 -500],[500 500],40,10);
disp([melhorX,fit]);
