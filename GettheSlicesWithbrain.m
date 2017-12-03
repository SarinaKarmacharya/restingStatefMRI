
addpath /rfanfs/pnl-zorro/software/
addpath /projects/schiz/pi/lipeng/matlab/routines/toolbox_matlab_nifti/
cd /rfanfs/pnl-zorro/projects/ADHD/
originaldir=pwd;


fMRIImage='/rfanfs/pnl-zorro/projects/ADHD/case204/fMRI/ffBPS_motRes_ss_st_dv_fMRI_1-cleaned.nii';
maskname='/rfanfs/pnl-zorro/projects/ADHD/case204/fMRI/fMRI_1-bet_mask.nii.gz';

e=MRIread(fMRIImage);
mask=MRIread(maskname);
[nx,ny,nz]=size(mask.vol);
%% 


maxstore=zeros(nz,1);
for ii =1:nz
    pop=(mask.vol(:, :,ii));
    maxstore(ii,:)=max(pop(:));
end
%% 

nonone=find(maxstore~=0);
nlength=length(nonone);
value=round(nlength/2);
refmax=value+5;
refmin=value-4;
startV=min(nonone);
endV=max(nonone);
