pkg load signal

figure(1)
subplot(2, 3, 1)
[y1,fs1]=audioread("щелчок.wav");
y1=y1(1:4000);
y1*=1.4;
plot(y1, 'Color', 'black')
xlim([0 length(y1)])
title("звук 1")
grid on
length(y1)

subplot(2, 3, 2)
[y2,fs2]=audioread("вав.wav");
y2=y2(5001:9000);
plot(y2, 'Color', 'black')
xlim([0 length(y2)])
title("звук 2")
grid on
length(y2)

subplot(2, 3, 4)
[R1, lags1] = xcorr(y1);
plot(lags1, R1, 'Color', 'black')
title("АКФ 1")
grid on
xlim([min(lags1) max(lags1)])

subplot(2, 3, 5)
[R2, lags2] = xcorr(y2);
plot(lags2, R2, 'Color', 'black')
title("АКФ 2")
grid on
xlim([min(lags2) max(lags2)])

subplot(2, 3, 6)
[R3, lags3] = xcorr(y1, y2);
plot(lags3, R3, 'Color', 'black')
title("ВКР")
grid on
xlim([min(lags3) max(lags3)])

audiowrite("sample1.wav", y1, fs1);
audiowrite("sample2.wav", y2, fs2);
pause
