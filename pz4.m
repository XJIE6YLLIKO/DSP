[s, fs] = audioread("song.wav");
s = mean(s, 2);

S = fft(s);

figure(1)
area(abs(S));

ауы
