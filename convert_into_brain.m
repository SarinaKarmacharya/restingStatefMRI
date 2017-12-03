tic
lop=reshape(ze,72*72*tal,1);
Brain=lop;
brainvoxels=find(ze==1);
maskvoxels=find(ze==0);

   for k=1:length(brainvoxels)
       index=brainvoxels(k,1);       
       Brain(index,1)=dataIndex(k,1);
   end
toc
     
finalbrain=reshape(Brain, 72, 72, tal);
mask.vol(mask.vol~=0)=0;
for oi=1:tal
    indexL=ta(:,oi);
    hop=finalbrain(:,:,oi);
    mask.vol(:,:,indexL)=hop;
end
%% 

MRIwrite(mask,'/rfanfs/pnl-zorro/projects/ADHD/case204/fMRI/MAP.nii.gz');