function  [ Yret3,mn,am_eigencycleDim_t, mean_x,std_x] = from_N_colExp_out_am(dos_x_t,NE)
% am_eigencycleDim_t has 
% function  [ Yret3 mn] = from_N_colExp_out_am(a_0,NE)
% 
%     a_0=load('D:\M\Binmore_2.csv');
%     a_0=load(filenameYQM);
       if nargin < 2
           NE = mean(dos_x_t); 
       end 
       mean_x = NE;
       std_x =  std(dos_x_t);
         Ndim=length(dos_x_t(1,:));
        sum_am_rr=[];
        inst_am_rr =[]; %T-1 raws, N*(N-1)/2 column
    for m=1:Ndim-1
        for n=m+1:Ndim
                x=dos_x_t(:,m);
                y=dos_x_t(:,n); 
                L=[0,0,0];
                inst_am_tmp=[];
            for j=1:1:length(dos_x_t(:,1))-1
                 x1=(x(j+1)-NE(m));
                 y1=(y(j+1)-NE(n));
                 x0=(x(j)-NE(m));
                 y0=(y(j)-NE(n));
                 detx=x1-x0;
                 dety=y1-y0;
                 inst_am=cross([x0,y0,0],[detx,dety,0]);
                 inst_am_tmp=[inst_am_tmp; inst_am(3)];
                 L=L+inst_am(3); 
            end
                sum_am_rr=[sum_am_rr;L(3)];
                inst_am_rr =[inst_am_rr inst_am_tmp]; 
        end
    end
%     Yret1 = angle; 
% output 
    Yret3 = sum_am_rr;
        mn=[];
        for m=1:Ndim-1
        for n=m+1:Ndim
            mn=[mn; m n];
        end
        end
    am_eigencycleDim_t = inst_am_rr;
end