% 3.a
clear;
n_max=1000000;

for i=1:n_max
    if rand <.5
        S(i)=1;
    else
        S(i)=-1;
    end
end

% Setting factors
db=[0:1:15]; 
SNR = power(10,db/10);
ph=pi;
A=1;
[len1,len2]=size(SNR);
for j = 1:len2
    variance(j) =power(A,2)/8/SNR(j);
    threshold(j)=sqrt(-2*variance(j)*log(1e-4));
    noise1=normrnd(0,variance(j),[1,n_max]);
    noise2=normrnd(0,variance(j),[1,n_max]);
    for i = 1:n_max
        n1(i)=noise1(i);
        n2(i)=noise2(i);
        r1(i)= S(i)*A*cos(ph)+n1(i);
        r2(i)= S(i)*A*sin(ph)+n2(i);
        z(i)=power(r1(i),2)+power(r2(i),2);
    end
    presented(j) = 0;
    for i=1:n_max
        if z(i) > threshold(j)
            presented(j) = presented(j)+1;
        else
            presented(j) = presented(j);
        end
    end
    probability_a(j)= presented(j) / n_max;
end

figure(7)
semilogy(db,probability_a);
title('Direct Integration')
xlabel('SNR(db)')
ylabel('Pb(db)')

