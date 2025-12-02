%% Song
[y, Fs] = audioread('sounds/song.wav');
y = mean(y, 2);
t = linspace(0, Fs*length(y), length(y))';

% Частоты, вырезаемые из спектра
stop1 = 17000;
stop2 = 19000;
pass1 = stop1-100;
pass2 = stop2+100;

% вырезаем частоты из песни
filt = designfilt('bandstopfir','PassbandFrequency1',pass1,'StopbandFrequency1',stop1,'StopbandFrequency2',stop2,'PassbandFrequency2',pass2,'PassbandRipple1',1,'StopbandAttenuation',60,'PassbandRipple2',1,'SampleRate',Fs);
y_filt = filter(filt.Numerator, 1, y);


%% MSG
[msg, Fs2] = audioread('sounds/msg2.wav');
msg = mean(msg, 2);
msg = resample(msg, Fs, Fs2);

% Центральная частота сообщения после фильтра
wantedF = 2000;

% Оставляем диапазон частот сообщения
filt2 = designfilt('bandpassfir', 'StopbandFrequency1', 1000, 'PassbandFrequency1', 1100, 'PassbandFrequency2', 2900, 'StopbandFrequency2', 3000, 'PassbandRipple', 1, 'StopbandAttenuation2', 60, 'SampleRate', Fs);

m2 = filter(filt2.Numerator, filt2.Denominator, msg);

% Согласовываем длину для сложения
m2 = paddata(m2, length(y_filt));

% Перемещаем сообщение на частоту отверстия в песне 
m = m2 .* cos(pi*(pass1+pass2-wantedF*2).*t);

% Складываем аудио
y_new = y_filt + m/50;

audiowrite('sounds/coded.wav', y_new, Fs);
%% DEC
% Оставляем диапазон частот
filt3 = designfilt('bandpassfir', 'StopbandFrequency1', pass1, 'PassbandFrequency1', stop1, 'PassbandFrequency2', stop2, 'StopbandFrequency2', pass2, 'PassbandRipple', 1, 'StopbandAttenuation2', 60, 'SampleRate', Fs);
ms = filter(filt3.Numerator, filt3.Denominator, y_new);

% Возвращаем сообщение на оригинальную частоту
mm = ms .* cos(pi*(pass1+pass2-wantedF*2).*t)*100;

audiowrite('sounds/decoded.wav', mm, Fs);
