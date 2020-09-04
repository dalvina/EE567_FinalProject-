function [ yr ] = IIRFilter( x,a )
%The IIR filter to construct a LPF
%x is the input signal
%a is the parameter

n=length(x);
yr=zeros(1,n);
yr(1)=x(1)*(1-a);
for ii=2:n
    yr(ii)=x(ii)*(1-a)+a*yr(ii-1);
end


end

