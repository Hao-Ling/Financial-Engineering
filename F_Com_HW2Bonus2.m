function [Call_Value, Put_Value] = F_Com_HW2Bonus2(S0, K, r, q, sigma, T, NS, NR, n)
  
	Delta_t = T/n;
	upper_ratio = exp(sigma*sqrt(Delta_t));  
	down_ratio = 1/upper_ratio;
	p = (exp(r*Delta_t)-down_ratio)/(upper_ratio-down_ratio);
	Call_Value=0;
	Put_Value=0;
	for j=0:n
	
		%Compute the natural log combination%
		Comb=0;
		for i=j+1:n
			Comb = Comb+log(i);
		end
		for l=1:n-j
			Comb = Comb-log(l);
		end
		Comb = Comb+(n-j)*log(p)+j*log(1-p);
		%------------------------%
		%Real Combination Value%
		Comb = exp(Comb);
		Call_Value = Call_Value+Comb*max((S0*(upper_ratio.^(n-j))*(down_ratio.^j))-K, 0);
		Put_Value = Put_Value+Comb*max(K-(S0*(upper_ratio.^(n-j))*(down_ratio.^j)), 0);		
    end
    %discounted
        Call_Value = exp(-r*T)*Call_Value;
        Put_Value = exp(-r*T)*Put_Value;
	
end