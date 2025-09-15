pkg load signal

[y1,fs]=audioread("sample1.wav");
[y2,fs]=audioread("sample2.wav");
[y3,fs]=audioread("res.wav");

sample_rate=1/((1/fs)*(length(y1)-1))

half_decoded=(xcorr(y3,y1)-xcorr(y3,y2));
half_decoded=half_decoded(length(half_decoded)/2:end);
figure;
t=0:1/fs:(length(half_decoded)-1)*(1/fs);
plot(t,half_decoded)

figure;
f=linspace(-fs/2,fs/2, length(half_decoded));
sig=zeros(1,length(t));
for i=1:length(t)
  sig(i)=half_decoded(i)*cos(2*pi*2*sample_rate*t(i));
end
spec=fftshift(fft(sig));
spec(abs(f)>.5*sample_rate)=0;

plot(f,abs(spec))

sig=real(ifft(ifftshift(spec)));
sig=round(sig/max(sig));
decoded=(sig>(max(sig)/2)) .* (cos(2*pi*sample_rate*t)==1)-(sig<=(max(sig)/2)) .* (cos(2*pi*sample_rate*t)==1);
figure;
%hold on
%plot(t,half_decoded)
hold on
plot(t,sig)
%hold on
%plot(t,2*(sig>max(sig)/2) .* (round(cos(pi*sample_rate*t)*10)/10==0))
%hold on
%plot(t,sin(2*pi*sample_rate*t))
hold on
plot(t,decoded)
hold on
plot(t,.5* (cos(2*pi*sample_rate*t)==1))
decoded(end-3)

%figure;
%plot(t,sig)
%hold on
%plot(t,sig,t,sig>0.9*max(sig))
%hold on
%plot(t,-(sig<-0.6))


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
