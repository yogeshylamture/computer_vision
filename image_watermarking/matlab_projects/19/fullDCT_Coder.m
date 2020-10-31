% author: Piotr Lenarczyk;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% program is provided "as is", with no guarantee and copyrights, 
% feel free to use; for citation please use:
%P. Lenarczyk and Z. Piotrowski,
%"Novel Hybrid Blind Digital Image Watermarking in Cepstrum and DCT Domain", 
%2010 International Conference on Multimedia Information Networking and Security,
%Nanjing, Jiangsu, 2010, pp. 356-361. Doi: 10.1109/MINES.2010.81
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Watermarking algorithm program, which is embedding additional information in
% frequency domain of Digital Cosine Transform 2 - Dimensional ( DCT2D II ).
clc; 
clear all; 
close all;
% load image; 
% load signal; 
warning( 'off', 'all' ); %for MATLAB comment
hostName = 'lena.jpg';
host = imread( hostName );
host = double( rgb2ycbcr( host ) );
hostY = host( :, :, 1 );
watermarkedName = 'wm.jpg';
%%%%% Attack example - image compression with JPEG Q=0 quality coefficient
watermarkedSaveQ = 100;  

spectrumY = dct2( hostY );
watermark_coordinates = 2;
watermark_energy = 200;
inf_bit_Orig = [ 1 0 0 1 1 ]; 
dlmwrite( 'inf_bit_Orig.mat', inf_bit_Orig );

for ii = 1 : length( inf_bit_Orig )
    if inf_bit_Orig( ii ) == 1
        spectrumY( ii + ( watermark_coordinates - 1 ), ii + ( watermark_coordinates - 1 ) ) ...
          = abs( spectrumY( ii + ( watermark_coordinates - 1 ), ...
          ii + ( watermark_coordinates - 1 ) ) ) + watermark_energy;
    end
   if inf_bit_Orig( ii ) == 0  
        spectrumY( ii + ( watermark_coordinates - 1 ), ii + ( watermark_coordinates - 1 ) ) ...
          = -abs( spectrumY( ii + ( watermark_coordinates - 1 ), ...
          ii + ( watermark_coordinates - 1 ) ) ) - watermark_energy;
    end
end
watermarked = idct2( spectrumY );
host( :, :, 1 ) = watermarked;
watermarked = ycbcr2rgb( uint8( host ) );
imwrite( watermarked, watermarkedName, 'Quality', watermarkedSaveQ );

host = imread( hostName );
wm = imread( watermarkedName );
if size( host, 1 ) == size( wm, 1 )
    if size( host, 2 ) == size( wm, 2 )
        disp( [ 'PSNR: ', num2str( psnr( host, wm ) ), '[dB]' ] );
    end
end
figure(); imshow( imread( hostName ) );
title( "Host image" );
figure(); imshow( imread( watermarkedName ) );
title( "Watermarked image" );

fullDCT_Decoder
