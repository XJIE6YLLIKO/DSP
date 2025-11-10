pkg load signal

[y,fs]=audioread("song.wav");
y=mean(y,2);
t=0:1/fs:(length(y)-1)*(1/fs);
f=linspace(-fs/2,fs/2, length(y));
Y=fftshift(fft(y));
% plot(f,Y)
% Y(abs(f)<=2e3)*=10;
% Y(abs(f)>2e3)=0;

% Параметры
fs = 1000;
f_low = 150;
f_high = 250;
order = 4;

% Создание режекторного фильтра
wn = [f_low, f_high] / (fs/2);
[b, a] = butter(order, wn, 'stop');

% Анализ
freqz(b, a, 1024, fs);
title('Режекторный фильтр 150-250 Гц');



y=ifft(ifftshift(Y));
audiowrite("song_out.wav",y,fs);
