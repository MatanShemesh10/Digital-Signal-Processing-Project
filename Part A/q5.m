clear;clc

[x_n,fs]=audioread("x.wav");
%sound(x_n,fs);

%% Section A
eachSec=length(x_n)/20; %be knowing the sound is 20 sec.
x_n_new=zeros(20,eachSec);
index=1;
for i=1:eachSec:length(x_n)
    x_n_new(index,:)=x_n(i:i+eachSec-1);
    index=index+1;
end

%% Section B
X_DFT=zeros(20,round(eachSec*0.1));
LEN=length(x_n_new(:,1));
for i=1:LEN
    temp=fft(x_n_new(i,:));
    temp=temp(1:(length(temp)/10));
    X_DFT(i,:)=temp;
end

%% Section C
x1_n=zeros(size(x_n));
for i=1:LEN
    temp=X_DFT(i,:);
    dft_full = zeros(1,eachSec);
    dft_full(1:length(temp))=temp; %avoid the zeros at the end
    one_restored=real(ifft(dft_full));
    x1_n((i-1)*eachSec+1:i*eachSec) = one_restored;
end

%% Section D
N = (0:length(x_n)-1)/fs;
figure;
subplot(2,1,1);
plot(N, x_n);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Signal x[n]');
subplot(2,1,2);
plot(N, x1_n);
xlabel('Time (s)');
ylabel('Amplitude');
title('Restored Signal x1[n]');

X_DFT_MG = abs(fft(x_n));
X1_DFT_MG = abs(fft(x1_n));
f = (0:length(X_DFT_MG)-1)*fs;
figure;
subplot(2,1,1);
plot(f, X_DFT_MG);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude of DFT of x[n]');
subplot(2,1,2);
plot(f, X1_DFT_MG);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude of DFT of x1[n]');

%Play the signals
% sound(x_n, fs);
% pause(length(x_n)/fs);
%sound(x1_n, fs);
clear sound

%% Section E
e_n=x_n-x1_n;
E_DFT_MG = abs(fft(e_n));
f = (0:length(E_DFT_MG)-1)*fs;
N = (0:length(e_n)-1)/fs;
figure;
subplot(2,1,1);
plot(N, e_n);
xlabel('Time (s)');
ylabel('Amplitude');
title('Error signal e[n]');
subplot(2,1,2);
plot(f, E_DFT_MG);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude of DFT of e[n]');

%Play the signals
%sound(x_n, fs);
%sound(x1_n, fs);
%sound(e_n, fs);
%clear sound
%sound(x1_n, fs);

