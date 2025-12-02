%% Читаем
bytes = fileread('text');
bytes = reshape(dec2bin(double(bytes),8)',1,[]);

disp(bytes)

%% Меняем биты на звук

[y1,fs1]=audioread("sample1.wav");
[y2,fs2]=audioread("sample2.wav");

out = [];

for i = 1:length(bytes)
    if bytes(i) == 0
        out = [out; y1];
    else
        out = [out; y2];
    end
end

audiowrite('out.wav', out, 44100);

[in, fs] = audioread('out.wav');

% В отчете показать, что прочитали бинарником, показать, что заменили на сэмплы, получили звук, затем этот файл обратно читаем, пропуск через хкорр, декод, показать, что оно совпадает
