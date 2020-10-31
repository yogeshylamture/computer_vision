%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                           Hogeschool Antwerpen                          %
%                Industriële Wetenschappen: Elektronica-ICT               %
%                      MultiMediaGroep - Watermarking                     %
%                                                                         %
%                                                                         %
%                             Masterthesis 4.2                            %
%                               Kevin Heylen                              %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%im_s: applies a shear to the image
%@im: image to apply shear
%@value: shear value

function attacked_im = shear_x_attack(im, value)
try
    tform = maketform('affine',[1 value 0; 0 1 0; 0 0 1]);
    attacked_im = imtransform(im,tform);
catch
    attacked_im = im;
end
    
