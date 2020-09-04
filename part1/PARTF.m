clear all
clf

N=8; a=(N-1)/(N+1); n=20; nn=1:n;
Xim=[1 zeros(1,n-1)];
Xst=ones(1,n);

%impulse response for each filter on the same graph using N = 8.
Yim=IDFilter(Xim,N);
Yrim=IIRFilter(Xim,a);
figure(1)
stem(nn,Yim); hold on
stem(nn,Yrim,'r'); 
title('impulse response');legend('I&D filter','IIR filter');


%step response for each filter on the same graph using N = 8.
Yst=IDFilter(Xst,N);
Yrst=IIRFilter(Xst,a);
figure(2)
stem(nn,Yst); hold on
stem(nn,Yrst,'r'); 
title('step response');legend('I&D filter','IIR filter');