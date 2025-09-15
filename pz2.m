pkg load signal

fid = fopen('text.txt', 'rb');
data = fread(fid, 'uint8')
%data = dec2bin(data)
fclose(fid);
data1="";
for i=1:length(data)-1
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

figure;
plot(res)

figure;
half_decoded=(xcorr(res,y1)-xcorr(res,y2));
plot(half_decoded)

pause
