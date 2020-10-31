%%% READ IMAGE THAT YOU WANT TO WATERMARK %%%
I = imresize(imread('medium_key.jpg'),[512 ,512]); %%%%%%%%%% Enter path for image
[rows, columns, dim] = size(I);
%%% ----------

%%% READ IMAGE THAT WILL BE THE MARK %%%
watermark = imread('low_key.jpg'); %%%%%%%%%% Enter path for image
watermark = imresize(watermark, [rows, columns]);
%%% ----------

%%% GET BITS %%%
BI = cell(1, 1);
sum = 0;
for i = 1:8
    BI{i} = bitget(I, i)*(2^(i-1));
    sum = sum + BI{i};
end
BW0 = bitget(watermark, 1);
%%% ----------

%%% CREATE WATERMARKED IMAGE %%%
marked = uint8(sum + BW0);
%imshow(marked);
imwrite(marked,'a.jpg');
%%% ----------

%%% SHOW 8 BIT PLANES OF MARKED IMAGE TO SHOW WATERMARK %%%
A = cell(1, 1);
for k = 1:8
    A{k} = double(bitget(marked, k));
    subplot(4, 2, k);
    imshow(A{k});
    title( ['Bit ' num2str(k)] );
end
%%% ----------