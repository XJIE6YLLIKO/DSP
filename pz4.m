pkg load signal

% Чтение аудиофайла
[y, fs] = audioread("sounds/song.wav");
y = mean(y, 2);  % Конвертируем в моно, если стерео

% Параметры фильтра (используем оригинальный fs)
f_low = 14e3;
f_high = f_low+2e3;
order = 1;

wn = [f_low, f_high] / (fs / 2);
[b, a] = butter(order, wn, 'stop');

y_filtered = filter(b, a, y);

[msg, msg_fs] = audioread("sounds/msg.wav");
msg = mean(msg, 2);
msg = resample(msg, 441e2, 48e3);
msg = [msg;zeros(length(y)-length(msg),1)];


f_low = 1e3;
f_high = f_low+2e3;
order = 3;

wn = [f_low, f_high] / (fs / 2);
[b,a]=butter(order, wn);
msg_filtered = filter(b, a, msg);
t=linspace(0,(length(y)-1)*1/fs,length(y));

N = length(y);
f = linspace(-fs/2,fs/2, length(y));
Y_orig = abs(fftshift(fft(y)));
Y_filt = abs(fftshift(fft(y_filtered)));
MSG = abs(fftshift(fft(msg)));
MSG_filt = abs(fftshift(fft(msg_filtered)));

out=zeros(length(y),1);
for i=1:length(y)
  out(i)=y_filtered(i)+msg_filtered(i).*cos(2*pi*13e3*t(i)).*2;
end
OUT = abs(fftshift(fft(out)));

figure(1);
subplot(2,3,1); plot(f, Y_orig, 'Color', 'black'); title('Оригинальный спектр'); xlabel('Частота (Гц)'); ylabel('Амплитуда'); xlim([0 fs/2]);
subplot(2,3,4); plot(f, Y_filt, 'Color', 'black'); title('Спектр после фильтрации'); xlabel('Частота (Гц)'); ylabel('Амплитуда'); xlim([0 fs/2]);
subplot(2,3,2); plot(f, MSG, 'Color', 'black'); title('Спектр msg'); xlabel('Частота (Гц)'); ylabel('Амплитуда'); xlim([0 fs/2]);
subplot(2,3,5); plot(f, MSG_filt, 'Color', 'black'); title('Спектр msg после фильтра'); xlabel('Частота (Гц)'); ylabel('Амплитуда'); xlim([0 fs/2]);
subplot(2,3,6); plot(f, OUT, 'Color', 'black'); title('Спектр out'); xlabel('Частота (Гц)'); ylabel('Амплитуда'); xlim([0 fs/2]);

audiowrite("song_out.wav", out, fs);

f_low = 14e3;
f_high = f_low+2e3;
order = 1;

wn = [f_low, f_high] / (fs / 2);
[b, a] = butter(order, wn);
msg_shifted = filter(b, a, out);

msg_out=zeros(length(y),1);
for i=1:length(y)
  msg_out(i)=msg_shifted(i).*cos(2*pi*13e3*t(i)).*10;
end

audiowrite("msg_out.wav",msg_out,fs);
