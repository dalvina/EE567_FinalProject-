% 3.b
clear
n_max=1000000;
N=16;
M=8;
for i=1:n_max+N
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
    variance(j) =power(A,2)/2/SNR(j);
    threshold(j)=sqrt(-2*variance(j)*(log(1e-4)))*0.13;
    noise1=normrnd(0,variance(j),[1,n_max+N]);
    noise2=normrnd(0,variance(j),[1,n_max+N]);
    for i = 1:n_max+N
        n1(i)=noise1(i);
        n2(i)=noise2(i);
        r1(i)= S(i)*A*cos(ph)+n1(i);
        r2(i)= S(i)*A*sin(ph)+n2(i);
        z(i)=power(r1(i),2)+power(r2(i),2);
    end
    
    presented(j) = 0;
    for a=1:n_max
        count(a)=0;
        presented(a)=0;
        for b=1:N
            if z(a+b) > threshold(j)
                count(a) = count(a)+1;
            else
                count(a) = count(a);
            end
        end
        if count(a)>=M
            presented(a)=presented(a)+1;
        else
            presented(a)=presented(a);
        end      
    end
    probability_c(j)= sum(presented) / n_max;
end

figure(9)
semilogy(db,probability_c);
title('M of N logic detector')
xlabel('SNR(db)')
ylabel('Pb(db)')
