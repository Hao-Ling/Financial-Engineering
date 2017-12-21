function Option_Value = FC_HW4(St,r,q,sigma,T,t,Smax,n,NoS,NoR)
	%Binomial Tree%
	%Build the tree data structure, x:Stock price, y:Maximum stock price, z:option value %
	
	S_price(1,1)=St; max_price(1,1,1)=Smax; 
	delta_t = (T-t)/n;                  % the period
   u = exp(sigma*sqrt(delta_t));   		% up ratio
   d = 1/u;                        		% down ratio
   p = (exp((r-q)*delta_t)-d)/(u-d);   % up probability
	%time = delta_t:delta_t:T-t;
	%Build the stock price tree%
	for i=1:NoR
		for j=1:NoS
			for k=2:n
				sample(j,1)=St;
				sample(j,k) = normrnd(log(sample(j,k-1))+(r-q-sigma^2/2)*(delta_t*1), sigma*sqrt(delta_t*1), 1, 1);
			end
			sample2(j,:) = exp(sample(j,:));
			value(j) = max(max(sample2(j,:)),Smax)-sample2(j,n);
		end
		%plot(time,sample2(1:10,:));
		
		value2(i) = exp(-r*T)*mean(value);
	end
	
	Option_Value = mean(value2);
end

