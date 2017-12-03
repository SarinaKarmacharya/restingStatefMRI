
addpath /rfanfs/pnl-zorro/projects/ADHD/ADHD_PreProcess/

caselist='/rfanfs/pnl-zorro/projects/ADHD/rsFMRI/scripts/rsfMRI_caselist.txt';
files=textread(caselist,'%s');



N = numel(files);


for i=1:N %%%%%%%%%%CHANGE THE NUM TO N HERE 
datapath='/rfanfs/pnl-zorro/projects/ADHD/';
%Example: 0_2014-08-22-11-32-26
%%%%%%%% 1

pattern = '[0-9]_([0-9]+-)+[0-9]+';
folder_list = FindFolderFromRegex(fullfile(datapath, files{i}), pattern);
caseDir.date_folder = cell2mat(folder_list);

if (length(folder_list) < 1)
    
    pattern = '[0-9]+-[0-9]+';
    
    folder_list = FindFolderFromRegex(fullfile(datapath, files{i}, caseDir.date_folder), pattern);
    caseDir.patient_number = cell2mat(folder_list);
    
    pattern = '([0-9]+.)+[0-9]+-[0-9]+Y-[a-zA-Z_0-9]+-[0-9]+';
    
    folder_list = FindFolderFromRegex(fullfile(datapath, files{i}, caseDir.date_folder, caseDir.patient_number), pattern);
    
    % STep 4
    caseDir.main_folder = cell2mat(folder_list);
    
    pattern = 'MoCo.*-.*fMRI.*-[0-9]+';
    
    folder_list = FindFolderFromRegex(fullfile(datapath, files{i}, caseDir.date_folder, caseDir.patient_number, caseDir.main_folder), pattern);
    
    
    if (length(folder_list) < 1)
        pattern = '.*-.*fMRI.*-[0-9]+';
        folder_list = FindFolderFromRegex(fullfile(datapath, files{i}, caseDir.date_folder, caseDir.patient_number, caseDir.main_folder), pattern);
    end
    
else
    pattern = '[0-9]+-[0-9]+';
    
    folder_list = FindFolderFromRegex(fullfile(datapath, files{i}, caseDir.date_folder), pattern);
    
    caseDir.patient_number = cell2mat(folder_list);
    
    % STEP 3 => the main folder
   
    pattern = '([0-9]+.)+[0-9]+-[0-9]+Y-[a-zA-Z_0-9]+-[0-9]+';
    
    folder_list = FindFolderFromRegex(fullfile(datapath, files{i}, caseDir.date_folder, caseDir.patient_number), pattern);
    
    % STep 4
    caseDir.main_folder = cell2mat(folder_list);
    
    pattern = 'MoCo.*-.*fMRI.*-[0-9]+';
    
    folder_list = FindFolderFromRegex(fullfile(datapath, files{i}, caseDir.date_folder, caseDir.patient_number, caseDir.main_folder), pattern);
    
    if (length(folder_list) < 1)
        pattern = '.*-.*fMRI.*-[0-9]+';
        folder_list = FindFolderFromRegex(fullfile(datapath, files{i}, caseDir.date_folder, caseDir.patient_number, caseDir.main_folder), pattern);
    end
end
namewq=char(files{i});
disp(namewq);  
%disp(folder_list);

end
