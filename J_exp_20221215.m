function [n8x8list,stateList,RPara] = Get8x8Data20221214(Para)
% n8x8list = load('C:\Users\Think\Downloads\n8x8.csv');
% n8x8list_0 = load('C:\Users\a\Desktop\J8x8\Experiment\n8x8.csv');  % lixia

addpath 'D:\fromWZJ2018\WZJ2018DeskF\tmpdata\control\Z4C'  %Yret3= from_N_colExp_out_am(dos_1,mean(dos_1));
n8x8list_0 = load('C:\Users\think\Desktop\tmp2\space-collapse-master\NY8x8\input\n8x8.csv');


n8x8list_0(:,1) = n8x8list_0(:,1) * 100 - 8000000;

n8x8list_2=n8x8list_0(find(n8x8list_0(:,5) == 1),:);

n8x8list_3=sortrows(n8x8list_2, [9 1 5 4 3]);
n8x8list_3(:,11:26)=0;
n8x8list_3(:,10) = n8x8list_3(:,6)*10 + n8x8list_3(:,7);
 
    for k=1:36000 %11-26 is the 16dim 
        n8x8list_3(k,10+ n8x8list_3(k,6)) = 1;
        n8x8list_3(k,18+ n8x8list_3(k,7)) = 1;
    end
 
    [Yret_3col_1, Yret_3col_2, Yret_12x3col_1, Yret_12x3col_2]= ...
                fun4yret3(n8x8list_3);
            
    save('eicycle.mat')
            r1 = plot_eicycle20221215()        
            r2 = plot_Acc20221215()
 end

function r = plot_Acc20221215()
 
    clear 
    load('eicycle.mat')
    p=[6 8 10];
    Acc_3page=[]
    for k=1:3

        n8x8list_4 = n8x8list_3(n8x8list_3(:,9)==p(k),:);

        n8x8list_4=sortrows(n8x8list_4, [3 9 1 5 4]);
        r0=[];
            for t=1:1000
                r1 = n8x8list_4(n8x8list_4(:,3)==t,:);
                r0=[r0; sum(r1(:,11:26))];
                    if t==1; 
                        Acc_3page(t,:,k) = r0;
                    else 
                        Acc_3page(t,:,k) = sum(r0);
                    end
            end
         figure; 
    %      subplot(1,3,1); plot(Acc_3page(:,:,k)); 
         subplot(1,2,1); plot(Acc_3page(:,1:8,k),'linewidth',2); xlim([0,400]);ylim([0 2000]);axis square; title(strcat('exp-X',num2str(p(k))))
         subplot(1,2,2); plot(Acc_3page(:,9:16,k),'linewidth',2);xlim([0,400]);ylim([0 2000]);axis square; title(strcat('exp-Y',num2str(p(k))))
    end
         save('acc.mat','Acc_3page');
         r = 'acc.mat --- Acc_3page'; 
end


function r1 = plot_eicycle20221215()

    clear 
    load('eicycle.mat')
    
figure;title('eicycle by treatment');hold on
    subplot(1,2,1); title('eicycle trt 1-1000');hold on
            plot(Yret_3col_1,'DisplayName','yret_12x3col_2(:,1:12)') ;xlim([0,120]);axis square;
    subplot(1,2,2); title('eicycle trt 501-1000');hold on
            plot(Yret_3col_2,'DisplayName','yret_12x3col_2(:,1:12)') ;xlim([0,120]);axis square;
figure; 
    subplot(1,3,1);    plot(Yret_12x3col_1(:,1:12),'linewidth',2) ;xlim([0,120]);axis square;title('eicycle ses 1-1000');hold on; ylim([-150 150])
    subplot(1,3,2);    plot(Yret_12x3col_1(:,13:24),'linewidth',2) ;xlim([0,120]);axis square;title('eicycle ses 1-1000');hold on;ylim([-150 150])
    subplot(1,3,3);    plot(Yret_12x3col_1(:,25:end),'linewidth',2);xlim([0,120]);axis square;title('eicycle ses 1-1000');hold on;ylim([-150 150])

figure; title('eicycle by sessions 501-1000');hold on
    subplot(1,3,1);    plot(Yret_12x3col_2(:,1:12),'linewidth',2) ;xlim([0,120]);axis square;;title('eicycle ses 501-1000');hold on;ylim([-150 150])
    subplot(1,3,2);    plot(Yret_12x3col_2(:,13:24),'linewidth',2);xlim([0,120]);axis square;;title('eicycle ses 501-1000');hold on;ylim([-150 150])
    subplot(1,3,3);    plot(Yret_12x3col_2(:,25:end),'linewidth',2);xlim([0,120]);axis square;;title('eicycle ses 501-1000');hold on;ylim([-150 150])
    
    r1 = 'eicycle by sessions 1-1000  ----- 501-1000' ;
end 


function [yret_3col_1, yret_3col_2, yret_12x3col_1, yret_12x3col_2]=fun4yret3(nlist)
    nlist=sortrows(nlist, [9 1 5 4 3]);
    yret_3col_1 = []; yret_12x3col_1=[];
    for k=1:12000:36000
        dos_1=nlist(k:k+11999,11:26);
        Yret3= from_N_colExp_out_am(dos_1,mean(dos_1));
        yret_3col_1=[yret_3col_1 Yret3];
            for m = 1:12
                dos_2=dos_1((m-1)*1000+1:m*1000,:);
                Yret3= from_N_colExp_out_am(dos_2,mean(dos_2));
                yret_12x3col_1 = [yret_12x3col_1 Yret3];
            end
    end

    nlist=nlist(find(nlist(:,3)>500),:);
    nlist=sortrows(nlist, [9 1 5 4 3]);
    yret_3col_2 = []; yret_12x3col_2=[];
    for k=1:12000/2:36000/2
        dos_1=nlist(k:k+12000/2-1,11:26);
        Yret3= from_N_colExp_out_am(dos_1,mean(dos_1));
        yret_3col_2=[yret_3col_2 Yret3];
            for m = 1:12
                dos_2=dos_1((m-1)*500+1:m*500,:);
                Yret3= from_N_colExp_out_am(dos_2,mean(dos_2));
                yret_12x3col_2 = [yret_12x3col_2 Yret3];
            end
    end

end