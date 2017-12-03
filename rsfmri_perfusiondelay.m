clear
%caselist='/rfanfs/pnl-zorro/projects/ADHD/rsFMRI/scripts/CaseList.txt';
%CaseName=textread(caselist,'%s');
CaseName={'case235'}
N=length(CaseName);

originaldir=pwd;

for text=1:N

fMRIImage=(['/rfanfs/pnl-zorro/projects/ADHD/' CaseName{text} '/fMRI/ffBPS_motRes_ss_st_dv_fMRI_1-cleaned.nii']);
maskname=(['/rfanfs/pnl-zorro/projects/ADHD/' CaseName{text} '/fMRI/fMRI_1-bet_mask.nii.gz']);

%% load the data

addpath /rfanfs/pnl-zorro/software/
addpath /projects/schiz/pi/lipeng/matlab/routines/toolbox_matlab_nifti/
cd /rfanfs/pnl-zorro/projects/ADHD/
e=MRIread(fMRIImage);
mask=MRIread(maskname);
[nx,ny,nz]=size(mask.vol);

%% 

maxstore=zeros(nz,1);
for ii =1:nz
    pop=(mask.vol(:, :,ii));
    maxstore(ii,:)=max(pop(:));
end

%% find only slices that have brain to get 10 reference slices 

nonone=find(maxstore~=0);
nlength=length(nonone);
value=round(nlength/2);
refmax=value+5;
refmin=value-4;
startV=min(nonone);
endV=max(nonone);

%% get the reference values

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

%% Get the data reshaped in 2D format from 4D format

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

%% Perform correlation of every voxel in the brain with the reference data

func=func';
reference_mean=reference_mean';
tic

plusP=zeros(length(func), 5);
plusR=zeros(length(func), 5);
for q=2:6
    r=q-1;
    rst1=func(q:end, :);
    rm1=reference_mean(1:end-r, :);
        for i=1:length(rst1)
            data1=[rst1(:,i),rm1];
            [r1,p1]=corrcoef(data1);
            r=q-1;
            plusR(i,r)=r1(1,2);
            plusP(i,r)=p1(1,2);
            
        end

end
toc

tic
minusR=zeros(length(func), 5);
minusP=zeros(length(func), 5);
for q=2:6
        r=q-1;
        rst1=func(1:end-r, :);
        rm1=reference_mean(q:end, :);
        for i=1:length(rst1)
            data1=[rst1(:,i),rm1];
            [r1,p1]=corrcoef(data1);
            r=q-1;
            minusR(i,r)=r1(1,2);
            minusP(i,r)=p1(1,2);
        end

end
toc
%% 

minusRR=fliplr(minusR);
minusPP=fliplr(minusP);

DataR=[minusRR, plusR];
DataP=[minusPP, plusP];
% find the highest magnitude. 


%% Get the higest R^2 and check whether it is less that 0.05 


DataRsq=DataR.^2;
[row col]=size(DataRsq);
datadat=zeros(row,1);
dataIndex=zeros(row,1);
tic
for i=1:length(DataRsq)
   [M, I]=max(DataRsq(i,:));
   datadat(i,1)=M;
   dataIndex(i,1)=I;
   
end
toc

tic
for i=1:length(DataP)
    I=dataIndex(i,1);
    %Pvalue=plusP(i,I);
    if (DataP(i,I) >0.05);
       dataIndex(i,1)=0;
    else
       disp('pvalue less than 0.05');
    end
end
toc
%% correcting the values to be between 

tic
dataIndex(dataIndex==1)=-5;
dataIndex(dataIndex==2)=-4;
dataIndex(dataIndex==3)=-3;
dataIndex(dataIndex==4)=-2;
dataIndex(dataIndex==5)=-1;
dataIndex(dataIndex==6)=1;
dataIndex(dataIndex==7)=2;
dataIndex(dataIndex==8)=3;
dataIndex(dataIndex==9)=4;
dataIndex(dataIndex==10)=5;
toc



%% converting the values back in to the 3D (brain) space


tic
lop=reshape(ze,nx*ny*tal,1);
Brain=lop;
brainvoxels=find(ze==1);
maskvoxels=find(ze==0);

   for k=1:length(brainvoxels)
       index=brainvoxels(k,1);       
       Brain(index,1)=dataIndex(k,1);
   end
toc
     
finalbrain=reshape(Brain, nx, ny, tal);
mask.vol(mask.vol~=0)=0;
for oi=1:tal
    indexL=ta(:,oi);
    hop=finalbrain(:,:,oi);
    mask.vol(:,:,indexL)=hop;
end
%% writing mapfile

MRIwrite(mask,(['/rfanfs/pnl-zorro/projects/ADHD/' CaseName{text} '/fMRI/Delay_Map.nii.gz']));
end


