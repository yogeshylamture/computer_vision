function B = translation( A, x, y )
%matrix translation with adding rows and cols- dodajac kolumny i wiersze
translation_x = x;
translation_y = y;
affine_coef = [1               0               0;
                   0               1               0;
                   translation_x  translation_y  1];
    
translation_affine = maketform( 'affine', affine_coef ); 
%A matrix size
B = imtransform( A, translation_affine,  'XData',[ 1 size( A, 2 ) + ...
    affine_coef( 3, 1 ) ],  'YData',[ 1 size( A, 1 ) + affine_coef( 3, 2 ) ] ); 
end
