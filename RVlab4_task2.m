photo=imread('test3.jpg');
A = rgb2gray(photo);


h = ones(15,15)/200;

s1 = size(h,1)/2+0.5; %row
s2 = size(h,2)/2+0.5; %column



for row = (s1):size(A,1)-(s1)
    for col = (s2):size(A,2)-(s2)
        B = A((row-s1+1):(row+s1-1),(col-s2+1):(col+s2-1));
        C = sort(reshape(B,1,[]));
        median = C(size(C,2)/2+0.5);
        D(row,col) = median;
    end
end

subplot(3,1,1);
imshow(A);
title('Orginal');
subplot(3,1,2);
imshow(D);
title('My median filter');
J = medfilt2(A, [s1, s2]);
subplot(3,1,3);
imshow(J);
title('medfilt2');



%with mask of vector
%
% mask = 11;
% 
% I = imnoise(A,'salt & pepper',0.02);
% 
% it = (mask/2)+0.5;
% sizemask = (mask/2)-0.5;
% for i = 1:size(A,1)
%     for j = it:size(A,2)-it
%         C = sort(A(i,j-sizemask:j+sizemask));
%         D(i,j-sizemask) = C(size(C,2)-1);
%     end
% end

