tic
for i=1:length(plusP)
    I=plusIndex(i,1);
    %Pvalue=plusP(i,I);
    if (plusP(i,I) >0.05);
       plusIndex(i,1)=0;
    else
        disp('pvalue less than 0.05');
    end
end

for i=1:length(minusP)
    I=minusIndex(i,1);
    %Pvalue=plusP(i,I);
    if (minusP(i,I) >0.05);
       minusIndex(i,1)=0;
    else
       disp('pvalue less than 0.05');
    end
end
toc

