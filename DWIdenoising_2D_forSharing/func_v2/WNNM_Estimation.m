function [ Y_hat, W_hat] = WNNM_Estimation( NL_mat, Sigma_arr, CurPat, Para )

Y_hat = zeros(size(CurPat));
W_hat = zeros(size(CurPat));
for  i = 1:length(Para.SelfIndex) % For each patch matrix
    
     Y  = CurPat(:, NL_mat(1:Para.PatNum,i)); 
     mY = repmat(mean( Y, 2 ),1,Para.PatNum);
     Y  = Y-mY;
     TempC     = Para.PatNum*prod(Para.ps)*Para.Ndir*Sigma_arr(Para.SelfIndex(i))^2;
     [U, SigmaTemp, V] =   svd(Y, 'econ');
     SigmaY = diag(SigmaTemp);
     
     if Para.RankMode == 1    % WNNM
        temp = SigmaY.^2 - 0.01*TempC; 
        ind  = find (temp > 0);
        svp  = length(ind);
     elseif Para.RankMode == 2 % Hard thresholding
 
     elseif Para.RankMode == 3  % Hard thresholding via GCV
          
     end
    
     SigmaX = max(SigmaY(1:svp) - 1./(eps + 0.005*sqrt(temp(1:svp))), 0);
     X =  U(:, 1:svp) * diag(SigmaX) * V(:, 1:svp)';
     
     Y_hat(:,NL_mat(1:Para.PatNum,i))  = Y_hat(:,NL_mat(1:Para.PatNum,i))+X+mY; 
     W_hat(:,NL_mat(1:Para.PatNum,i))     = W_hat(:,NL_mat(1:Para.PatNum,i))+ones(prod(Para.ps)*Para.Ndir, Para.PatNum);
     
    
     
end
end

