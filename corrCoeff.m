

func=func';
reference_mean=reference_mean';
R=zeros(length(func),1);

for i=1:length(func)
    %tbl=table( func(:,1),reference_mean,'VariableNames', {'signal','reference'});
    data=[func(:,i), reference_mean];
    r=corrcoef(data);
    R(i,1)=r(1,2);

end

%removing the first time series
%% 

 rst1=func(2:end, :);
 rm1=reference_mean(1:end-1, :);
 R1=zeros(length(rst1), 1);
 P1=zeros(length(rst1), 1);
 for i=1:length(rst1)
     data1=[rst1(:,i),rm1];
     [r1,p1]=corrcoef(data1);
     R1(i,1)=r1(1,2);
     P1(i,1)=p1(1,2);  
 end
 
% removing the second time series

 rst2=func(3:end, :);
 rm2=reference_mean(1:end-2, :);
 R2=zeros(length(rst2), 1);
 P2=zeros(length(rst1), 1);
 for i=1:length(rst2)
     data1=[rst2(:,i),rm2];
     [r2,p2]=corrcoef(data1);
     R2(i,1)=r2(1,2);
     P2(i,1)=p2(1,2);
 end
 
% removing the third time series

 rst3=func(4:end, :);
 rm3=reference_mean(1:end-3, :);
 R3=zeros(length(rst3), 1);
 P3=zeros(length(rst1), 1);
 
  for i=1:length(rst3)
     data1=[rst3(:,i),rm3];
     [r3,p3]=corrcoef(data1);
     R3(i,1)=r3(1,2);
     P3(i,1)=p3(1,2);
 end
 
%removing the forth time series

rst4=func(5:end, :);
rm4=reference_mean(1:end-4, :);
R4=zeros(length(rst4), 1);
P4=zeros(length(rst1), 1);

 for i=1:length(rst4)
     data1=[rst4(:,i),rm4];
     [r4,p4]=corrcoef(data1);
     R4(i,1)=r4(1,2);
     P4(i,1)=p4(1,2);
 end
 
%removing the fifth time series

rst5=func(6:end, :);
rm5=reference_mean(1:end-5,:);
R5=zeros(length(rst5), 1);
P5=zeros(length(rst5), 1);

for i=1:length(rst5)
     data1=[rst5(:,i),rm5];
     [r5,p5]=corrcoef(data1);
     R5(i,1)=r5(1,2);
     P5(i,1)=p5(1,2);
end
 

%%%%%%	NOW INVERSING +5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
tic
 mrst1=func(1:end-1, :);
 mrm1=reference_mean(2:end, :);
 mR1=zeros(length(mrst1), 1);
 mP1=zeros(length(mrst1), 1);
 for i=1:length(mrst1)
     data1=[rst1(:,i),mrm1];
     [r1,p1]=corrcoef(data1);
     mR1(i,1)=r1(1,2);
     mP1(i,1)=p1(1,2);  
 end
 
% removing the second time series

 mrst2=func(1:end-2, :);
 mrm2=reference_mean(3:end, :);
 mR2=zeros(length(mrst2), 1);
 mP2=zeros(length(mrst1), 1);
 for i=1:length(mrst2)
     data1=[rst2(:,i),mrm2];
     [r2,p2]=corrcoef(data1);
     mR2(i,1)=r2(1,2);
     mP2(i,1)=p2(1,2);
 end
 
% removing the third time series

 mrst3=func(1:end-3, :);
 mrm3=reference_mean(4:end, :);
 mR3=zeros(length(mrst3), 1);
 mP3=zeros(length(mrst1), 1);
 
  for i=1:length(mrst3)
     data1=[rst3(:,i),mrm3];
     [r3,p3]=corrcoef(data1);
     mR3(i,1)=r3(1,2);
     mP3(i,1)=p3(1,2);
 end
 
%removing the forth time series

mrst4=func(1:end-4, :);
mrm4=reference_mean(5:end, :);
mR4=zeros(length(mrst4), 1);
mP4=zeros(length(mrst1), 1);

 for i=1:length(mrst4)
     data1=[mrst4(:,i),mrm4];
     [r4,p4]=corrcoef(data1);
     mR4(i,1)=r4(1,2);
     mP4(i,1)=p4(1,2);
 end
 
%removing the fifth time series

mrst5=func(1:end-5, :);
mrm5=reference_mean(6:end,:);
mR5=zeros(length(mrst5), 1);
mP5=zeros(length(mrst5), 1);

for i=1:length(mrst5)
     data1=[mrst5(:,i),mrm5];
     [r5,p5]=corrcoef(data1);
     mR5(i,1)=r5(1,2);
     mP5(i,1)=p5(1,2);
end
 toc

