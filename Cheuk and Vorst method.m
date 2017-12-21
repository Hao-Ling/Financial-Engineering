function Option_Value=FC_HW4_bonus2(St,r,q,sigma,T,t,Smax,n,NoS,NoR)
	delta_t = (T-t)/n;
	u = exp(sigma*sqrt(delta_t));
	d = 1/u;
	p = (exp((r-q)*delta_t)-d)/(u-d);
	
	for i=1:n+1
		for j=i:n+1
			X(i,j) = u^(j-i) - 1;
			if j==n+1
                Option(i,j) = X(i,j);
				E(i,j)=X(i,j);
            end
        end
    end
	
	for j=n:-1:1
		for i=1:j
			if (i~=j)
				E(i,j) = exp(-r*delta_t)* ((1 - p)*E(i,j+1)*d + p*E(i+2,j+1)*u);			
			else
				E(i,j) = exp(-r*delta_t)* ((1 - p)*E(i,j+1)*d + p*E(i+1,j+1)*u);			
			end
		end
	end
	
	for j=n:-1:1
		for i=1:j
			if (i~=j)
				Option(i,j) = max(X(i,j),exp(-r*delta_t)* ((1 - p)*Option(i,j+1)*d + p*Option(i+2,j+1)*u));			
			else
				Option(i,j) = max(X(i,j),exp(-r*delta_t)* ((1 - p)*Option(i,j+1)*d + p*Option(i+1,j+1)*u));			
			end
		end
	end

	Option_Value = St*Option(1,1);
	E_Value = St*E(1,1);
	
	fprintf('European put is %f\n', E_Value);
	fprintf('American put is %f\n', Option_Value);
	
end