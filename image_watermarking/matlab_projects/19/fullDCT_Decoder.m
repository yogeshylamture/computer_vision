% author: Piotr Lenarczyk;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% program is provided "as is", with no guarantee and copyrights, 
% feel free to use; for citation please use:
%P. Lenarczyk and Z. Piotrowski,
%"Novel Hybrid Blind Digital Image Watermarking in Cepstrum and DCT Domain", 
%2010 International Conference on Multimedia Information Networking and Security,
%Nanjing, Jiangsu, 2010, pp. 356-361. Doi: 10.1109/MINES.2010.81
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Watermarking algorithm program, which is extracting additional information
% from watermarked image in frequency domain of Digital Cosine Transform 2D.
clear all;
% pkg load image; pkg load signal; 
warning( 'off', 'all' );%for MATLAB comment
inf_bit_Orig = dlmread( 'inf_bit_Orig.mat' );
watermark_coordinates = 2;
watermarked = imread( 'wm.jpg' );
watermarked = rgb2ycbcr( watermarked );
watermarkedY = double( watermarked( :, :, 1 ) );

spectrumY = dct2( watermarkedY );
inf_bit_decoded = zeros( 1, length( inf_bit_Orig ) );
for i = watermark_coordinates : ( watermark_coordinates + ( length( inf_bit_Orig ) - 1 ) )
    if spectrumY( i, i ) >= 0
          inf_bit_decoded( i - ( watermark_coordinates - 1 ) ) = 1;
    end
    if spectrumY( i, i ) < 0
          inf_bit_decoded( i - ( watermark_coordinates - 1 ) ) = 0;
    end
end

BER = 0;
for i = 1 : length( inf_bit_Orig )
    if inf_bit_decoded( i ) ~= inf_bit_Orig( i )
        BER = BER + 1;
    end
end
disp( [ 'BER: ', num2str( 100 * BER / length( inf_bit_Orig ) ), '[%]' ] );
