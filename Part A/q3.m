clear;clc;

%% Section B
T=1;
figure;
N_Indexs=[5,10,15,20];
for i=1:length(N_Indexs)
[t,e1,x_c,x_n,xhat]=clcElements(N_Indexs(i),T);
subplot(4,2,(i*2)-1)
h2 = plot(t, x_c, 'b');
hold on
h3 = plot(t, xhat, 'm');
legend([h2, h3] , {'x_c(t)', 'x_c^(t)'});
titleStr = sprintf('N = %d', N_Indexs(i));
title(titleStr);
hold on
subplot(4,2,i*2)
h1 = plot(t, e1, 'r');
legend('e1(t)')
title(titleStr);
end


%% Section C
errorVec=[];
for i=5:39
    [t,e1,x_c,x_n,xhat]=clcElements(i,1);
    LEN = length(e1);
    startIdx = round(LEN/3);
    endIdx = round(2*LEN/3);
    middleThird = e1(startIdx:endIdx);
    maxVal = max(middleThird);
    errorVec(i)=maxVal;
end
errorVec=errorVec(5:39);
N_range=5:39;
figure;
plot(N_range,errorVec);
title("Size of the error as a function of N");


function [t,e1,x_c,x_n,xhat] = clcElements (N,T) %for each N
t=linspace(0,N*T,50);
x_c = ones(size(t));
x_n=zeros(1,N+1);
for n=1:N+1
    x_n(n) = x_c(n*T);
end

[xhat,t]=DAC1 (x_n,N,T);
e1=x_c-xhat;
end


function [xhat,t] = DAC1 (x_n,N,T)
t=linspace(0,N*T,50);  %50 points at each sampling interval
xhat=zeros(1,length(t));
for i=1:length(t)
    for n=1:N+1
        temp=x_n(n)*sin(pi*(t(i)-(n-1)*T)/T) / (pi*(t(i)-(n-1)*T)/T);
        xhat(i)=xhat(i)+temp;
    end
end
end




