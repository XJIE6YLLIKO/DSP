pkg load signal

[y1,fs]=audioread("sample1.wav");
[y2,fs]=audioread("sample2.wav");
[y3,fs]=audioread("res_.wav");

plot(res, 'Color', 'black')
title('Перезаписанное сообщение')
xlim([0 length(res)])

half_decoded=(xcorr(y3,y1)-xcorr(y3,y2));
half_decoded=half_decoded(length(half_decoded)/2:end);
half_decoded=half_decoded/max(half_decoded);
for i=2:length(half_decoded)-1
  if not(and(half_decoded(i-1)<half_decoded(i),half_decoded(i+1)<half_decoded(i),half_decoded(i)>0.5))
    half_decoded(i)=0;
  end
end
half_decoded=half_decoded>0.7;

first_peak=find(half_decoded,1);

decoded=[];
for i=first_peak:length(y1):length(half_decoded)
  if sum(half_decoded(i-200:i+200))>=1
    decoded=[decoded,0];
  else
    decoded=[decoded,1];
  end

end
decoded=sprintf("%d",decoded);
decoded=decoded(1:floor(length(decoded)/8)*8);
decoded=reshape(decoded,8,[]);
decoded=decoded';
decoded=char(bin2dec(decoded));
decoded=decoded'

pause
