function [ y ] = IDFilter( x,N )
%The I&D Filter 
%x is the input signal
%N is the length to calculate average

n=length(x);
if n<N
    error('the length of x must greater than N');
end
y=zeros(1,n);
for ii=1:n
    if ii<=N
        y(ii)=sum(x(1:ii))/N;
    else
        y(ii)=sum(x((ii-N+1):ii))/N;
    end
end

end

