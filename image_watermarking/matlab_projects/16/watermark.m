function y= watermark(A,B)
%{
A=Original image;
B=Watermark image;

 Example:
watermark('E:\watermark\lena.png','E:\watermark\wm.png')
%}
host=imread('m1.jpg');
[m n p]=size(host);
subplot(1,3,1)
imshow(host);
title('Original Image');
[host_LL,host_LH,host_HL,host_HH]=dwt2(host,'haar');
water_mark=imread('low_key.jpg');
water_mark=imresize(water_mark,[m n]);

subplot(1,3,2)
imshow(water_mark)
title('Watermark');
[water_mark_LL,water_mark_LH,water_mark_HL,water_mark_HH]=dwt2(water_mark,'haar');
water_marked_LL = host_LL + (0.03*water_mark_LL);
watermarked=idwt2(water_marked_LL,host_LH,host_HL,host_HH,'haar');
subplot(1,3,3)
imshow(uint8(watermarked));
title('Watermarked image');
imwrite(uint8(watermarked),'Watermarked.png');
y='Watermarked succesfully';
end