clc; clear;
%H(z)=1/4* (z^2-2^1.5*z+4)/(z^2);
%H(z)=(1 - 2*sqrt(2)*z^-1 + 4*z^-2) / 4;

%% Section A
% The Coefficients 
b = [1 , -2*sqrt(2) , 4];
a = [4, 0 ,0];
Magnitude_Map(b,a,'H(z)')

%% Section C
b_AP = [1 , -2*sqrt(2) , 4];
a_AP = [4, -2*sqrt(2) ,1];
Magnitude_Map(b_AP,a_AP,'H-AP(z)');

b_MP = [4 , -2*sqrt(2) , 1];
a_MP = [4, 0 ,0];
Magnitude_Map(b_MP,a_MP,'H-MP(z)');

function []= Magnitude_Map (b,a,name)
[H, w] = freqz(b, a); % the frequency response of H(z)
figure;
subplot (2,1,1);
plot(w, abs(H));
xlabel('Frequency');
ylabel('Magnitude');
title(sprintf('Magnitude Response of %s', name));
subplot (2,1,2);
zplane(b,a);
title(sprintf('Map of zeros and poles of %s', name));
end 





