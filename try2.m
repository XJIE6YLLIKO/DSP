%% Song
[y, Fs] = audioread('sounds/song.wav');
y = mean(y, 2);
t = linspace(0, Fs*length(y), length(y))';

stop1 = 19000;
stop2 = 19300;
pass1 = stop1-100;
pass2 = stop2+100;

filt = designfilt('bandstopfir','PassbandFrequency1',pass1,'StopbandFrequency1',stop1,'StopbandFrequency2',stop2,'PassbandFrequency2',pass2,'PassbandRipple1',1,'StopbandAttenuation',60,'PassbandRipple2',1,'SampleRate',Fs);

y_filt = filter(filt.Numerator, 1, y);


%% MSG
[msg, Fs2] = audioread('sounds/msg.wav');
msg = mean(msg, 2);
msg = resample(msg, Fs, Fs2);

filt2 = designfilt('bandpassfir', 'StopbandFrequency1', pass1, 'PassbandFrequency1', stop1, 'PassbandFrequency2', stop2, 'StopbandFrequency2', pass2, 'PassbandRipple', 1, 'StopbandAttenuation2', 60, 'SampleRate', Fs);
msg = paddata(msg, length(y_filt));
m = filter(filt2.Numerator, filt2.Denominator, msg);

m = m .* cos(pi*(stop1+stop2-wantedF*2).*t);

y_new = y_filt + m;

%% DEC
ms = filter(filt2.Numerator, filt2.Denominator, y_new);
mm = yn .* cos(pi*(pass1+pass2-wantedF*2).*t);

player = audioplayer(mm, Fs);

