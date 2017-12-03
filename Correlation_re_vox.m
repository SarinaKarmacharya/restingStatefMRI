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









