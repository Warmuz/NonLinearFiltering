photo=imread('test3.jpg');
A = rgb2gray(photo);
grey2 = rgb2gray(photo);

maskrow = 15;
maskcol = 15;
h = ones(maskrow,maskcol)/25;

point = size(h,1)/2-0.5;

s1 = size(h,1)/2+0.5; %row
s2 = size(h,2)/2+0.5; %column
k = 10;

% F = imnoise(I,'gaussian',0,0.025);
F = imnoise(A,'salt & pepper',0.1);
K = A ;
K(:,1:(2)) = [];
K((1:2),:) = [];
%LUM

for row = (s1):size(F,1)-(s1)
    for col = (s2):size(F,2)-(s2)
        B = F((row-s1+1):(row+s1-1),(col-s2+1):(col+s2-1));
        x0 = B(s1,s2); 
        C = sort(reshape(B,1,[]));
        median = C(size(C,2)/2+0.5);
        l = C((size(C,2)/2+0.5)-k);
        u = C((size(C,2)/2+0.5)+k);
        
        if x0>l
            x0=l;
        end
        if x0<u
            x0=u;
        end
         D(row-1,col-1) = x0;
    end
end

subplot(4,1,1);
imshow(F);
title('Noise');
subplot(4,1,2);
imshow(D);
title('LUM');
ylabel(psnr(D,K));

%Median

for row = (s1):size(F,1)-(s1)
    for col = (s2):size(F,2)-(s2)
        G = F((row-s1+1):(row+s1-1),(col-s2+1):(col+s2-1));
        H = sort(reshape(G,1,[]));
        median = H(size(H,2)/2+0.5);
        I(row-1,col-1) = median;
    end
end

subplot(4,1,3);
imshow(I);
title('Median');
ylabel(psnr(I,K));

%Linear
for row = (point+1):size(F,1)-(point+1)
    for col = (point+1):size(F,2)-(point+1)
        grey2(row,col)=conv2(F((row-point):(row+point),(col-point):(col+point)),h, 'valid')/sum(h,'all');
    end
end

linear = psnr(grey2,A);


subplot(4,1,4);
imshow(grey2);
title('Linear');
ylabel(linear);