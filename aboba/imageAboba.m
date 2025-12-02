image = imread('aboba.bmp');
% найти картинку, СДЕЛАТЬ ЧБ, применить линейную фильтрацию к каждой
% отнормировать матрицу: матрица = матрица - мин(мин(матрица)); 
% матрица = матрица ./ макс(макс(на парковке))
% отдельной строке массива (ФНЧ с разной шириной) и смотрим разницу пикч

figure(1)
imshow(image);

pass = 0.1;
stop = 0.15;

image2 = rgb2gray(image);
image2 = double(image2);

image2 = image2 - min(image2,[],'all');
image2 = image2 ./ max(image2,[],'all');
figure(2)
imshow(image2);

filt = designfilt('lowpassfir','PassbandFrequency',pass,'StopbandFrequency',stop,'PassbandRipple',1,'StopbandAttenuation',60);
for i = 1:length(image2)
    image3(i,:) = filter(filt.Numerator,1, image2(i,:));
end
% for i = 1:width(image2)
%     image2(:,i) = filter(filt.Numerator,1, image2(:,i));
% end


figure(3)
imshow(image3);

filt2 = designfilt('highpassfir','PassbandFrequency',stop,'StopbandFrequency',pass,'PassbandRipple',1,'StopbandAttenuation',1.5);
for i = 1:length(image2)
    image4(i,:) = filter(filt2.Numerator,1, image2(i,:));
end

figure(4)
imshow(image4);


image5 = image2 .^ 0.5;
image6 = image2 .^ 2;

figure(5)
imshow(image5);
figure(6)
imshow(image6);

image7 = sin(pi .* image2);
figure(7)
imshow(image7)

lines = imread('lines.bmp');
lines = rgb2gray(lines);
lines = double(lines);


for i=1:height(image2)
   image8(i,:) = conv(image2(i,:),lines(i,:)); 
end
image8 = image8 ./ max(image8, [], 'all');
figure(8)
imshow(image8)
figure(9)
imshow(lines)

tri = imread('tri.bmp')';
tri = double(tri);
for i=1:height(image2)
   image9(i,:) = conv(image2(i,:),tri(i,:)); 
end
image9 = image9 ./ max(image9, [], 'all');
figure(10)
imshow(image9)
figure(11)
imshow(tri)

star = imread('star.bmp')';
star = double(star);
for i=1:height(image2)
   image10(i,:) = conv(image2(i,:),star(i,:)); 
end
image10 = image10 ./ max(image10, [], 'all');
figure(12)
imshow(image10)
figure(13)
imshow(star)
