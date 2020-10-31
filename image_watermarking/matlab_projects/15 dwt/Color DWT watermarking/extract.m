clc
close all

%host

rgbimage=imread('host.jpg');
figure;imshow(rgbimage);title('original color image');
[h_LL,h_LH,h_HL,h_HH]=dwt2(rgbimage,'haar');
dec2d = [... 
        h_LL,     h_LH;     ... 
        h_HL,     h_HH      ... 
        ];
figure,imshow(uint8(dec2d));title('DWT2 of original color image');


%watermark

rgbimage=imread('watermarked.jpg');
figure;imshow(rgbimage);title('Watermark image');
[w_LL,w_LH,w_HL,w_HH]=dwt2(rgbimage,'haar');
dec2d = [... 
        w_LL,     w_LH;     ... 
        w_HL,     w_HH      ... 
        ];
figure,imshow(uint8(dec2d));title('DWT2 of Watermark image');

%watermarked

rgbimage=imread('watermarked.jpg');
figure;imshow(rgbimage);title('Watermarked image');
[wm_LL,wm_LH,wm_HL,wm_HH]=dwt2(rgbimage,'haar');
dec2d = [... 
        wm_LL,     wm_LH;     ... 
        wm_HL,     wm_HH      ... 
        ];
figure,imshow(uint8(dec2d));title('DWT2 of Watermarked image');

%watermarking

newwatermark_LL= (wm_LL-h_LL)/0.30;

%output

rgb2=idwt2(newwatermark_LL,w_LH,w_HL,w_HH,'haar');
figure;imshow(uint8(rgb2));title('Extracted watermark');
imwrite(uint8(rgb2),'EWatermark.jpg');




% M=512;
% N=512;
% X=imresize(uint8('Watermark.jpg'), [M N]);
% Y=imresize(uint8('EWatermark.jpg'), [M N]); 
% cc = corr2(X,Y);
% disp(cc);