function [EuroCall_Value, EuroPut_Value, AmeCall_Value,AmePut_Value] = F_Com_HW2Bonus1(S0, K, r, q, sigma, T, NS, NR, n)

    Delta_t = T/n;
	upper_ratio = exp(sigma*sqrt(Delta_t));  
	down_ratio = 1/upper_ratio;
	p = (exp((r-q)*Delta_t)-down_ratio)/(upper_ratio-down_ratio);
	C = zeros(n+1,1);%%to set a array for zero
	P = zeros(n+1,1);
	%Option Value at time T
	for i=0:n
		C(i+1)=max( (S0*(upper_ratio.^(n-i))*(down_ratio.^i))-K,0);
		P(i+1)=max( K-(S0*(upper_ratio.^(n-i))*(down_ratio.^i)),0);
    end	
	%back traced and discounted to Time 0
	C_Ame = C;
	P_Ame = P;	
	for i=1:n
		for j=1:(n-i+1)
			C(j)=exp(-r*Delta_t)*( p*C(j)+(1-p)*C(j+1) );
			P(j)=exp(-r*Delta_t)*( p*P(j)+(1-p)*P(j+1) );
			C_Ame(j)=max(exp(-r*Delta_t)*(p*C_Ame(j) + (1-p)*C_Ame(j+1)),S0*(upper_ratio.^(n-i-j+1))*(down_ratio.^(j-1))-K);
			P_Ame(j)=max(exp(-r*Delta_t)*(p*P_Ame(j) + (1-p)*P_Ame(j+1)),K-S0*(upper_ratio.^(n-i-j+1))*(down_ratio.^(j-1)));
		end
    end
    
    EuroCall_Value =C(j)
    EuroPut_Value  =P(j)
    AmeCall_Value  =C_Ame(j)
    AmePut_Value   =P_Ame(j)
    
    
    
    
end