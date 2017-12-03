addpath /projects/schiz/pi/lipeng/matlab/routines/toolbox_matlab_nifti/
caselist='/rfanfs/pnl-zorro/projects/ADHD/rsFMRI/scripts/CaseList.txt';
CaseName=textread(caselist,'%s');
N=length(CaseName);

originaldir=pwd;

for text=1:N
% rfMRI volume 1
   bse=(['/rfanfs/pnl-zorro/projects/ADHD/' CaseName{text} '/fMRI/']);
   rsfMRIImage=(['/rfanfs/pnl-zorro/projects/ADHD/' CaseName{text} '/fMRI/ffBPS_motRes_ss_st_dv_fMRI_1-cleaned.nii']);
   rfMRI_folder=['/rfanfs/pnl-zorro/projects/ADHD/' CaseName{text} '/fMRI/split/'];
   system(['mkdir ' rfMRI_folder]);
   tmp=([bse,'tmp'])
   rfMRI_vol1=['/rfanfs/pnl-zorro/projects/ADHD/' CaseName{text} '/fMRI/split/fsfmri'];
   system(['fslsplit '  rsfMRIImage ' ' rfMRI_vol1 ' -t']);
   rfMRI_VOl=['/rfanfs/pnl-zorro/projects/ADHD/' CaseName{text} '/fMRI/split/fsfmri0000.nii.gz'];
   system(['mv ' rfMRI_VOL ' ' bse]); 
   system(['rm -r ' rfMRI_folder]);
   %% 
   
   rsfMRI_final_VOL=['/rfanfs/pnl-zorro/projects/ADHD/' CaseName{text} '/fMRI/fsfmri0000.nii.gz']);
   T1_volume_mgz=['/rfanfs/pnl-zorro/projects/ADHD/freesurfer-analyses/subjects/' CaseName{text} '/mri/T1.mgz']);
   T1_volume_nii=strrep(T1_volume_mgz,'mgz','nii.gz');
   system(['ConvertBetweenFileFormats ' T1_volume_mgz ' ' T1_volume_nii']);
   ANTS_prefix=([tmp 'ANTS'])
   
   
   system(['/projects/schiz/software/ANTS-git-build/bin/ANTS 3 -m MI[' rsfMRI_final_vol ' , ' T1_volume_nii ' , 1, 5] -i 20x20x10 -r Gauss[3,0] -t SyN[1] -o ' ANTS_prefix]);% 
   
   % 