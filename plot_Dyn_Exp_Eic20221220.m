% C:\Users\think\Desktop\tmp2\space-collapse-master\code\plot_Dyn_Exp_Eic20221220.m
function r = plot_Dyn_Exp_Eic20221220()
% close all
clear 

 %% ----------------------------------------------------------------------------------------------------------------%%   
ofilehead = 'dyn';
        load('J_dyn_202212.mat', 'eicyclelogit')
        eicycle_Dyn_Exp= eicyclelogit;
 %% ----------------------------------------------------------------------------------------------------------------%%  
% % % % % % % % % % ofilehead = 'exp';
% % % % % % % % % %         load('eicycle.mat')
% % % % % % % % % %         eicycle_Dyn_Exp= [Yret_12x3col_2(1:120,1:12); Yret_12x3col_2(1:120,[1:12]+12); Yret_12x3col_2(1:120,[1:12]+24)];  
 %% ----------------------------------------------------------------------------------------------------------------%%        
        Trt_ses(:,:,1) = eicycle_Dyn_Exp(1:120,1:12); 
        Trt_ses(:,:,2) = eicycle_Dyn_Exp(1+120:120+120,1:12);
        Trt_ses(:,:,3) = eicycle_Dyn_Exp(1+240:120+240,1:12); 
            for k=1:3; mas(k) = max(max(abs(Trt_ses(:,:,k))));end 
            x=max(mas)
            for k=1:3; Trt_ses(:,:,k) = Trt_ses(:,:,k)./x;end
            
            leg ={'(2,1)', '(2,3)', '(2,4)'}
            cols =[ 0.00,0.45,0.74
                    0.47,0.67,0.19
                    1.00,0.41,0.16]

%%% logit dyn sess
for k=1:3
    figure; 
        plot(Trt_ses(:,:,k),'linewidth',1.5);ylim([-1 1]*1.2)
%             set(gca,'looseInset',[0 0 0 0],'fontsize',12) 
%             set(gcf,'position',[2548,83,680,145])
%                 if k<3; set(gca,'xtick','');end
%             legend(leg(k))
                set(gca,'looseInset',[0 0 0 0],'fontsize',12,'linewidth',2) ;box on;grid on;
                set(gcf,'position',[200+k*10,200+k*20,680,195])
%                 hl=legend(leg(k));set(hl,'box','off');
            saveas(gcf,strcat(ofilehead, '_eic_ses_', num2str(k), '.png'))
end


  
        Y(:,1) = sum(Trt_ses(:,:,1)')'*1.000;
        Y(:,2) = sum(Trt_ses(:,:,2)')'*1.000;
        Y(:,3) = sum(Trt_ses(:,:,3)')'*1.000;    
           x = max(max(abs(Y))) 
%             x=max(mas)
            for k=1:3; Y(:,k) = Y(:,k)./x;end        
%    figure; title('Eicycle spectrum in logit dynamics system');hold on
        for k=1:3
        figure; 
            plot(Y(:,k),'linewidth',2,'Color',cols(k,:));ylim([-1 1]*1.2)
                set(gca,'looseInset',[0 0 0 0],'fontsize',12,'linewidth',2) ;box on;grid on;
                set(gcf,'position',[200+k*10,200+k*20,680,195])
                hl=legend(leg(k));set(hl,'box','off');
%                 if k<3; set(gca,'xtick','');else;set(gca,'xtick',[20:20:119]); end
                saveas(gcf,strcat(ofilehead, '_eic_trt_', num2str(k), '.png'))
        end
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

 
