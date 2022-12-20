
% XLS C:\Users\a\Desktop\J8x8\Dynamics\

% WZJ
% C:\Users\think\Desktop\tmp2\space-collapse-master\code\J_dyn_20221215.m 
function [R36000x35Logit eicyclelogit]= J_dyn_20221215()
% function [R36000x35Logit eicyclelogit]= plotK20190408Logit_12ses() 

% modify from function r = plotK20190408()

R36000x35Logit = []; % 72000 = 3parameter * 12session * 2player * 1000round
eicyclelogit = [];

Para = [2 1; 3 2; 4 2]; 
     r32=[];  
     dt=0.02; Lambda=50; totalStep = 1000;  
    figure
    
    for Pa=1:3
        Accu_P1 =0; Accu_P2=0;eicyclelogitMP=[];
        for times =1:12
            r = logit_dyn_090B20190408(payoff88(Para(Pa,1),Para(Pa,2)),Lambda,totalStep,dt);
                        Accu_P1= Accu_P1 + r(:,17:24)  %*subjectsNumber;
                        Accu_P2= Accu_P2 + r(:,25:32)  %*subjectsNumber;
                        R36000x35Logit = [R36000x35Logit; r [1:1000]' times*ones(1000,1) Pa*ones(1000,1)];
                        
                        [Yret3,mn] = from_N_colExp_out_am(r(800:end,1:16),mean(r(800:end,1:16)));
                        eicyclelogitMP  = [eicyclelogitMP Yret3  ]; 
        end
        Acc_3page_logit(:,:,Pa) = [Accu_P1 Accu_P2];
                        eicyclelogit = [eicyclelogit; eicyclelogitMP mn Pa*ones(120,1)]; 
        %     Accu_P1=r(:,17-16:24-16)*subjectsNumber;
        %     Accu_P2=r(:,25-16:32-16)*subjectsNumber;
                subplot(3,2,1+(Pa-1)*2);plot(Accu_P1,'linewidth',2);
                    title(strcat('X:  (',num2str(Para(Pa,:)),') \lambda = ',num2str(Lambda), '  dt = ',num2str(dt))) 
        %                     legend('1','2','3','4','5','6','7','8','Location','northwest');
                    xlim([0,1000]);ylim([0,8200]); axis square; 
                    %xlabel('Period','FontSize',15), ylabel('Accumulated Frequency','FontSize',15)
                subplot(3,2,2+(Pa-1)*2);plot(Accu_P2,'linewidth',2);
                    title(strcat('Y:  (',num2str(Para(Pa,:)),') \lambda = ',num2str(Lambda), '  dt = ',num2str(dt)))
        %                     legend('1','2','3','4','5','6','7','8','Location','northwest');
                    xlim([0,1000]);ylim([0,8200]); axis square; 
%                     xlabel('Period','FontSize',15) , ylabel('Accumulated Frequency')
        r32 =[r32; r(1000,:) Para(Pa,:) Lambda];
    end
    save('J_dyn_202212.mat','R36000x35Logit', 'eicyclelogit','Acc_3page_logit')

clear; 
load('J_dyn_202212.mat', 'eicyclelogit')
    figure; 
        plot(eicyclelogit(1:120,1:12),'DisplayName','eicyclelogit(1:120,1:12)');ylim([-10^-9 10^-9])
        figure
        plot(eicyclelogit(1+120:120+120,1:12),'DisplayName','eicyclelogit(1:120,1:12)');ylim([-10^-9 10^-9])
        figure
        plot(eicyclelogit(1+240:120+240,1:12),'DisplayName','eicyclelogit(1:120,1:12)');ylim([-10^-9 10^-9])

    figure; title('Eicycle spectrum in logit dynamics system');hold on
        plot(sum(eicyclelogit(1:120,1:12)')','linewidth',2);hold on
        plot(sum(eicyclelogit(1+120:120+120,1:12)')','linewidth',2);hold on
        plot(sum(eicyclelogit(1+240:120+240,1:12)')','linewidth',2); 
        ylim([-3*10^-9 3*10^-9]); 
        legend({'(1,2)','(3,2)','(4,2)'},'Location','southeast','NumColumns',3)
        ylabel('angular momentum'); xlabel('2-d subspace id number'); box on
        set(gca,'fontsize',12)
        

end


function anan=logit_dyn_090B20190408(A,Lambda,repeat,wlogit)
%%logit_dyn_0909(payoff88(2,1),6,100)  Pa=6;Lambda=0.48;totalStep=100;logit_dyn_090B(payoff88(Para(Pa,1),Para(Pa,2)),Lambda,totalStep,0.01);
%%logit_dyn_090B(payoff88(2,1),6,100)
%%anan=[p1-8 q9-16 p_sum17-24 q_sum25-32];

pay_a=A/6;
pay_b=-A'/6;
%%
%
%³õÊ¼
% p=[0.125,0.125,0.125,0.125,0.125,0.125,0.125,0.125];
% q=[0.125,0.125,0.125,0.125,0.125,0.125,0.125,0.125];

prand=rand(1,8);
qrand=rand(1,8);

p=prand/sum(prand);
q=qrand/sum(qrand);


Ua=zeros(1,8);
Ub=zeros(1,8);

p_sum=zeros(1,8);
q_sum=zeros(1,8); 

anan=[];

    for ri=1:repeat
        for i=1:8
            Ua(i)=sum(q.*pay_a(i,:));
            Ub(i)=sum(p.*pay_b(i,:));	
        end
        p_sum=p_sum+p;
        q_sum=q_sum+q;		

        c_a=exp(Lambda*Ua);
        c_b=exp(Lambda*Ub);

    %     p=c_a./sum(c_a)*0.1 + p.*0.9;
    %     q=c_b./sum(c_b)*0.1 + q.*0.9;
        p=c_a./sum(c_a)*wlogit + p.*(1-wlogit);
        q=c_b./sum(c_b)*wlogit + q.*(1-wlogit);

        anan=[anan;p q p_sum q_sum];
        
    end
end


function P=payoff88(n,m)

P=zeros(8,8);

Stra=zeros(8,3);

for i=0:7
    tem=dec2bin(i,3);
    Stra(i+1,1)=str2num(tem(1));
    Stra(i+1,2)=str2num(tem(2));
    Stra(i+1,3)=str2num(tem(3));
end

situa=[];
situa_n=0;
for i=1:3
    for j=1:3
        if i==j
            continue
        end
        situa=[situa;i j];
        situa_n=situa_n+1;
    end
end

for i=1:8%for Ann %ËãAnanµÄÊÕÒæ
    for j=1:8 %for Bob
        for k=1:situa_n
            if Stra(i,situa(k,1))==0
                P(i,j)=P(i,j)+sign(situa(k,1)-situa(k,2))*m;
            else
                if Stra(j,situa(k,2))==0
                    P(i,j)=P(i,j)+1;
                else
                    P(i,j)=P(i,j)+sign(situa(k,1)-situa(k,2))*n;
                end
            end
        end
    end
end


end

   
