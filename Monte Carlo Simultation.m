function [y up low]=FC_HW1_MonteCarlo(S0, r, q, sigma, T, K1, K2, K3, K4)
    A=(K2-K1)+(K2-K1)/(K4-K3)*K3;
    B=(K2-K1)/(K4-K3);
    M=10000;        
    for i=1:20
        %samples = normrnd( (log(S0)+(r-q-(sigma.^2)/2)*T) , (sigma)*sqrt(T), 1, 10000);
        
        ST_samples = S0*exp( (r-q-0.5*sigma^2)*T + sigma*sqrt(T)*randn(M,1) );
        for j=1:M
            if(ST_samples(j)>=K1 && ST_samples(j)<K2)
                payoff(j) = ST_samples(j)-K1;
            elseif(ST_samples(j)>=K2 && ST_samples(j)<K3)
                payoff(j) = K2-K1;
            elseif(ST_samples(j)>=K3 && ST_samples(j)<K4)
                payoff(j) = (K2-K1)+-(K2-K1)/(K4-K3)*(ST_samples(j)-K3);
            else
                payoff(j) = 0;  
            end
        end
        tmp =  exp(-r*T)*payoff;
        value(i) = mean(tmp);
        clear ST_samples;
    end
    
    y = mean(value);
    %y_std = 1.96*std(value)/sqrt(M);
    y_std = std(value);
    %fprintf('result is %f\n',y);
    up = y+2*y_std;
    low = y-2*y_std;
    %display([y-2*y_std y+2*y_std]);
    fprintf('95 confidence : %f ~ %f',up,low);
end