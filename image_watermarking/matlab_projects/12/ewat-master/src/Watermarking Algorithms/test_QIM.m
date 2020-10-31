function test_QIM(delta)
clc;
image = imread('Lena.tif');

layer = image(:,:,1);

message = '00110011';

key = '11111111';

blocksize = 8;
%delta = 6;

wm_layer = embed_QIM(layer,delta,blocksize,message,key);
wm = detect_QIM(wm_layer,delta,blocksize,key)

%figure;imshow(wm_layer);
%figure;imshow(layer);


