photo=imread('test3.jpg');
A = rgb2gray(photo);
grey=rgb2gray(photo);
grey2=rgb2gray(photo);
grey3=rgb2gray(photo);
grey4=rgb2gray(photo);

h = ones(3,3)/25;

s1 = size(h,1)/2+0.5; %row
s2 = size(h,2)/2+0.5; %column

F = imnoise(grey3,'salt & pepper',0.2);

point = size(h,1)/2-0.5;

for row = (s1):size(F,1)-(s1)
    for col = (s2):size(F,2)-(s2)
        B = F((row-s1+1):(row+s1-1),(col-s2+1):(col+s2-1));
        C = sort(reshape(B,1,[]));
        median = C(size(C,2)/2+0.5);
        D(row-1,col-1) = median;
    end
end
E = padarray(D,[1 1],214);

for row = (point+1):size(F,1)-(point+1)
    for col = (point+1):size(F,2)-(point+1)
        grey2(row,col)=conv2(F((row-point):(row+point),(col-point):(col+point)),h, 'valid')/sum(h,'all');
    end
end

A(1,:) = [];
A(:,1) = [];

peaksnr1 = psnr(E,A);
peaksnr2 = psnr(grey2,grey4);

subplot(3,1,1);
imshow(F);
title('salt & pepper noise');

subplot(3,1,2);
imshow(E)
title('Non-linear filtering');
ylabel(peaksnr1);


subplot(3,1,3);
imshow(grey2);
title('Linear filtering');
ylabel(peaksnr2);


