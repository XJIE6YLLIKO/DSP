clear;
%% MSG
[m1, Fs] = audioread('sounds/song5.wav');
[m2, Fs] = audioread('sounds/song4.wav');

m1 = m1 / max(m1);
m2 = m2 / max(m2);

t = linspace(0, length(m1)*Fs, length(m1))';
t2 = linspace(0, length(m2)*Fs, length(m2))';

% Оставляем диапазон частот сообщения
filt2 = designfilt('lowpassfir', 'StopbandFrequency', 3100, 'PassbandFrequency', 3000, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'SampleRate', Fs);
m1 = filter(filt2.Numerator, filt2.Denominator, m1);
m2 = filter(filt2.Numerator, filt2.Denominator, m2);


% Перемещаем сообщение на частоту отверстия в песне 
m1 = m1 .* cos(2*pi*10000.*t);
m2 = m2 .* sin(2*pi*10000.*t2);

mx = max([length(m1) length(m2)]);
if length(m1) < mx
    m1 = paddata(m1, mx);
else
    m2 = paddata(m2, mx);
end
% Складываем аудио
ms = m1 + m2;
audiowrite('sounds/IQ.wav', ms, Fs);

%% DEC
% Возвращаем сообщение на оригинальную частоту
t3 = linspace(0, mx*Fs, mx)';
m1 = ms .* cos(2*pi*10000.*t3)*2;
m2 = ms .* sin(2*pi*10000.*t3)*2;

m1 = filter(filt2.Numerator, filt2.Denominator, m1);
m2 = filter(filt2.Numerator, filt2.Denominator, m2);

audiowrite('sounds/decoded.wav', m1, Fs);
audiowrite('sounds/decoded2.wav', m2, Fs);
