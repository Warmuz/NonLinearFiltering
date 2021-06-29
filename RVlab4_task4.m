photo=imread('test3.jpg');
A = rgb2gray(photo);

h = ones(15,15)/25;

s1 = size(h,1)/2+0.5; %row
s2 = size(h,2)/2+0.5; %column
k = 25;

%LUM

for row = (s1):size(A,1)-(s1)
    for col = (s2):size(A,2)-(s2)
        B = A((row-s1+1):(row+s1-1),(col-s2+1):(col+s2-1));
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
        D(row-(s1-1),col-(s2-1)) = x0;
    end
end

subplot(2,1,1)
imshow(A);
title('Orginal');
subplot(2,1,2)
imshow(D)
title('LUM');