function [ x ] = funcQuest4( n )
    for i=1:length(n)
        x(i) = log(1+cos(n(i)+(sin(n(i))^2)));
    end
end

