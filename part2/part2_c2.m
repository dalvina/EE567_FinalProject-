clear all
clf
%set the factors
N=8; fc=10000/N; num=1000000; n=0:N*num-1; t=n*1/(fc*N);Eb=8;
a=(N-1)/(N+1);a_new=0.99;
%simulate the input signal
data=randsrc(1,num,[1,-1]);
data_bpsk=ones(N,1)*data;
data_bpsk=data_bpsk(:)';
x=data_bpsk;
%simulate the noise
for EbN0=0:10
    ebn0=10^(EbN0/10);
    sigma=Eb/ebn0/2;
    n=sqrt(sigma)*randn(1,N*num);
    s=x+n;
    %using I&D filter with a=(N-1)/(N+1),make the decision on 1or-1 is sent
    for i=1:num
        ii=8*(i-1)+1;
        y=sum(s(ii:ii+7))/N;
        if y>=0
            r_data_ID(i)=1;
        else
            r_data_ID(i)=-1;
        end
    end
    %simulate BER of I&D filter using a=(N-1)/(N+1)
    pe_ID(EbN0+1)=(sum(abs((r_data_ID-data)/2)))/num;
    %using IIR filter with a=(N-1)/(N+1),make the decision on 1or-1 is sent
    for i=1:num
         ii=8*(i-1)+1;
         y=0;
         for jj=ii:ii+7
             y=(1-a)*s(jj)+a*y;
         end
         if y>=0
             r_data_IIR(i)=1;
         else
             r_data_IIR(i)=-1;
         end
    end
    %simulate BER of IIR filter using a=(N-1)/(N+1)
    pe_IIR(EbN0+1)=(sum(abs((r_data_IIR-data)/2)))/num;
    %using IIR filter with a=0.99,make the decision on 1or-1 is sent
    for i=1:num
         ii=8*(i-1)+1;
         y=0;
         for jj=ii:ii+7
             y=(1-a_new)*s(jj)+a_new*y;
         end
         if y>=0
             r_data_IIR_new(i)=1;
         else
             r_data_IIR_new(i)=-1;
         end
    end
    %simulate BER of IIR filter using a=0.99
    pe_IIR_new(EbN0+1)=(sum(abs((r_data_IIR_new-data)/2)))/num;
end
%plot
r=0:10;
semilogy(r,pe_ID,'b-v',r,pe_IIR,'g-x',r,pe_IIR_new,'r-x');
title('Bit Error Rate');legend('I&D Filter(\alpha=7/9)','IIR Filter(\alpha=7/9)','IIR Filter(\alpha=0.99)');
xlabel('Eb/N0');