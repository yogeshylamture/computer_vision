function y=ext_watermark(A,B,C)
%{
A=Original image;
B=Watermark image;
C=Watermarked image, The output image saved by watermark function;
 Example:
ext_watermark('E:\watermark\lena.png','E:\watermark\wm.png','E:\watermark\Watermarked.png')
%}
host=imread('m1.jpg');
[m n p]=size(host);
[host_LL,host_LH,host_HL,host_HH]=dwt2(host,'haar');
water_mark=imread('low_key.jpg');
water_mark=imresize(water_mark,[m n]);
[water_mark_LL,water_mark_LH,water_mark_HL,water_mark_HH]=dwt2(water_mark,'haar');
wm=imread('Watermarked.png');
[wm_LL,wm_LH,wm_HL,wm_HH]=dwt2(wm,'haar');
extracted_watermark= (wm_LL-host_LL)/0.03;
ext=idwt2(extracted_watermark,water_mark_LH,water_mark_HL,water_mark_HH,'haar');
figure
imshow(uint8(ext));
title('Extracted watermark');
end