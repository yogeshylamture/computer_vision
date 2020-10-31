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
% from watermarked image in cepstrum domain
clear all;
% pkg load image; pkg load signal; 
warning( 'off', 'all' );%for MATLAB comment
watermarked = imread( 'wm.jpg' );
decoding_treshold = 5; %originally for [1000x1000] pix images tresh = 16
watermarked = rgb2ycbcr( watermarked );
watermarkedY = double( watermarked( :, :, 1 ) );
watermarkedY = watermarkedY .^ 2;

cepstY = ifft2( abs( log( fft2( watermarkedY ) ) ) );
cepstY = abs( cepstY( 4 : 7, 4 : 7 ) .^ 3 );
[ y x ] = find( cepstY == max( max( cepstY ) ) );
max_value = cepstY( y, x );    %high value if there is added Y translated copy 
matrix_mean = abs( mean( mean( cepstY ) ) );

if matrix_mean * decoding_treshold < max_value
    disp( 'Decoding decision above treshold - image watermarked:' )
    xDetect = x + 3 - 1; %omits DC cepstr { spec( spec( Y ) ) }
    yDetect = y + 3 - 1;
    % originally embedded additional information:
    translation_x = dlmread( 'translation_x.mat' );
    translation_y = dlmread( 'translation_y.mat' );
    if translation_x != xDetect
        disp( 'Decoding error.' )
    elseif translation_y != yDetect
        disp( 'Decoding error.' )
    else 
        disp( 'BER: 0[%]' )
    end
end

 figure(); plot( cepstY );
 title( 'ifft2( ab( log( fft2( watermarked ) ) ) )' );
