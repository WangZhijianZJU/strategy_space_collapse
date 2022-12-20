% C:\Users\think\Documents\MATLAB\plot_Dyn_Exp_Acc20221220.m
function r = plot_Dyn_Exp_Acc20221220()
    close all 
    clear 
                                      p=[6 8 10]; 
 %% ----------------------------------------------------------------------------------------------------------------%%   
% % % % % % % % % % % % % % % % % % % % % % % %     ofilehead = 'exp';
% % % % % % % % % % % % % % % % % % % % % % % %     load('eicycle.mat')  % experimental result  
% % % % % % % % % % % % % % % % % % % % % % % %    
% % % % % % % % % % % % % % % % % % % % % % % %     Acc_3page=[]
% % % % % % % % % % % % % % % % % % % % % % % %     for k=1:3
% % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % %         n8x8list_4 = n8x8list_3(n8x8list_3(:,9)==p(k),:);
% % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % %         n8x8list_4=sortrows(n8x8list_4, [3 9 1 5 4]);
% % % % % % % % % % % % % % % % % % % % % % % %         r0=[];
% % % % % % % % % % % % % % % % % % % % % % % %             for t=1:1000
% % % % % % % % % % % % % % % % % % % % % % % %                 r1 = n8x8list_4(n8x8list_4(:,3)==t,:);
% % % % % % % % % % % % % % % % % % % % % % % %                 r0=[r0; sum(r1(:,11:26))];
% % % % % % % % % % % % % % % % % % % % % % % %                     if t==1; 
% % % % % % % % % % % % % % % % % % % % % % % %                         Acc_3page(t,:,k) = r0;
% % % % % % % % % % % % % % % % % % % % % % % %                     else 
% % % % % % % % % % % % % % % % % % % % % % % %                         Acc_3page(t,:,k) = sum(r0);
% % % % % % % % % % % % % % % % % % % % % % % %                     end
% % % % % % % % % % % % % % % % % % % % % % % %             end
 %% ----------------------------------------------------------------------------------------------------------------%% 
    ofilehead = 'dyn';
    load('J_dyn_202212.mat','R36000x35Logit', 'eicyclelogit','Acc_3page_logit')            
            Acc_3page = Acc_3page_logit;
    for k=1:3
 %% ----------------------------------------------------------------------------------------------------------------%% 
         figure; 
%          subplot(1,3,1); plot(Acc_3page(:,:,k)); 
%          subplot(1,2,1); 
         plot(Acc_3page(:,1:8,k),'linewidth',4); xlim([0,200]);ylim([0 1000]);axis square; %title(strcat('dyn-X',num2str(p(k))))
%            legend('X_1', 'X_2', 'X_3', 'X_4', 'X_5', 'X_6', 'X_7', 'X_8','location','eastoutside') 
           legend('1', '2', '3', '4', '5', '6', '7', '8','location','northwest','numcolumns',2) 
              set(gcf,'papersize',[12 12],'paperposition',[0,0,12,12]);hold on; 
           set(gca,'looseInset',[0 0 0 0],'fontsize',16,'linewidth',2) ;box on;
           saveas(gcf,strcat(ofilehead,'__accX200_', num2str(k), '.png'))
         figure; 
%          subplot(1,2,2); 
         plot(Acc_3page(:,9:16,k),'linewidth',4);xlim([0,200]);ylim([0 1000]);axis square; %title(strcat('dyn-Y',num2str(p(k))))
%            legend('Y_1', 'Y_2', 'Y_3', 'Y_4', 'Y_5', 'Y_6', 'Y_7', 'Y_8','location','northwest','numcolumns',2) 
           legend('1', '2', '3', '4', '5', '6', '7', '8','location','northwest','numcolumns',2) 
              set(gcf,'papersize',[12 12],'paperposition',[0,0,12,12]);hold on; 
           set(gca,'looseInset',[0 0 0 0],'fontsize',16,'linewidth',2) ;box on;
           saveas(gcf,strcat(ofilehead, '__accY200_', num2str(k), '.png'))
    end
         save('acc.mat','Acc_3page');
         r = 'acc.mat --- Acc_3page'; 
end
