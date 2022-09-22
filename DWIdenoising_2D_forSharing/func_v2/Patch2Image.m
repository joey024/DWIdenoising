function      img_out = Patch2Image(img_in, wei_in, Para)

% Reconstruction
img_out = zeros(Para.Nx, Para.Ny, Para.Ndir);
img_wei = zeros(Para.Nx, Para.Ny, Para.Ndir);

r = 1:1:Para.maxr;
c = 1:1:Para.maxc;


idx = 0;
for kk = 1:1:Para.Ndir
    for jj = 1:Para.ps(2)
        for ii = 1:Para.ps(1)
                idx = idx+1;
                img_out(c-1+ii, r-1+jj, kk)  =  img_out(c-1+ii, r-1+jj, kk) + reshape( img_in(idx,:)', [Para.maxc Para.maxr] );
                img_wei(c-1+ii, r-1+jj, kk)  =  img_wei(c-1+ii, r-1+jj, kk) + reshape( wei_in(idx,:)', [Para.maxc Para.maxr] );

        end
    end
end
img_out  =  img_out ./ img_wei;