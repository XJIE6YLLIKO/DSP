pkg load signal

[y1,fs]=audioread("sample1.wav");
[y2,fs]=audioread("sample2.wav");
[y3,fs]=audioread("res.wav");


half_decoded=(xcorr(y1,y3)-xcorr(y2,y3));
figure;
t=0:1/fs:(length(half_decoded)-1)*(1/fs);
plot(t,half_decoded)

figure;
f=linspace(-fs/2,fs/2, length(half_decoded));
spec=fftshift(fft(half_decoded));
spec(abs(f)>11)=0;
plot(f,abs(spec))
sig=ifft(ifftshift(spec));
figure;
plot(t,half_decoded,t,sig)
figure;
plot(t,sig,t,sig>0.9*max(sig))
figure;
plot(t,sig,t,(sig<-0.6))


%figure;
%positives=half_decoded>16.5;
%plot(positives)
%title("positives");
%figure;
%negatives=half_decoded<-16;
%plot(negatives)
%title("negatives");
%
%out_data=[];
%for i=1:length(half_decoded)
%  if positives(i)==1
%    out_data=[out_data;1];
%  end
%  if negatives(i)==1
%    out_data=[out_data;0];
%  end
%end 
%
%out_data=reshape(out_data, 1, [])
pause
