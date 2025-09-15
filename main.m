figure(1)
% subplot(2, 3, 1)
[y1,fs1]=audioread("щелчок.wav");
y1=y1(1:4000);
y1=y1*1.4;
plot(y1)
xlim([0 length(y1)])
title("Звук 1")
grid on
length(y1)

figure(2)
% subplot(2, 3, 2)
[y2,fs2]=audioread("вав.wav");
y2=y2(5001:9000);
plot(y2)
xlim([0 length(y2)])
title("Звук 2")
grid on
length(y2)

figure(3)
% subplot(2, 3, 4)
[R1, lags1] = xcorr(y1);
plot(lags1, R1)
title("АКФ 1")
grid on
xlim([min(lags1) max(lags1)])

figure(4)
% subplot(2, 3, 5)
[R2, lags2] = xcorr(y2);
plot(lags2, R2)
title("АКФ 2")
grid on
xlim([min(lags2) max(lags2)])

figure(5)
% subplot(2, 3, 6)
[R3, lags3] = xcorr(y1, y2);
plot(lags3, R3)
title("ВКФ")
grid on
xlim([min(lags3) max(lags3)])
