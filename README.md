## Joint denoising of diffusion-weighted images via structured low-rank patch matrix approximation

# Suggested setup
The demo scripts were tested on Matlab R2021a (installed on Windows 10).
# Demo and sample data
One demo script is provided for denoising simulated brain DWIs.

Two sample datasets are available. Brain-like phantom created for ISMRM 2015 Tractography Challenge was used to generate brain DWI dataset with matrix size = 90 × 108 × 90, isotropic resolution = 2 mm, 1 b value = 0 image, and 30 diffusion directions with b value = 1000 and 2000 s/mm2. For evaluation, 2 datasets were synthesized by extracting 6 DWIs fromthe simulated dataset with b value = 1000 and 2000 s/mm2, respectively. The b value = 0 image was also included in each dataset to form 2 ground truth DWI datasets. Each dataset contained a total of 7 images.

# Reference
Zhao, Yujiao, et al. "Joint denoising of diffusion-weighted images via structured low-rank patch matrix approximation." Magnetic Resonance in Medicine (2022). https://doi.org/10.1002/mrm.29407

