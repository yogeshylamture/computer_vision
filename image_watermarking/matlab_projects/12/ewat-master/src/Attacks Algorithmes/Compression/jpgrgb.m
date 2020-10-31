function [RGB_image] = jpgrgb( YCbCr_image )

YCbCr_double = double(YCbCr_image);

R = YCbCr_double(:,:,1) + 1.402.*(YCbCr_double(:,:,3)-128);
G = YCbCr_double(:,:,1) - 0.34414.*(YCbCr_double(:,:,2)-128)- 0.71414.*(YCbCr_double(:,:,3)-128);
B = YCbCr_double(:,:,1) + 1.772.*(YCbCr_double(:,:,2)-128);

RGB_image = uint8(cat(3,R,G,B));



