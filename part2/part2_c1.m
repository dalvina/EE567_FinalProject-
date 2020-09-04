clear all
clf
%set the factor
N=8; fc=10000/N; num=1000000; n=0:N*num-1; t=n*1/(fc*N);Eb=8;
%simulate the input signal
data=randsrc(1,num,[1,-1]);
data_bpsk=ones(N,1)*data;
data_bpsk=data_bpsk(:)';
x=data_bpsk;

%simulate the noise using Eb/N0=7
for k=0:100
    a=k/100;
    EbN0=7;
    ebn0=10^(EbN0/10);
    sigma=Eb/ebn0/2;
    n=sqrt(sigma)*randn(1,N*num);
    s=x+n;
    for i=1:num
        ii=8*(i-1)+1;
        y=0;
        for jj=ii:ii+7
            y=(1-a)*s(jj)+a*y;
        end
        if y>=0
            r_data(i)=1;
        else
            r_data(i)=-1;
        end
    end
    %simulate BER vs. alpha
    pe(k+1)=(sum(abs((r_data-data)/2)))/num;
end      
%plot
a=0:0.01:1;
plot(a,pe)
title('Bit Error Rate');
xlabel('\alpha');