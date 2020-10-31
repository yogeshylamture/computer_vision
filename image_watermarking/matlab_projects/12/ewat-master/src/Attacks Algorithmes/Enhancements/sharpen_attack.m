%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %  
%                           Hogeschool Antwerpen                          %
%                Industriële Wetenschappen: Elektronica-ICT               %
%                      MultiMediaGroep - Watermarking                     %
%                                                                         %
%                                                                         %
%                             Masterthesis 4.2                            %
%                               Kevin Heylen                             %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%sharpen: applies sharpening filter
%@im: image to sharpen
%@sharpenfactor: amount of sharpening

function im_sharp = sharpen_attack(im, sharpenFactor)
try
    h = fspecial('unsharp', sharpenFactor); 
    im_sharp = imfilter(im, h, 'replicate'); 
catch 
    im_sharp = im;
end