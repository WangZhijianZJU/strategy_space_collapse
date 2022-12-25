% 20221225   
% ofilehead == 'Exp'
% ofilehead == 'Dyn'
function r = plot_Dyn_Exp_Cro20221223(ofilehead)
%% ----------------------------------------------------------------------------------------------------------------%%

                                      p=[6 8 10];             leg ={'(2,1)', '(3,2)', '(4,2)'}; if ofilehead == 'Exp'     
    load('eicycle.mat')  % experimental result   
    Acc_3page=[];
    for k=1:3;
        n8x8list_4 = n8x8list_3(n8x8list_3(:,9)==p(k),:);
        n8x8list_4=sortrows(n8x8list_4, [3 9 1 5 4]);
        r0=[];
            for t=1:1000
                r1 = n8x8list_4(n8x8list_4(:,3)==t,:);
                r0=[r0; sum(r1(:,11:26))];
                    if t==1
                        Acc_3page(t,:,k) = r0;
                    else
                        Acc_3page(t,:,k) = sum(r0);
                    end
            end
     end
 %% ----------------------------------------------------------------------------------------------------------------%% 
 else if ofilehead == 'Dyn'
    load('J_dyn_202212.mat','R36000x35Logit', 'eicyclelogit','Acc_3page_logit')            
            Acc_3page = Acc_3page_logit;
     end
 end  
 %% ----------------------------------------------------------------------------------------------------------------%% 

AX = Acc_3page(:,1:8,1);AY = Acc_3page(:,9:16,1);  % X = 2,6;  Y = 2,4
BX = Acc_3page(:,1:8,2);BY = Acc_3page(:,9:16,2);  % X = 1; Y = 4
CX = Acc_3page(:,1:8,3);CY = Acc_3page(:,9:16,3);  % X = 1,2,5; Y = 2,4
% AAA
figure;Ax_2 = AX - AX(:,2);plot(Ax_2, 'linewidth',2); legend('1','2','3','4','5','6','7','8');xlim([0 300]); ylim([-1000 500]); title('AX_2'); xlim([0,80]);ylim([-15,50])
    aAx_2=listCrossover(6,1,2,Ax_2)
figure;Ax_6 = AX - AX(:,6);plot(Ax_6, 'linewidth',2); legend('1','2','3','4','5','6','7','8');xlim([0 300]); ylim([-1000 500]);title('AX_6'); xlim([0,250]);ylim([-80,120])
    aAx_6=listCrossover(6,1,6,Ax_6)
figure;Ay_2 = AY - AY(:,2);plot(Ay_2, 'linewidth',2); legend('1','2','3','4','5','6','7','8');xlim([0 300]); ylim([-1000 500]);title('AY_2');
    aAy_2=listCrossover(6,2,2,Ay_2)
figure;Ay_4 = AY - AY(:,4);plot(Ay_4, 'linewidth',2); legend('1','2','3','4','5','6','7','8');xlim([0 300]); ylim([-1000 500]);title('AY_6');
    aAy_4=listCrossover(6,2,4,Ay_4) 
% BBB    
figure;Bx_1 = BX - BX(:,1);plot(Bx_1, 'linewidth',2); legend('1','2','3','4','5','6','7','8');xlim([0 300]); ylim([-1000 500]); title('BX_1');   
    aBx_2=listCrossover(8,1,1,Bx_1)
figure;By_4 = BY - BY(:,4);plot(By_4, 'linewidth',2); legend('1','2','3','4','5','6','7','8');xlim([0 300]); ylim([-1000 500]);title('BY_4');
    aBy_4=listCrossover(8,2,4,By_4)
% CCC
figure;Cx_1 = CX - CX(:,1);plot(Cx_1, 'linewidth',2); legend('1','2','3','4','5','6','7','8');xlim([0 300]); ylim([-1000 500]);title('CX_1');
    aCx_1=listCrossover(10,1,1,Cx_1)
figure;Cx_2 = CX - CX(:,2);plot(Cx_2, 'linewidth',2); legend('1','2','3','4','5','6','7','8');xlim([0 300]); ylim([-1000 500]); title('CX_2'); 
    aCx_2=listCrossover(10,1,2,Cx_2)
figure;Cx_5 = CX - CX(:,5);plot(Cx_5, 'linewidth',2); legend('1','2','3','4','5','6','7','8');xlim([0 300]); ylim([-1000 500]);title('CX_5');
    aCx_5=listCrossover(10,1,5,Cx_5)
figure;Cy_2 = CY - CY(:,2);plot(Cy_2, 'linewidth',2); legend('1','2','3','4','5','6','7','8');xlim([0 300]); ylim([-1000 500]);title('CY_2');
    aCy_2=listCrossover(10,2,2,Cy_2)
figure;Cy_4 = CY - CY(:,4);plot(Cy_4, 'linewidth',2); legend('1','2','3','4','5','6','7','8');xlim([0 300]); ylim([-1000 500]);title('CY_4');
    aCy_4=listCrossover(10,2,4,Cy_4)
    b=[aAx_2; aAx_6; aAy_2; aAy_4; aBx_2; aBy_4; aCx_1; aCx_2; aCx_5; aCy_2; aCy_4];
    save('CrossOver')
    cross = latex2MxWithMxPrecision(b, 3)
end


function a=listCrossover(trt,pop,strategy,Ax_t)
    a=[];for k=1:8; for j=40:1:999
        if Ax_t(j-1,k)>= 0  &  Ax_t(j,k)<0 
            a=[a;trt,pop,strategy, k,j, Ax_t(j-1,k),Ax_t(j,k),Ax_t(j+1,k)]; 
        end
    end;end 
        if size(a,1) > 0
            a=sortrows(a,[5]);
        end
end

