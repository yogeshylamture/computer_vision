% author: Piotr Lenarczyk;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% program is provided "as is", with no guarantee and copyrights, 
% feel free to use; for citation please use:
%P. Lenarczyk and Z. Piotrowski,
%"Novel Hybrid Blind Digital Image Watermarking in Cepstrum and DCT Domain", 
%2010 International Conference on Multimedia Information Networking and Security,
%Nanjing, Jiangsu, 2010, pp. 356-361. Doi: 10.1109/MINES.2010.81
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Watermarking algorithm program, which is embedding translated luminance copy 
% with reduced energy, to host digital image in spatial domain ( 2D signal ).
clc; clear all; close all;
% pkg load image; pkg load signal; 
warning( 'off', 'all' );%for MATLAB comment
hostName = 'lena.jpg';
host = imread( hostName );
translation_x = 4; dlmwrite( 'translation_x.mat', translation_x );
translation_y = 3; dlmwrite( 'translation_y.mat', translation_y );
watermark_energy = 0.78;
bit = -1;
host = double( rgb2ycbcr( host ) );
hostTranslation = translation( host, translation_x, translation_y );
watermarked = host;
watermarkedName = 'wm.jpg';
watermarkedSaveQ = 100;

for xx = 1 : translation_x
    for m = 1 : size( host, 1 );
        hostTranslation( m, xx, : ) = host( m, xx, : );
    end
end

for yy = 1 : translation_y
    for m = 1 : size( host, 2 );
        hostTranslation( yy, m, : ) = host( yy, m, : );
    end
end

for xx = ( size( host, 1 ) - translation_x ) : size( host, 1 )
    for m = 1 : size( host, 1 );
        hostTranslation( m, xx, : ) = host( m, xx, : );
    end
end 

for yy = ( size( host, 2 ) - translation_y ) : size( host, 2 )
    for m = 1 : size( host, 1 );
        hostTranslation( m, yy, : ) = host( m, yy, : );
    end
end

for y = 1 : size( host, 1 )
   for x = 1 : size( host, 2 )
        hostTranslation( y, x, 1 ) = hostTranslation( y, x, 1 ) ...
        - hostTranslation( y, x, 1 ) * watermark_energy; 
        %reduces watermark energy
   end
end

if ( bit <= 0 )
  for y = 1 : ( size( host, 1 )  )
      for x = 1 : ( size( host, 2 )  )
          watermarked( y , x , 1 ) = watermarked( y , x , 1 ) ...
          - hostTranslation( y ,x, 1 ) + watermarked( y , x , 1 ) ...
          * ( 1 - watermark_energy ); 
          %adding or substracting is an additional information bit
          %as a result the image is brigtened or darkened and slightly sharpened
     end
  end
end

if ( bit > 0 )
  for y = 1 : ( size( host, 1 )  )
      for x = 1 : ( size( host, 2 )  )
          watermarked( y , x , 1 ) = watermarked( y , x , 1 ) ...
          + hostTranslation( y, x, 1 ) - watermarked( y , x , 1 ) ...
          * ( 1 - watermark_energy - 0.1 ); 
          %adding or substracting is an additional information bit
          %as a result the image is brigtened or darkened and slightly sharpened
     end
  end
end

%%%%% Attack example - image cropping
%cropCoef = 0.05;
%watermarked = imcrop( watermarked, [ 10, 10, size( watermarked, 1 ) * cropCoef, ...
%                      size( watermarked, 2 ) * cropCoef ] );
%disp( [ 'removed ', num2str( 100 - 100 * cropCoef ), '% of watermarked image' ] );              
watermarked = ycbcr2rgb( uint8( watermarked ) );
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

cepstDecoder
