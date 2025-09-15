pkg load signal

fid = fopen('text.txt', 'rb');
data = fread(fid, 'uint8')
%data = dec2bin(data)
fclose(fid);
data1="";
for i=1:length(data)
  data1=strcat(data1,dec2bin(data(i)));
end
data1
data1(3)

res=[]
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


