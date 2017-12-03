
addpath /projects/schiz/pi/lipeng/matlab/routines/toolbox_matlab_nifti/
caselist='/rfanfs/pnl-zorro/projects/ADHD/rsFMRI/scripts/caseList_53.txt';
CaseName=textread(caselist,'%s');
N=length(CaseName);
brainarea{1}=[1028 1027 1032 1020 1019 1018 1014 1003 1012 1024 1017 1002 1026 3028 3027 3032 3020 3019 3018 3014 3003 3012 3024 3017 3002 3026];%leftfrontal
brainarea{2}=[2028 2027 2032 2020 2019 2018 2014 2003 2012 2024 2017 2002 2026 4028 4027 4032 4020 4019 4018 4014 4003 4012 4024 4017 4002 4026];%rightfrontal
brainarea{3}=[3009 3015 3030 3033 3034 3007 3006 3016 1009 1015 1030 1033 1034 1007 1006 1016];%leftTemporal
brainarea{4}=[2009 2015 2030 2033 2034 2007 2006 2016 4009 4015 4030 4033 4034 4007 4006 4016];%rightTemporal
brainarea{5}=[3008 3029 3031 3025 3022 3023 3010 1008 1029 1031 1025 1022 1023 1010];%leftParietal
brainarea{6}=[2008 2029 2031 2025 2022 2023 2010 4008 4029 4031 4025 4022 4023 4010];%rightParietal
brainarea{7}=[3011 3013 3005 3021 1011 1013 1005 1021];%leftOccipital
brainarea{8}=[2011 2013 2005 2021 4011 4013 4005 4021];%rightOccipital
Nb=numel(brainarea);
meanDelay=zeros(N,Nb);

for i =1:N
delay_map=(['/rfanfs/pnl-zorro/projects/ADHD/' CaseName{i} '/fMRI/Delay_Map.nii.gz']);
Data=MRIread(delay_map);
fs_atlas=(['/rfanfs/pnl-zorro/projects/ADHD/freesurferInFMRISpace/' CaseName{i} '/wmparc-in-bse_unu.nii.gz']);
atlas=MRIread(fs_atlas);

    for j =1:Nb
        id=[];
        label=brainarea{j};
        
        for jj=1:numel(label)
            id = [id; find(atlas.vol == label(jj))];
        end
        
        delay=Data.vol(id);
        meanDelay(i,j)=mean(delay);
    end

end

header={'leftfrontal','rightfrontal','leftTemporal','rightTemporal','leftParietal','rightParietal','leftOccipital','rightOccipital'};
ds=dataset({meanDelay, header{:}});
export(ds, 'file', 'MeanDelay.xls');
