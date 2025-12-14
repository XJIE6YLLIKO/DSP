pkg load signal

filename = argv(){1}; 

img = imread(filename);
figure(1);
subplot(2,3,1)
imshow(img);
title('исходное изображение')
img = rgb2gray(img);

figure(1);
subplot(2,3,2)
imshow(img);
title('ч/б изображение')
img=double(img);

img = (img - double(min(min(img)))) ./ double(max(max(img))) ;

original=img;

figure(1);
subplot(2,3,3)
imshow(uint8(img.*255));
title('нормализованное изображение')

Wp=0.1;
Rp = 1; 
Rs = 1;
% [N, Wn] = ellipord(Wp, [], Rp, Rs);
% [b, a] = butter(6, 0.1, 'low');
% [b, a] = cheby1(3, 1, .1 , "low");
% [b, a] = ellip(2, 1, 10, [0 .1]);
[b, a] = cheby2(1, 15, .1, "low");
[h1, w1] = freqz (b, a);
figure(1)
subplot(2,3,4)
plot (w1./pi, h1, ";;")

for i=1:length(img)
  img(i,:) = filter(b, a, img(i,:));
end
% img(1,:)

figure(1);
subplot(2,3,5)
imshow(img);
title('ФНЧ изображение')


[b, a] = cheby2(1, 1, .1, "high");
% [b, a] = ellip(3, 1, 1, .1, "high");
[h2, w2] = freqz (b, a);
figure(1)
subplot(2,3,4)
title("фильтры в 'разах'")
hold on
plot (w2./pi, h2, ";;")
hold on
plot ((w1)./pi, h1.*h2, ";;")
ylabel('разы')
xlabel('нормированная частота')
grid on;
legend("LPF" , "HPF", 'LPF \cdot HPF')
% [b, a] = butter(6, 0.1, 'high');

for i=1:length(img)
  img(i,:) = filter(b, a, img(i,:))+img(i,:);
end
% img=img./max(max(img));

figure(1);
subplot(2,3,6)
imshow(img);
title('ФНЧ+ФНЧ \cdot ФВЧ изображение')



figure(2);

subplot(1,3,1);
imshow(sqrt(original));
title('img^{0.5}');

subplot(1,3,2);
imshow(original.^2);
title('img^2');

subplot(1,3,3);
imshow(sin(pi.*img));
title('sin(\pi\cdotimg)');

pause
