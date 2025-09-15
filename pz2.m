pkg load signal

fid = fopen('text.txt', 'rb');
data = fread(fid, 'uint8')
%data = dec2bin(data)
fclose(fid);
data1="";
for i=1:length(data)
  data1=strcat(data1,dec2bin(data(i),8))
end

res=[];
[y1,fs1]=audioread("sample1.wav");
[y2,fs2]=audioread("sample2.wav");

for i=1:length(data1)
  if data1(i)=="1"
    res=[res;y1];
  else
    res=[res;y2];
  end
end

audiowrite("res.wav", res, fs1)

half_decoded=(xcorr(y1,res)-xcorr(y2,res));
figure;
plot(res)
figure;
plot((xcorr(y1,res)-xcorr(y2,res)))

figure;
positives=half_decoded>16.5;
plot(positives)
title("positives");
figure;
negatives=half_decoded<-16;
plot(negatives)
title("negatives");

out_data=[];
for i=1:length(half_decoded)
  if positives(i)==1
    out_data=[out_data;1];
  end
  if negatives(i)==1
    out_data=[out_data;0];
  end
end 

out_data=reshape(out_data, 1, [])
pause
