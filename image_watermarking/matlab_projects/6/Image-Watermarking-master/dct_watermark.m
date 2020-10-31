clear all;
clc;
% read image
Image = imresize(imread('medium_key.jpg'),[512 ,512]);

load key; %load key.mat file containing locations at which to embed
load watermark; %load watermark.mat file

% DCT transform
DCTImage = dct2(Image);

% Inverse wavelet transform
Reconstructed_Image = idct2(transform(DCTImage,w,key));

% Write image
imwrite(uint8(round(Reconstructed_Image)),'watermarked_image_DCT.png');

function dctTransformed = transform(DCTImage,w,key)
a = 10; % Watermark strength
for i=1:3000
    % Get locations from key
    row_number=key(i,1); column_number=key(i,2);
    
    % Get current coefficient
    coefficient_DCT=DCTImage(row_number,column_number);
    
    % Coefficinet equation
    Q_coefficient_DCT=coefficient_DCT+(a*w(i));
    
    % Place coefficient which hides watermark back in DCT image
    DCTImage(row_number,column_number)=Q_coefficient_DCT;
end
dctTransformed=DCTImage;
end
