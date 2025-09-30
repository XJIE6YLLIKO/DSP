pkg load signal

[y1,fs]=audioread("sample1.wav");
[y2,fs]=audioread("sample2.wav");
[y3,fs]=audioread("res_shit.wav");

sample_rate=1/((1/fs)*(length(y1)-1))

half_decoded=(xcorr(y3,y1)-xcorr(y3,y2));
half_decoded=half_decoded(length(half_decoded)/2:end);
half_decoded=half_decoded/max(half_decoded);
figure(1);
t=0:1/fs:(length(half_decoded)-1)*(1/fs);
plot(t,half_decoded)

% peaks=zeros(1,length(half_decoded));
% for i=2:length(peaks)-1
%   if and(half_decoded(i-1)<half_decoded(i),half_decoded(i)>half_decoded(i+1))
%     if half_decoded(i)>.5
%       peaks(i)=-1;
%     elseif and(.4<half_decoded(i),half_decoded(i)<.5)
%       peaks(i)=1;
%     end
%   end
% end
% hold on
% plot(t,peaks)
% pause

% hold on
% plot(t,(round(cos(pi*sample_rate*t)*10)/10==0))
% half_decoded=half_decoded>0.5;

figure(2);
f=linspace(-fs/2,fs/2, length(half_decoded));

sig=half_decoded;
% sig=zeros(1,length(t));

% for i=1:length(t)
%   sig(i)=half_decoded(i)*cos(2*pi*sample_rate*t(i));
% end

spec=fftshift(fft(sig));
% spec(abs(abs(f)-sample_rate)>.5*sample_rate)=0;
spec(round(abs(f))!=round(sample_rate))=0;

%spec=spec(abs(f-sample_rate)<=.5*sample_rate);
%f=linspace(-sample_rate/2,sample_rate/2,length(spec));
%% f=f(abs(f)<=.5*sample_rate);
%t=linspace(0,(1/fs)*(length(y3)-1),length(spec));

% spec(abs(f)<0.5*sample_rate)=0;

plot(f,abs(spec))
% pause

sig=real(ifft(ifftshift(spec)));
figure(3);
sig=sig/max(sig);
plot(t,sig)
hold on
plot(t,half_decoded)

pause
% hold on
% plot(t, -sin(pi*sample_rate*t))

% figure(31);
% plot(t,unwrap(angle(sig)))
sig=abs(round(sig/max(sig)));
figure(32);
plot(t,sig)
% sprintf('%d', sig)
pause

decoded=(sig>(max(sig)/2)) .* (cos(2*pi*sample_rate*t)==1)-(sig<=(max(sig)/2)) .* (cos(2*pi*sample_rate*t)==1);
% decoded=(sig>0) .* (cos(2*pi*sample_rate*t)==1)-(sig<=0) .* (cos(2*pi*2*sample_rate*t)==1);
figure(4);
%hold on
%plot(t,half_decoded)
hold on
plot(t,sig)
%hold on
%plot(t,2*(sig>max(sig)/2) .* (round(cos(pi*sample_rate*t)*10)/10==0))
% hold on
% plot(t,sin(2*pi*sample_rate*t))
hold on
plot(t,decoded)

out=[];
for i=1:length(decoded)
  if decoded(i)==1
    out=[out,1];
  end
  if decoded(i)==-1
    out=[out,0];
  end
end
out=out(1:end-1);
out = sprintf('%d', out)

% out = reshape(out,8,[])'
% length(out)/8
% char(bin2dec(out))'

%hold on
%plot(t,.5* (cos(2*pi*sample_rate*t)==1))
%decoded(end-3)

%figure(1);
%plot(t,sig)
%hold on
%plot(t,sig,t,sig>0.9*max(sig))
%hold on
%plot(t,-(sig<-0.6))


%figure(1);
%positives=half_decoded>16.5;
%plot(positives)
%title("positives");
%figure(1);
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
