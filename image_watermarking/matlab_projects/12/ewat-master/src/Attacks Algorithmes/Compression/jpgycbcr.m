function [YCbCr_image] = jpgycbcr( RGB_image )

RGB_double = double(RGB_image);
T = [0.299,0.587,0.114;-0.168736,-0.331264,0.5,;0.5,-0.418688,-0.081312];

Y = T(1).*RGB_double(:,:,1) + T(4).*RGB_double(:,:,2) + T(7).*RGB_double(:,:,3);
Cb = 128+ (T(2).*RGB_double(:,:,1) + T(5).*RGB_double(:,:,2) + T(8).*RGB_double(:,:,3));
Cr = 128 + (T(3).*RGB_double(:,:,1) + T(6).*RGB_double(:,:,2) + T(9).*RGB_double(:,:,3));

YCbCr_image = uint8(cat(3,Y,Cb,Cr));

%figure;imshow(YCbCr_ori);
%figure;imshow(YCbCr_image);

%[RGB_image] = jpgrgb( YCbCr_image );

%debug = 1;
%YCbCr_image = uint8(YCbCr_double);

