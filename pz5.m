pkg load signal

[y1, fs] = audioread("sounds/song.wav");
y1 = mean(y1, 2);
[y2, fs] = audioread("sounds/Master_Of_Puppets.mp3");
y2 = mean(y2, 2);
y1 = y1(1:idivide(min(length(y1),length(y2)),int32(10)));
y2 = y2(1:length(y1));

f_low = 0;
f_high = f_low+3e3;
order = 1;
wn = [f_low, f_high] / (fs / 2);
[b, a] = butter(order, wn, "low");

y1_filt=filter(b,a,y1);
y2_filt=filter(b,a,y2);

t=linspace(0,(length(y1)-1)*1/fs,length(y1));
f = linspace(-fs/2,fs/2, length(y1));

for i=1:length(y1)
  y1_shifted(i)=y1_filt(i)*cos(2*pi*t(i)*10e3)*2;
  y2_shifted(i)=y2_filt(i)*sin(2*pi*t(i)*10e3)*2;
end

y=y1_shifted+y2_shifted;
truefft = @(x) fftshift(fft(x))./length(x);

figure(1);
subplot(2,3,1); plot(f, abs(truefft(y1)), 'Color', 'black'); title('Cпектр песни 1'); xlabel('Частота (Гц)'); ylabel('Амплитуда'); xlim([0 fs/2]);
subplot(2,3,2); plot(f, abs(truefft(y2)), 'Color', 'black'); title('Cпектр песни 2'); xlabel('Частота (Гц)'); ylabel('Амплитуда'); xlim([0 fs/2]);
subplot(2,3,4); plot(f, abs(truefft(y1_shifted)), 'Color', 'black'); title('Cпектр песни 1(ФНЧ, сдвиг)'); xlabel('Частота (Гц)'); ylabel('Амплитуда'); xlim([0 fs/2]);
subplot(2,3,5); plot(f, abs(truefft(y2_shifted)), 'Color', 'black'); title('Cпектр песни 2(ФНЧ, сдвиг)'); xlabel('Частота (Гц)'); ylabel('Амплитуда'); xlim([0 fs/2]);
subplot(2,3,6); 
plot(f, imag(truefft(y))); 
hold on;
plot(f, real(truefft(y))); 
legend("квадратурная часть", "синфазная часть")
title('Полученный спектр'); xlabel('Частота (Гц)'); ylabel('Амплитуда'); xlim([0 fs/2]);

audiowrite("minecraft.mp3", y, fs);


for i=1:length(y1)
  y1_out(i)=y(i)*cos(2*pi*t(i)*10e3)*2;
  y2_out(i)=y(i)*sin(2*pi*t(i)*10e3)*2;
end

y1_out=filter(b,a,y1_out);
y2_out=filter(b,a,y2_out);

audiowrite("sounds/minecraft1.mp3", y1_out, fs);
audiowrite("sounds/minecraft2.mp3", y2_out, fs);
