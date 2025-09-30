t=linspace(0,2,1001);
Fd=1/(t(2)-t(1));
f=linspace(-Fd/2,Fd/2,length(t));
sig=cos(2*pi*1/.5*t).^2;

figure(1);
plot(t,sig);

spec=fftshift(fft(sig));
figure(2);
plot(f,spec);

sig2=sig;
sig2(mod(round(t*1000)/1000,1/11)!=0)=0;
figure(3);
plot(t,sig2);

spec2=fftshift(fft(sig));
figure(4);
plot(f,spec2);

pause
