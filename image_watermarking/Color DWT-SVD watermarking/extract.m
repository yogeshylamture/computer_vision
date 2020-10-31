clc
close all

%host
% 
rgbimage=imresize(imread('m1.jpg'),[512 512]);
figure;
imshow(rgbimage);
title('Original color image');
%ycbcr=rgb2ycbcr(rgbimage);
[h_LL,h_LH,h_HL,h_HH]=dwt2(rgbimage,'haar');
img=h_LL;
% red1=img(:,:,1);
% green1=img(:,:,2);
% blue1=img(:,:,3);
% [U_imgr1,S_imgr1,V_imgr1]= svd(red1);
% [U_imgg1,S_imgg1,V_imgg1]= svd(green1);
% [U_imgb1,S_imgb1,V_imgb1]= svd(blue1);

%watermark

% rgbimage=imresize(imread('babow5.png'),[512 512]);
% figure;
% imshow(rgbimage);
% title('Watermark image');
% ycbcr=rgb2ycbcr(rgbimage);
% [w_LL,w_LH,w_HL,w_HH]=dwt2(ycbcr,'haar');
% img_wat=w_LL;
% red2=img_wat(:,:,1);
% green2=img_wat(:,:,2);
% blue2=img_wat(:,:,3);
% [U_imgr2,S_imgr2,V_imgr2]= svd(red2);
% [U_imgg2,S_imgg2,V_imgg2]= svd(green2);
% [U_imgb2,S_imgb2,V_imgb2]= svd(blue2);

%watermarked

rgbimage=imread('Watermarked.jpg');

%Salt & Paper Noise Attack

%rgbimage = imnoise(rgbimage,'salt & pepper',0.01);

%Cropped attack

%rgbimage=imresize(imcrop(rgbimage,[200,200,200,200]),[512,512]);

%Rotate Attack

%rgbimage=imrotate(rgbimage,-10,'bilinear','crop');



figure;
imshow(rgbimage);
title('Watermarked image');
%ycbcr1=rgb2ycbcr(rgbimage);
[wm_LL,wm_LH,wm_HL,wm_HH]=dwt2(rgbimage,'haar');
img_w=wm_LL;
% red3=img_w(:,:,1);
% green3=img_w(:,:,2);
% blue3=img_w(:,:,3);
% [U_imgr3,S_imgr3,V_imgr3]= svd(red3);
% [U_imgg3,S_imgg3,V_imgg3]= svd(green3);
% [U_imgb3,S_imgb3,V_imgb3]= svd(blue3);

W1=(wm_LL-h_LL)/0.10;
% 
% S_ewatr=(S_imgr3-S_imgr1)/0.10;
% S_ewatg=(S_imgg3-S_imgg1)/0.10;
% S_ewatb=(S_imgb3-S_imgb1)/0.10;
% 
% ewatr = U_imgr2*S_ewatr*V_imgr2';
% ewatg = U_imgg2*S_ewatg*V_imgg2';
% ewatb = U_imgb2*S_ewatb*V_imgb2';
% 
% ewat=cat(3,ewatr,ewatg,ewatb);
% 
% newwatermark_LL=ewat;

%output

rgb2=idwt2(W1,w_LH,w_HL,w_HH,'haar');
figure;imshow(rgb2);
% I=uint8(rgb2);
% I=ycbcr2rgb(I);
imwrite(I,'EWatermark.jpg');title('Extracted Watermark');