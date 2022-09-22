function       blk_arr = Block_Matching( X, Para)
% record the indexs of patches similar to the seed patch
blk_arr   =  zeros(Para.PatNum, Para.lenrc, 'single');

if Para.fastmode == 1
    gpuX=gpuArray(X);
    for  i  =  1 : Para.lenrc
         off = Para.SelfIndex(i);
         % loc of current patch
         idx_r = floor(double(off-1)/Para.maxc)+1;
         idx_c = off - (idx_r-1)*Para.maxc;
         % the range indexes of the window for searching the similar patches
         rmin  =   max( idx_r - Para.SearchWinwin, 1 );
         rmax  =   min( idx_r + Para.SearchWinwin, Para.maxr );
         cmin  =   max( idx_c - Para.SearchWinwin, 1 );
         cmax  =   min( idx_c + Para.SearchWinwin, Para.maxc );
                     
         idx   =   Para.Index(cmin:cmax, rmin:rmax);
         idx   =   idx(:);
         
         % calculate distance
         seed = gpuX(:, off);
         neighbor = gpuX(:, idx);
         dis = sum(bsxfun(@minus, neighbor, seed).^2, 1);
         [~,ind]   =  sort(dis);
         blk_arr(:, i) = idx( ind( 1:Para.nlsp ));
    end
    clear gpuX
else
    for  i  =  1 : Para.lenrc
         off = Para.SelfIndex(i);
         % loc of current patch
         idx_r = floor(double(off-1)/Para.maxc)+1;
         idx_c = off - (idx_r-1)*Para.maxc;
         % the range indexes of the window for searching the similar patches
         rmin  =   max( idx_r - Para.SearchWin, 1 );
         rmax  =   min( idx_r + Para.SearchWin, Para.maxr );
         cmin  =   max( idx_c - Para.SearchWin, 1 );
         cmax  =   min( idx_c + Para.SearchWin, Para.maxc );
                     
         idx   =   Para.Index(cmin:cmax, rmin:rmax);
         idx   =   idx(:);
         
         % calculate distance
         seed = X(:, off);
         neighbor = X(:, idx);
               
         dis = sum(bsxfun(@minus, neighbor, seed).^2, 1);
         [~,ind]   =  sort(dis);
         blk_arr(:, i) = idx( ind( 1:Para.PatNum ));
    end
end