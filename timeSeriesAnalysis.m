addpath /rfanfs/pnl-zorro/software/
addpath /projects/schiz/pi/lipeng/matlab/routines/toolbox_matlab_nifti/
cd /rfanfs/pnl-zorro/projects/ADHD/
originaldir=pwd;

fMRIImage='/rfanfs/pnl-zorro/projects/ADHD/case204/fMRI/ffBPS_motRes_ss_st_dv_fMRI_1-cleaned.nii';
maskname='/rfanfs/pnl-zorro/projects/ADHD/case204/fMRI/fMRI_1-bet_mask.nii.gz';
%% 

e=MRIread(fMRIImage);
mask=MRIread(maskname);
[nx, ny, nz, nt]=size(e.vol);
l=[refmin:refmax];
n=numel(l);
k=zeros([nx ny n nt]);

for i =1:length(l)
    jkindex=l(:,i);
    k(:,:,i,:)=e.vol(:,:,jkindex,:);
end

referenceData= reshape(k, [nx*ny*n,nt]); 

j=zeros([nx, ny, n]);

for ii =1:length(l)
    jhindex=l(:,ii);
    j(:,:,ii)=mask.vol(:, :,jhindex);
end

referenceData=referenceData(j~=0, :);
%% 

ta=[1:endV];
tal=length(ta);
at=zeros([nx, ny, tal, nt]);

for jj=1:tal
    hindex=ta(:,jj);
    at(:,:,jj,:)=e.vol(:,:,hindex,:);
end
func=reshape(at, [nx*ny*tal, nt]);

ze=zeros([nx, ny, tal]);

for jjj=1:tal
    yindex=ta(:,jjj);
    ze(:,:,jjj)=mask.vol(:,:,yindex);
end
%% 

func=func(ze~=0,:);
reference_mean=mean(referenceData, 1);



