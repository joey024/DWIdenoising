function [E_Img]   =  WNNM_Denoising(N_Img, Para)
E_Img  = N_Img;   % Initializtion
Para   = SearchIndex(Para);
NoiPat = Image2Patch(N_Img, Para);

Sigma_arrCh = zeros(Para.Ndir, Para.maxrc);
for iter = 1 : Para.iter
    % iterative regularization
    E_Img  = E_Img + Para.delta * (N_Img - E_Img);
    % image to patch
    CurPat = Image2Patch( E_Img, Para );

    % estimate local noise variance
    if iter == 1
       Sigma_arrCh = Para.nSig0 * ones(size(Sigma_arrCh));    
    else
       Sigma_arrCh = Para.lamada*sqrt(abs(repmat(Para.nSig0^2,1,size(CurPat,2))-mean((NoiPat-CurPat).^2))); 
    end
    
    % patch matching
    if (mod(iter-1, Para.InnerLoop) == 0) 
        NL_mat  =  Block_Matching(CurPat, Para); % Caculate Non-local similar patches for each reference patch
    end
    
    % patch matrix denoising via WNNM
    [Y_hat, W_hat]  =  WNNM_Estimation( NL_mat, Sigma_arrCh, CurPat, Para );   
    E_Img = Patch2Image(Y_hat, W_hat, Para);

  
end
return;





