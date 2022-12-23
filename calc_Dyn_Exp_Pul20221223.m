%20200828 统计意义上的脉冲信号

  load('PS26.mat'); PS=sortrows(PS,[1, 2,3]); %Simulatiom 
% load('PE26.mat'); PS=sortrows(PS,[1,21,2,3]);  %Experiment

PD = load('D:\fromWZJ2018\WZJ2018DeskF\cDownload\PokerAnan20200716\8x8abedata\PD26_20221222.csv');

T6=PS(find(PS(:,1)==6),:);
T8=PS(find(PS(:,1)==8),:);
T10=PS(find(PS(:,1)==10),:);

Le=length(T6(:,1))/12;  

% 6
Trr = T6;
Sig=[]; SampleSize=10;
for i=1:SampleSize:Le;  
%     a=T6(i:Le:Le*12,[4:11 13:20]); 
          a=[];
          for g=0:SampleSize-1  
              a=[a;Trr(i+g:Le:Le*12,[4:11 13:20])];
          end
    for j=1:16
        for k=1:16
            if (j-8.1)*(k-8.1)>0  && (sum(a(:,j)-a(:,k))) > 0 %X8, Y8 分别对比
                [h,p]=ttest(a(:,j),a(:,k),0.05);
                if h==1
                Sig=[Sig; j k i h p (sum(a(:,j)-a(:,k))) 6];
                end
            end
        end
    end 
end 


Si6_X = Sig(find((Sig(:,2)==2 | Sig(:,2)==6)&(Sig(:,1)~=2 & Sig(:,1)~=6 )) ,:)   
% r = [207,:]
Si6_Y = Sig(find((Sig(:,2)==2+8 | Sig(:,2)==4+8)&(Sig(:,1)~=2+8 & Sig(:,1)~=4+8 )) ,:)   
% r = []

% 8
Trr = T8;
Sig=[]; SampleSize=10;
for i=1:SampleSize:Le;  
%     a=Trr(i:Le:Le*12,[4:11 13:20]); 
              a=[];
          for g=0:SampleSize-1
              a=[a;Trr(i+g:Le:Le*12,[4:11 13:20])];
          end
    for j=1:16
        for k=1:16
            if (j-8.1)*(k-8.1)>0  && (sum(a(:,j)-a(:,k))) > 0 %X8, Y8 分别对比
                [h,p]=ttest(a(:,j),a(:,k));
                if h==1
                Sig=[Sig; j k i h p (sum(a(:,j)-a(:,k))) 8];
                end
            end  
        end
    end 
end 
 
Si8_X = Sig(find((Sig(:,2)==1)&(Sig(:,1)~=1)) ,:)   
% r = [186,:]    
Si8_Y = Sig(find((Sig(:,2)==4+8)&(Sig(:,1)~=4+8)) ,:)   
% r = []  

%% 10
Trr = T10;
Sig=[]; SampleSize=10;
for i=1:SampleSize:Le;  
%     a=T10(i:Le:Le*12,[4:11 13:20]); 
              a=[];
          for g=0:SampleSize-1
              a=[a;Trr(i+g:Le:Le*12,[4:11 13:20])];
          end
    for j=1:16
        for k=1:16
            if (j-8.1)*(k-8.1)>0  && (sum(a(:,j)-a(:,k))) > 0 %X8, Y8 分别对比
                [h,p]=ttest(a(:,j),a(:,k));
                if h==1
                Sig=[Sig; j k i h p (sum(a(:,j)-a(:,k))) 10];
                end
            end  
        end
    end 
end 
 

Si10_X = Sig(find((Sig(:,2)==1 | Sig(:,2)==2 | Sig(:,2)==5)&(Sig(:,1)~=1 & Sig(:,1)~=2 & Sig(:,1)~=5)) ,:)   
% r = [82,:]    
Si10_Y = Sig(find((Sig(:,2)==2+8 | Sig(:,2)==4+8)&(Sig(:,1)~=2+8 & Sig(:,1)~=4+8 )) ,:)   
% r = []  

ImpulseSignal_unique=[661;unique(Si6_X(:,1));662;unique(Si6_Y(:,1)); ...
               881;unique(Si8_X(:,1));882;unique(Si8_Y(:,1));...
               101;unique(Si10_X(:,1));102;;unique(Si10_Y(:,1))];

ImpulseSignal_all=[ (Si6_X ); (Si6_Y ); ...
                 (Si8_X);   (Si8_Y );...
                 (Si10_X );  (Si10_Y )];
pulsesignal = latex2MxWithMxPrecision(ImpulseSignal_all, 3)
save('ImpulseSignal_Stat_EXP')

% % 行标签	计数项:3
% % 4	118
% % 7	13
% % 8	75
% % (空白)	
% % 总计	206
% % 	
% % 	
% % 行标签	计数项:7
% % 3	3
% % 5	57
% % 6	47
% % 7	41
% % 8	37
% % 总计	185
% % 	
% % 	
% % 行标签	计数项:8
% % 4	90
% % 6	114
% % 7	11
% % 8	81
% % (空白)	
% % 总计	296


