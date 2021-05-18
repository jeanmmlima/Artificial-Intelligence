function [ OUTS ] = validaRedes( RNA, validV, validL2, ordem)

tamV = length(validV);
d = 10;
itens = d + ordem;
outsAtrasadas = [];
input = [];
OUTS = [];

outsAtrasadas = [outsAtrasadas validL2(:,1:itens)];

for i=1:tamV
    
    input(:,i) = [validV(:,i); outsAtrasadas(:,i)];
    OUTS(:,i) = RNA(input(:,i));
    p = i/tamV * 100;
    TEX = sprintf('Validação: %f%% \n',p);
    disp(TEX);
    
    outsAtrasadas = [outsAtrasadas OUTS(:,i)];

end


end

