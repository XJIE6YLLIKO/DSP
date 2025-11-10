pkg load signal

% Чтение аудиофайла
[y, fs] = audioread("sounds/song.wav");
y = mean(y, 2);  % Конвертируем в моно, если стерео

% Параметры фильтра (используем оригинальный fs)
f_low = 14e3;
f_high = f_low+2e3;
order = 1;

% Нормализованные частоты для фильтра Баттерворта
wn = [f_low, f_high] / (fs / 2);

% Создание коэффициентов режекторного (notch/stop) фильтра
[b, a] = butter(order, wn, 'stop');

% Применение фильтра в домене времени (фильтрация нулевой фазы для избежания искажений)
y_filtered = filtfilt(b, a, y);


[msg, msg_fs] = audioread("sounds/msg.wav");
msg = mean(msg, 2);
msg = resample(msg, 441e2, 48e3);

msg = repmat(msg, 1, ceil(length(y) / length(msg)))(1:length(y));


% Опционально: визуализация спектра до и после (раскомментируйте для графика)
N = length(y);
f = linspace(-fs/2,fs/2, length(y));
Y_orig = abs(fftshift(fft(y)));
Y_filt = abs(fftshift(fft(y_filtered)));
MSG = abs(fftshift(fft(msg)));

figure(1);
subplot(3,1,1); plot(f, Y_orig); title('Оригинальный спектр'); xlabel('Частота (Гц)'); ylabel('Амплитуда (дБ)'); xlim([-fs/2 fs/2]);
subplot(3,1,2); plot(f, Y_filt); title('Спектр после фильтрации'); xlabel('Частота (Гц)'); ylabel('Амплитуда (дБ)'); xlim([-fs/2 fs/2]);
subplot(3,1,3); plot(f, MSG); title('Спектр msg'); xlabel('Частота (Гц)'); ylabel('Амплитуда (дБ)'); xlim([-fs/2 fs/2]);

% Запись отфильтрованного аудио
audiowrite("song_out.wav", y_filtered, fs);
