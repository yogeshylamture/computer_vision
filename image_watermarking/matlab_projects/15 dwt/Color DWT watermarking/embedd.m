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

rgbimage=imread('watermark.jpg');
figure;imshow(rgbimage);title('Watermark image');
[w_LL,w_LH,w_HL,w_HH]=dwt2(rgbimage,'haar');
dec2d = [... 
        w_LL,     w_LH;     ... 
        w_HL,     w_HH      ... 
        ];
figure,imshow(uint8(dec2d));title('DWT2 of Watermark image');

%watermarking

newhost_LL = h_LL + (0.30*w_LL);

%output

rgb2=idwt2(newhost_LL,h_LH,h_HL,h_HH,'haar');
figure;imshow(uint8(rgb2));title('Watermarked image');
imwrite(uint8(rgb2),'Watermarked.jpg');