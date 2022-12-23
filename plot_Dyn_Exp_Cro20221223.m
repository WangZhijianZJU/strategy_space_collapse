ofilehead == needed  

if ofilehead == 'Exp'     
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

AX = Acc_3page_logit(:,1:8,1);AY = Acc_3page_logit(:,9:16,1);  %2,6;  2,4
BX = Acc_3page_logit(:,1:8,2);BY = Acc_3page_logit(:,9:16,2);  %1; 4
CX = Acc_3page_logit(:,1:8,3);CY = Acc_3page_logit(:,9:16,3);  %1,2,5; 2,4

figure;Ax_2 = AX - AX(:,2);plot(Ax_2, 'linewidth',2); legend on;xlim([0 300]); ylim([-1000 500]); title('AX_2'); 
figure;Ax_6 = AX - AX(:,6);plot(Ax_6, 'linewidth',2); legend on;xlim([0 300]); ylim([-1000 500]);title('AX_6');
figure;Ay_2 = AY - AY(:,2);plot(Ay_2, 'linewidth',2); legend on;xlim([0 300]); ylim([-1000 500]);title('AY_2');
figure;Ay_4 = AY - AY(:,4);plot(Ay_4, 'linewidth',2); legend on;xlim([0 300]); ylim([-1000 500]);title('AY_6');

figure;Bx_2 = BX - BX(:,1);plot(Bx_2, 'linewidth',2); legend on;xlim([0 300]); ylim([-1000 500]); title('BX_1');   
figure;By_4 = BY - BY(:,4);plot(By_4, 'linewidth',2); legend on;xlim([0 300]); ylim([-1000 500]);title('BY_4');

figure;Cx_1 = CX - CX(:,1);plot(Cx_1, 'linewidth',2); legend on;xlim([0 300]); ylim([-1000 500]);title('CX_1');
figure;Cx_2 = CX - CX(:,2);plot(Cx_2, 'linewidth',2); legend on;xlim([0 300]); ylim([-1000 500]); title('CX_2'); 
figure;Cx_5 = CX - CX(:,6);plot(Cx_5, 'linewidth',2); legend on;xlim([0 300]); ylim([-1000 500]);title('CX_5');
figure;Cy_2 = CY - CY(:,2);plot(Cy_2, 'linewidth',2); legend on;xlim([0 300]); ylim([-1000 500]);title('CY_2');
figure;Cy_4 = CY - CY(:,4);plot(Cy_4, 'linewidth',2); legend on;xlim([0 300]); ylim([-1000 500]);title('CY_4');
