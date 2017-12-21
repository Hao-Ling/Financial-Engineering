function Option_Value = FC_HW3(K, r, T, NoS, NoR, n, So, q, sigma, rho)
	% Where So, q, sigma are vectors and number of elements is n. %
	% rho is a n-by-n matrix %
	
	rho_matrix = rho;
	rho_matrix(logical(eye(n)))=1;
	
	% Build the covariance matrix %
	Covariance_Matrix = (repmat(sigma',1,n)).*(repmat(sigma',1,n))'.*rho_matrix*T;
	
	% A'*A=C %
	%A = chol(Covariance_Matrix); 
	A = Cholesky_decomposition(Covariance_Matrix);
	%pause;
	for j=1:NoR
		% Generate r vector from normal distribution % 
		gamma = normrnd(0,1,n,NoS);
		
		% Save the data for bonus1 used %
		if(j==1)
			f=fopen('test.dat','w+');
			fprintf(f,'%f\n',gamma);
			fclose(f);
		else
			f=fopen('test.dat','a+');
			fprintf(f,'%f\n',gamma);
			fclose(f);
		end
		gamma = (gamma'*A);
		
		% Debug Term %
		%mu = [log(So(1))+(r-q(1)-(sigma(1).^2)/2)*T log(So(2))+(r-q(2)-(sigma(2).^2)/2)*T];
		%SIG = [0.25 0; 0 0.25];
		%gamma_d = mvnrnd(mu,SIG,NoS);
		%gamma_d = (gamma_d*A);
		%%%%%%%%%%%%%%
		
		% Calculate the stock value %
		ST=exp(gamma(:,:)+(ones(NoS,1)*(log(So)+(r-q-(sigma.^2)/2)*T)));
		max_value = max((ST-K)');
		each_option = max(max_value,0); 
		each_option_mean(j) = exp(-r*T)*mean(each_option);
	end
	
	Option_Value = mean(each_option_mean);
	Option_Value_std = std(each_option_mean);
	
	fprintf('Option Value is %f\n',Option_Value);
    fprintf('and 95 confidence : %f ~ %f\n',Option_Value-2*Option_Value_std, Option_Value+2*Option_Value_std);
 
end