PlusRsq=plusR.^2;
MinusRsq=minusR.^2;

[row col]=size(PlusRsq);

plusdat=zeros(row,1);
plusIndex=zeros(row,1);
minusdat=zeros(row,1);
minusIndex=zeros(row,1);

tic
for i=1:length(plusdat)
   [M, I]=max(PlusRsq(i,:));
   plusdat(i,1)=M;
   plusIndex(i,1)=I;
   
end

for i=1:length(plusdat)
    [M, I]=max(MinusRsq(i,:));
    minusdar(i,1)=M;
    minusIndex(i,1)=I;
end
toc




