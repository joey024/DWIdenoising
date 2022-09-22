clear all;close all;clc;
addpath('.\func_v2'); warning('1-mode unfolding!')
addpath('.\data'); 

%% Preparation
%%%% load img
load('fiberfox_simulated_dwi_1b0_7b1k.mat')
%% Parameters Settings
%%%% denoising para 
par.iter      =   6;
par.ps        =   [3 3];      % Sliding window size
par.step      =   2;          % Sliding step 
par.PatNum    =   60;        % Num of similar patches
par.SearchWin =   64;         % Radius of the searing region
par.lamada    =   0.6;        % Weighting applied to noise std for different iterations
par.delta     =   0.1;        % Parameter between each iter
par.constant  =   2*sqrt(2);  % Constant num for the weight vector
par.InnerLoop =   3;          % InnerLoop num for re-blockmatching 
par.RankMode  =   1;          % 1 - WNNM; 2 - Hard thresholding; 3 - Hard thresholding w/ automatic rank selection 
par.fastmode  =   0;          % 0 - no acceleration; 1 - gpu

%%%% image para
[par.Nx, par.Ny, par.Ndir] = size(im);

%%%% noise para
par.NoiseLevel = 2;
%% Add Noise
randn('seed',0);
nsig  = par.NoiseLevel*2.55; % simulated noise STD is based on the noise level of the ref imgs
% add rician noise
par.I = im*255;
par.nim = sqrt((par.I + nsig*randn(par.Nx,par.Ny,par.Ndir)).^2+(nsig*randn(par.Nx,par.Ny,par.Ndir)).^2); 

%% Denoising 
par.nSig0 = nsig;
[im_out] = WNNM_Denoising(par.nim, par); 


    
    


