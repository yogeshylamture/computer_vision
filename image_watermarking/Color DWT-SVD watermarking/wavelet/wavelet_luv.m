clc
close all

%host

rgbimage=imresize(imread('m1.jpg'),[512 512]);
figure;
imshow(rgbimage);
title('Original color image');
%ycbcr=rgb2ycbcr(r1gbimage);
[h_LL,h_LH,h_HL,h_HH]=dwt2(rgbimage,'db2');
img=h_LL;
red1=img(:,:,1)+img(:,:,2)+img(:,:,3);
green1=(-2)*img(:,:,1)+img(:,:,2)+img(:,:,3);
blue1=(-1)*img(:,:,2)+img(:,:,3);

[U_imgr1,S_imgr1,V_imgr1]= svd(red1);
[U_imgg1,S_imgg1,V_imgg1]= svd(green1);
[U_imgb1,S_imgb1,V_imgb1]= svd(blue1);

%watermark

rgbimage=imresize(imread('babow5.png'),[512 512]);
figure;
imshow(rgbimage);
title('Watermark image');
%ycbcr=rgb2ycbcr(rgbimage);
[w_LL,w_LH,w_HL,w_HH]=dwt2(rgbimage,'db2');
img_wat=w_LL;
red2=img_wat(:,:,1)+img_wat(:,:,2)+img_wat(:,:,3);
green2=(-2)*img_wat(:,:,1)+img_wat(:,:,2)+img_wat(:,:,3);;
blue2=(-1)*img_wat(:,:,2)+img_wat(:,:,3);
[U_imgr2,S_imgr2,V_imgr2]= svd(red2);
[U_imgg2,S_imgg2,V_imgg2]= svd(green2);
[U_imgb2,S_imgb2,V_imgb2]= svd(blue2);


% watermarking

S_wimgr=S_imgr1+(0.10*S_imgr2);
S_wimgg=S_imgg1+(0.10*S_imgg2);
S_wimgb=S_imgb1+(0.10*S_imgb2);


wimgr = U_imgr1*S_wimgr*V_imgr1';
wimgg = U_imgg1*S_wimgg*V_imgg1';
wimgb = U_imgb1*S_wimgb*V_imgb1';


nwimgr=(1/3)*wimgr-2*(1/6)*wimgg;
nwimgg=(1/3)*wimgr+(1/6)*wimgg-(1/2)*wimgb;
nwimgb=(1/3)*wimgr+(1/6)*wimgg+(1/2)*wimgb;
wimg=cat(3,nwimgr,nwimgg,nwimgb);
newhost_LL=wimg;

%output

rgb2=idwt2(newhost_LL,h_LH,h_HL,h_HH,'db2');
%imwrite(uint8(rgb2),'Watermarked.jpg');
I=uint8(rgb2);
%I=ycbcr2rgb(I);
imwrite(I,'Watermarked.jpg');
figure;imshow(I);title('Watermarked Image');