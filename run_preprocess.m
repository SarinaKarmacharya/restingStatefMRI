
addpath /rfanfs/pnl-zorro/projects/ADHD/rsFMRI/scripts/spm12
addpath /rfanfs/pnl-zorro/projects/ADHD/rsFMRI/scripts/fcMRI_scripts
addpath /rfanfs/pnl-zorro/projects/ADHD/rsFMRI/scripts/Utilities
%casename=textread('/rfanfs/pnl-zorro/projects/ADHD/rsFMRI/scripts/55_slices.txt','%s')
casename={'case123'};
N=numel(casename);

for i=1:N
    originalDir=pwd
    path=(['/rfanfs/pnl-zorro/projects/ADHD/' casename{i} '/fMRI/'])
    
    name=casename{i}
    cd (name);cd 'fMRI'
    fcPreproc('fMRI_1-cleaned.nii', 'fcParams')
    cd (originalDir)
end

