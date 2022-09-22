function  Para  =  SearchIndex(Para)
% Calculate indexes for all reference patches

%%%% Calculate total number of patches (step = 1)
Para.maxc  = Para.Nx - Para.ps(1) + 1;
Para.maxr  = Para.Ny - Para.ps(2) + 1;
Para.maxrc = Para.maxr * Para.maxc ;

%%%% Calculate total number of reference patches (extracted using sliding window with Para.step)
r = 1:Para.step:Para.maxr;
r = [r r(end) + 1:Para.maxr]; % ensure the pixels on the edge can be extracted
c = 1:Para.step:Para.maxc;
c = [c c(end) + 1:Para.maxc]; 

lenr  = length(r);
lenc  = length(c);
Para.lenrc = lenr * lenc ;

%%%% index of each patch in image
Para.Index  =   (1:Para.maxrc);
Para.Index  =   reshape(Para.Index, Para.maxc, Para.maxr);
Para.SelfIndex   =   int32(zeros(1, Para.lenrc));


for jj  =  1 : lenr
    for kk  =  1 : lenc
          
         off1 = (jj-1)*lenc + kk;
         Para.SelfIndex(off1) = (r(jj)-1)*Para.maxc + c(kk);

    end
end
