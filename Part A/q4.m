clear; clc;

%% Section A
[x, fs] = audioread('SunshineSquare.wav');

window = hamming(1024);  % window function
noverlap = 512;  % overlap between windows
nfft = 2048;  % FFT size

[S, F, T] = spectrogram(x, window, noverlap, nfft, fs);

%plot before remove the noises
figure;
imagesc(T, F, 20*log10(abs(S)));
axis xy; 
colorbar; 
colormap(jet);
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Spectrogram of Original Signal');

%finding the noises by looking at the spectrogram graph
freqs=[30 , 1575 , 3150 , 4725];

% convert frequencies to discrete-time frequencies (w)
dw = 2*pi/nfft;
to_w = freqs * dw; %multiply each freq to convert to discrete time

disp("Sinusoidal frequencies (Hz):");
disp(freqs);
disp("Sinusoidal frequencies (w):");
disp(to_w);

%% Section B

%we found the formula by mathematical calc on notebook
As = -2*cos(2*pi*freqs/fs);
for j = 1:length(freqs)
    fprintf("Frequency %d Hz: A = %f\n", freqs(j), As(j));
end

%% Section D
total_mag=1;
empty_slot=[];
for i = 1:length(As)
    local_h=[1 As(i) 1];
    figure;
    freqz(local_h, 1, empty_slot ,fs);
    total_mag= conv(total_mag,local_h);
    title(sprintf('Filter for %d Hz sinusoidal signal', freqs(i)));
end

%% Section E
figure;
freqz(total_mag, 1, empty_slot ,fs);
title(sprintf('Total Magnitudes'));

%% Section F
y=x;
for i=1:length(As)
    h1=[1 As(i) 1];
    y = conv(y,h1);
end


%% Section G - plots the spectrograms
% Spectrogram of filtered signal
[S_filt, F_filt, T_filt] = spectrogram(y, window, noverlap, nfft, fs);
figure;
imagesc(T_filt, F_filt, 20*log10(abs(S_filt)));
axis xy;
colorbar;
colormap(jet);
title('Spectrogram of Filtered Signal');
xlabel('Time (s)');
ylabel('Frequency (Hz)');

%before filtering
%sound(x, fs);
%sound off
%after filtering
sound(y, fs);
