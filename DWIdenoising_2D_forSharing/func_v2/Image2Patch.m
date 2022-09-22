function       img_out = Image2Patch(img_in, Para)
% Reshape image to row vectors through sliding window
%
%     Args:
%         img_in(3D)     : Difusion weighted images
%         Para           : Parameters
%     Return:
%         img_out(2D)    : row vectors matrix
%     Warning: 
%         1. 3D images is reshaped direction-wise (the 3rd dimension is DWIs with different diffusion directions and/or weightings). 
%         2. Window slide from top to bottom, then left to right.
%         3. Data point read from top to bottom, then left to right.
%         4. Example:
%            [10 11 12 13                       
%             14 15 16 17                 
%             18 19 20 21       
%             22 23 24 25]direction 1                       [10 14 11 15 30 34 31 35 vector 1          
%                                            ---->           14 18 15 19 34 38 35 39 vector 2
%            [30 31 32 33              winsize = [2 2 2]     18 22 19 23 38 42 39 43 vector 3             
%             34 35 36 37                                    ...........]              ...                                                                                    
%             38 39 40 41  
%             42 43 44 45]direction 2                  
%
% (c) Yujiao 2022.01.04

idx    =  0;


for jj = 1:Para.ps(2)
    for kk = 1:Para.ps(1)
            idx =  idx+1;
            blk(:,:,idx,:)  = img_in(kk:end-Para.ps(1)+kk, jj:end-Para.ps(2)+jj, :);        
    end
end


img_out = reshape(blk,[Para.maxrc prod(Para.ps)*Para.Ndir]);
img_out = img_out';