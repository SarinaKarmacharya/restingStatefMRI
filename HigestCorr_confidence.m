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
%% 
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
