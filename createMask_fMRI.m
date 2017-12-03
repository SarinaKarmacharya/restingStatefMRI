%casename=textread('/rfanfs/pnl-zorro/projects/ADHD/CaseList.txt', '%s');
casename={'case101', 'case103', 'case137'};
N=numel(casename);

for i =1:N
    
    fmri=(['/rfanfs/pnl-zorro/projects/ADHD/' casename{i} '/fMRI/fMRI_1.nii']);
    fmri_bet=(['/rfanfs/pnl-zorro/projects/ADHD/' casename{i} '/fMRI/fMRI_1-bet.nii.gz']);
    fmri_nrrd=(['/rfanfs/pnl-zorro/projects/ADHD/' casename{i} '/fMRI/fMRI_1.nrrd']);
    fmri_mask=(['/rfanfs/pnl-zorro/projects/ADHD/' casename{i} '/fMRI/fMRI_1-bet_mask.nrrd']);
    fmri_cleaned_nrrd=(['/rfanfs/pnl-zorro/projects/ADHD/' casename{i} '/fMRI/fMRI_1-cleaned.nrrd']);
    
    if exist(fmri)
        system(['bet ' fmri ' ' fmri_bet ' -f 0.3 -m -R']);
        newname=strrep(fmri_bet, 'nii.gz', 'nii')
        system(['ConvertBetweenFileFormats ' fmri_bet ' '  newname]);
        system(['rm ' fmri_bet]);
        newmask=strrep(fmri_mask,'nrrd', 'nii.gz');
        system(['ConvertBetweenFileFormats ' newmask ' ' fmri_mask]);
        system(['ConvertBetweenFileFormats ' fmri ' ' fmri_nrrd]);
        system(['unu 2op x ' fmri_nrrd ' ' fmri_mask ' -o ' fmri_cleaned_nrrd]);
        fmri_cleaned_final=strrep(fmri_cleaned_nrrd, 'nrrd', 'nii')
        system(['ConvertBetweenFileFormats ' fmri_cleaned_nrrd ' ' fmri_cleaned_final]);
        
    else
        disp('file does not exist')
    end
end
